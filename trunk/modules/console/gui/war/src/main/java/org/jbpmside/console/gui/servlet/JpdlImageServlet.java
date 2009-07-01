package org.jbpmside.console.gui.servlet;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.Stroke;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jbpmside.console.gui.bean.NodeBean;
import org.jbpmside.console.gui.bean.TransitionBean;
import org.jbpmside.console.gui.geom.Line;
import org.jbpmside.console.gui.geom.LineDrawer;
import org.jbpmside.console.gui.geom.Rect;
import org.jbpmside.console.gui.support.JbpmTemplate;

import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import org.jbpm.api.Execution;
import org.jbpm.api.ExecutionService;
import org.jbpm.api.ProcessDefinition;
import org.jbpm.api.ProcessEngine;
import org.jbpm.api.ProcessInstanceQuery;
import org.jbpm.api.RepositoryService;
import org.jbpm.api.model.OpenExecution;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.context.ApplicationContext;

import org.springframework.web.context.support.WebApplicationContextUtils;


/**
 * 解析xml生成流程图.
 *
 * @author Lingo
 */
public class JpdlImageServlet extends HttpServlet {
    /** logger. */
    private static Logger logger = LoggerFactory.getLogger(JpdlImageServlet.class);

    /** buffer size. */
    public static final int BUFFER_SIZE = 1024;

    /** default pic size. */
    public static final int DEFAULT_PIC_SIZE = 48;

    /** default font size. */
    public static final int DEFAULT_FONT_SIZE = 12;

    /** rect offset. */
    public static final int RECT_OFFSET = 5;

    /** rect round. */
    public static final int RECT_ROUND = 20;

    /** default stroke color. */
    public static final Color DEFAULT_STROKE_COLOR = Color.decode(
            "#03689A");

    /** default stroke. */
    public static final Stroke DEFAULT_STROKE = new BasicStroke(2);

    /** default fill color. */
    public static final Color DEFAULT_FILL_COLOR = Color.decode("#F6F7FF");

    /** jbpm template. */
    private JbpmTemplate jbpmTemplate;

    /** @return JbpmTemplate. */
    private JbpmTemplate getJbpmTemplate() {
        if (jbpmTemplate == null) {
            ApplicationContext ctx = WebApplicationContextUtils
                .getWebApplicationContext(this.getServletContext());
            jbpmTemplate = (JbpmTemplate) ctx.getBean("jbpmTemplate");
        }

        return jbpmTemplate;
    }

    /**
     * 获得流程定义id.
     *
     * @param request request
     * @return Long
     */
    public Long getProcessDefinitionId(HttpServletRequest request) {
        try {
            return Long.valueOf(request.getParameter("id"));
        } catch (Exception ex) {
            return null;
        }
    }

    /**
     * 获得流程实例id.
     *
     * @param request request
     * @return String
     */
    public String getProcessInstanceId(HttpServletRequest request) {
        return request.getParameter("piId");
    }

    /**
     * 根据流程定义获得xml.
     *
     * @param request request
     * @return InputStream
     */
    public InputStream getXmlByProcessDefinition(
        HttpServletRequest request) {
        Long id = getProcessDefinitionId(request);

        if (id != null) {
            return this.getJbpmTemplate()
                       .getResourceFromProcessDefinition(id,
                "process.jpdl.xml");
        } else {
            return null;
        }
    }

    /**
     * 根据流程实例获得xml.
     *
     * @param request request
     * @return InputStream
     */
    public InputStream getXmlByProcessInstance(HttpServletRequest request) {
        String id = getProcessInstanceId(request);

        if (id != null) {
            return this.getJbpmTemplate()
                       .getResourceFromProcessInstance(id,
                "process.jpdl.xml");
        } else {
            return null;
        }
    }

    /**
     * 获得xml.
     *
     * @param request request
     * @return InputStream
     */
    public InputStream getXml(HttpServletRequest request) {
        InputStream inputStream = null;
        inputStream = getXmlByProcessDefinition(request);

        if (inputStream == null) {
            inputStream = getXmlByProcessInstance(request);
        }

        return inputStream;
    }

    /**
     * 获得bytes.
     *
     * @param request request
     * @return InputStream
     * @throws IOException io异常
     */
    public byte[] getBytes(HttpServletRequest request)
        throws IOException {
        InputStream is = getXml(request);

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] b = new byte[BUFFER_SIZE];
        int len = 0;

        while ((len = is.read(b, 0, BUFFER_SIZE)) != -1) {
            baos.write(b, 0, len);
        }

        baos.flush();

        byte[] bytes = baos.toByteArray();

        logger.info(new String(bytes));

