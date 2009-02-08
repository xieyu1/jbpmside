package cn.org.jbpmside.core.listener;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jbpm.JbpmConfiguration;
import org.jbpm.JbpmContext;
import org.jbpm.graph.def.ProcessDefinition;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 流程定义发布监听
 * Author: xinpeng
 * Date: 2008-10-20
 * Time: 21:26:19
 */
public class DeployJbpmProcessListener implements ServletContextListener {

    private static Log log = LogFactory.getLog(DeployJbpmProcessListener.class);

    /**
     * 发布流程定义初始化
     * @param servletContextEvent  从接口实现，详见ServletContextListener
     */
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        String filePath = System.getProperty("JBPMSIDE_HOME");
        if (filePath == null) {
            log.error("没有指定环境变量JBPMSIDE_HOME。");
        } else {
            filePath += File.separator + "jbpmprocesses" + File.separator;
        }
        log.info("开始导入JBPMSIDE流程定义......");
        //此包id为初始化数据中的示例流程包的id
        List<String> lstProcessFile = getProcessFileList(filePath);
        if (!lstProcessFile.isEmpty()) {
            for (String jbpmProcessFileName : lstProcessFile) {
                importJbpmTemplate(jbpmProcessFileName);
            }
            log.info("示例流程导入成功.");
        } else {
            log.info("在[jbpmsidehome]/jbpmprocesses目录下没有发现JBPM流程定义文件！");
        }
    }


    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        
    }

    /*
     *发布流程定义文件 
     * @param jbpmProcessFileName   流程文件名称
     */
    private void importJbpmTemplate(String jbpmProcessFileName) {

        if (jbpmProcessFileName == null)
            throw new RuntimeException("The templateFileName could not be null!");

        JbpmContext jbpmContext = null;             
        try {
            File file = new File(jbpmProcessFileName);
            if (file.exists()) {
                InputStream ins = new FileInputStream(file);
                JbpmConfiguration jbpmConfiguration = JbpmConfiguration.getInstance();
                jbpmContext = jbpmConfiguration.createJbpmContext();
                ProcessDefinition processDefinition = ProcessDefinition.parseXmlInputStream(ins);
                jbpmContext.deployProcessDefinition(processDefinition);
            } else {
                throw new RuntimeException("The definition xml file [" + jbpmProcessFileName + "] doesn't exist!");
            }
        } catch (Exception e) {
            if (log.isDebugEnabled())
                e.printStackTrace();
            else
                log.error("The definition xml file [" + jbpmProcessFileName + "] doesn't exist!", e);
            throw new RuntimeException(e);
        } finally{
            if (jbpmContext != null)
                jbpmContext.close();
        }
    }

    /*
     * 获取流程定义文件列表 
     * @param filePath    文件夹路径
     * @return             所有文件夹路径下的文件的路径的集合
     */
    private List<String> getProcessFileList(String filePath) {
        List<String> list = new ArrayList<String>();
        // 读取jbpmprocesses下的*.xml文件
        File folder = new File(filePath);
        String[] pagemetaFiles = folder.list();
        for (String pagemetaFile : Arrays.asList(pagemetaFiles)) {
            if (pagemetaFile.endsWith(".xml")) {
                list.add(filePath + pagemetaFile);
            }
        }
        return list;
    }
}