        return bytes;
    }

    /**
     * 获得节点map.
     *
     * @param request request
     * @return Map
     * @throws IOException io异常
     * @throws DocumentException xml异常
     */
    public Map<String, NodeBean> getNodeMap(HttpServletRequest request)
        throws IOException, DocumentException {
        byte[] bytes = getBytes(request);
        Element root = DocumentHelper.parseText(new String(bytes))
                                     .getRootElement();
        Map<String, NodeBean> nodeMap = new LinkedHashMap<String, NodeBean>();

        for (Element elem : (List<Element>) root.elements()) {
            String type = elem.getQName().getName();
            String name = null;

            if (elem.attribute("name") != null) {
                name = elem.attribute("name").getValue();
            }

            String q = elem.attribute("g").getValue();
            String[] location = q.split(",");
            int x = Integer.parseInt(location[0]);
            int y = Integer.parseInt(location[1]);
            int w = Integer.parseInt(location[2]);
            int h = Integer.parseInt(location[3]);

            if (type.equals("start") || type.equals("decision")
                    || type.equals("end") || type.equals("end-cancel")
                    || type.equals("end-error") || type.equals("fork")
                    || type.equals("join")) {
                w = DEFAULT_PIC_SIZE;
                h = DEFAULT_PIC_SIZE;
            } else {
                x -= RECT_OFFSET;
                y -= RECT_OFFSET;
                w += (RECT_OFFSET * 2);
                h += (RECT_OFFSET * 2);
            }

            NodeBean node = new NodeBean();
            node.setType(type);
            node.setName(name);
            node.setX(x);
            node.setY(y);
            node.setW(w);
            node.setH(h);
            nodeMap.put(name, node);

            for (Element transition : (List<Element>) elem.elements()) {
                String nodeName = transition.getQName().getName();
                String transitionName = null;

                if (transition.attribute("name") != null) {
                    transitionName = transition.attribute("name").getValue();
                }

                if (!"transition".equals(nodeName)) {
                    continue;
                }

                String to = transition.attribute("to").getValue();
                node.addTransition(transitionName, to);
            }
        }

        logger.info("{}", nodeMap);

        return nodeMap;
    }

    /**
     * 计算图片的大小.
     *
     * @param nodeMap Map
     * @return rect
     */
    public Rect getPicRect(Map<String, NodeBean> nodeMap) {
        Rect rect = new Rect();

        for (Map.Entry<String, NodeBean> entry : nodeMap.entrySet()) {
            NodeBean node = entry.getValue();

            if ((node.getW() + node.getX()) > rect.getW()) {
                rect.setW(node.getW() + node.getX());
            }

            if ((node.getH() + node.getY()) > rect.getH()) {
                rect.setH(node.getH() + node.getY());
            }
        }

        rect.setW(rect.getW() + 10);
        rect.setH(rect.getH() + 10);

        return rect;
    }

    /**
     * 处理get请求.
     *
     * @param request request
     * @param response response
     * @throws IOException io异常
     * @throws ServletException servlet异常
     */
    public void doGet(HttpServletRequest request,
        HttpServletResponse response) throws IOException, ServletException {
        try {
            Map<String, NodeBean> nodeMap = getNodeMap(request);
            Rect picRect = getPicRect(nodeMap);
            BufferedImage bi = new BufferedImage(picRect.getW(),
                    picRect.getH(), BufferedImage.TYPE_4BYTE_ABGR);
            Graphics2D g2 = bi.createGraphics();
            g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
                RenderingHints.VALUE_ANTIALIAS_ON);

            for (Map.Entry<String, NodeBean> entry : nodeMap.entrySet()) {
                String name = entry.getKey();
                NodeBean node = entry.getValue();
                String picName = node.getPicName();

                if (picName != null) {
                    BufferedImage bi2 = ImageIO.read(this.getClass()
                                                         .getResourceAsStream(picName));
                    g2.drawImage(bi2, node.getX(), node.getY(), null);
                } else {
                    int x = node.getX() + RECT_OFFSET;
                    int y = node.getY() + RECT_OFFSET;
                    int w = node.getW() - (RECT_OFFSET * 2);
                    int h = node.getH() - (RECT_OFFSET * 2);
                    g2.setColor(DEFAULT_FILL_COLOR);
                    g2.fillRoundRect(x, y, w, h, RECT_ROUND, RECT_ROUND);
                    g2.setColor(DEFAULT_STROKE_COLOR);
                    g2.setStroke(DEFAULT_STROKE);
                    g2.drawRoundRect(x, y, w, h, RECT_ROUND, RECT_ROUND);

                    Font font = new Font("宋体", Font.PLAIN,
                            DEFAULT_FONT_SIZE);
                    g2.setFont(font);

                    FontRenderContext frc = g2.getFontRenderContext();
                    Rectangle2D r2 = font.getStringBounds(name, frc);
                    logger.info("{}", r2);

                    double xx = node.getX()
                        + ((node.getW() - r2.getWidth()) / 2);
                    double yy = (node.getY()
                        + ((node.getH() - r2.getHeight()) / 2))
                        - r2.getY();
                    g2.drawString(name, (int) xx, (int) yy);
                }

                for (TransitionBean transition : node.getTransitions()) {
                    String transitionName = transition.getName();
                    String to = transition.getTo();
                    NodeBean toNode = nodeMap.get(to);

                    Line line = node.getCrossLine(toNode);

                    if (line != null) {
                        LineDrawer drawer = new LineDrawer(line.getX1(),
                                line.getY1(), line.getX2(), line.getY2());
                        drawer.draw(g2, 1F);

                        int cx = ((line.getX1() + line.getX2()) / 2)
                            - (transitionName.length() * 4);
                        int cy = ((line.getY1() + line.getY2()) / 2) - 10;
                        g2.drawString(transitionName, cx, cy);
                    }
                }
            }

            response.setContentType("image/png");
            ImageIO.write(bi, "png", response.getOutputStream());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
