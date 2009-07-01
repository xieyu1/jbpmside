package org.jbpmside.console.gui.servlet;

import java.io.IOException;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;

import org.jbpm.api.ProcessDefinition;
import org.jbpm.api.ProcessEngine;
import org.jbpm.api.ProcessInstance;
import org.jbpm.api.identity.Group;
import org.jbpm.api.identity.User;
import org.jbpm.api.model.ActivityCoordinates;
import org.jbpm.api.model.Transition;
import org.jbpm.api.task.Task;

import org.jbpmside.console.gui.support.JbpmTemplate;

import org.springframework.context.ApplicationContext;

import org.springframework.web.context.support.WebApplicationContextUtils;


public class JbpmServlet extends HttpServlet {
    private JbpmTemplate jbpmTemplate;

    private JbpmTemplate getJbpmTemplate() {
        if (jbpmTemplate == null) {
            ApplicationContext ctx = WebApplicationContextUtils
                .getWebApplicationContext(this.getServletContext());
            jbpmTemplate = (JbpmTemplate) ctx.getBean("jbpmTemplate");
        }

        return jbpmTemplate;
    }

    public void doGet(HttpServletRequest request,
        HttpServletResponse response) throws IOException, ServletException {
        try {
            process(request, response);
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    public void doPost(HttpServletRequest request,
        HttpServletResponse response) throws IOException, ServletException {
        try {
            process(request, response);
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    public void process(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");

        if ("processDefinitions".equals(action)) {
            this.processDefinitions(request, response);
        } else if ("deploy".equals(action)) {
            this.deploy(request, response);
        } else if ("deployXml".equals(action)) {
            this.deployXml(request, response);
        } else if ("removeProcessDefinition".equals(action)) {
            this.removeProcessDefinition(request, response);
        } else if ("transitions".equals(action)) {
            this.transitions(request, response);
        } else if ("selectTransition".equals(action)) {
            this.selectTransition(request, response);
        } else if ("processInstances".equals(action)) {
            this.processInstances(request, response);
        } else if ("activity".equals(action)) {
            this.activity(request, response);
        } else if ("removeProcessInstance".equals(action)) {
            this.removeProcessInstance(request, response);
        } else if ("variables".equals(action)) {
            this.variables(request, response);
        } else if ("tasks".equals(action)) {
            this.tasks(request, response);
        } else if ("users".equals(action)) {
            this.users(request, response);
        } else if ("addUser".equals(action)) {
            this.addUser(request, response);
        } else if ("removeUser".equals(action)) {
            this.removeUser(request, response);
        } else if ("members".equals(action)) {
            this.members(request, response);
        } else if ("addMember".equals(action)) {
            this.addMember(request, response);
        } else if ("removeMember".equals(action)) {
            this.removeMember(request, response);
        } else if ("groups".equals(action)) {
            this.groups(request, response);
        } else if ("addGroup".equals(action)) {
            this.addGroup(request, response);
        } else if ("removeGroup".equals(action)) {
            this.removeGroup(request, response);
        } else if ("isLogin".equals(action)) {
            this.isLogin(request, response);
        } else if ("login".equals(action)) {
            this.login(request, response);
        } else if ("logout".equals(action)) {
            this.logout(request, response);
        } else if ("processDetail".equals(action)) {
            this.processDetail(request, response);
        } else if ("reportOverallActivity".equals(action)) {
            this.reportOverallActivity(request, response);
        } else if ("reportProcessSummary".equals(action)) {
            this.reportProcessSummary(request, response);
        } else if ("reportMostActiveProcess".equals(action)) {
            this.reportMostActiveProcess(request, response);
        } else {
            System.out.println("Unkown Action: " + action);
        }
    }

    public void processDefinitions(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        List<ProcessDefinition> processDefinitions = jbpmTemplate
            .getLatestProcessDefinitions();
        StringBuffer buff = new StringBuffer("{result:[");

        for (ProcessDefinition pd : processDefinitions) {
            buff.append("{id:'").append(pd.getId()).append("',name:'")
                .append(pd.getName()).append("',version:'")
                .append(pd.getVersion()).append("',dbid:'")
                .append(pd.getDeploymentDbid()).append("'},");
        }

        if (!processDefinitions.isEmpty()) {
            buff.deleteCharAt(buff.length() - 1);
        }

        buff.append("]}");
        response.getWriter().print(buff.toString());
    }

    public void deploy(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();

        String temp = getServletContext().getRealPath("/temp");
        String uploadDir = getServletContext().getRealPath("/upload");
        DiskFileUpload diskFileUpload = new DiskFileUpload();
        diskFileUpload.setSizeMax(1 * 1024 * 1024);
        diskFileUpload.setSizeThreshold(4096);
        diskFileUpload.setRepositoryPath(temp);

        List fileItems = diskFileUpload.parseRequest(request);
        Iterator iter = fileItems.iterator();
        System.out.println("size: " + fileItems.size());
        System.out.println("boolean: " + iter.hasNext());

        if (iter.hasNext()) {
            FileItem item = (FileItem) iter.next();

            if (!item.isFormField()) {
                String name = item.getName();
                long size = item.getSize();

                if ((name != null) && !name.equals("") && (size != 0)) {
                    jbpmTemplate.deploy("process.jpdl.xml",
                        item.getInputStream());
                }
            }
        }

        response.getWriter().print("{success:true}");
    }

    public void deployXml(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        String xml = request.getParameter("xml");
        jbpmTemplate.deployXml(xml);

        response.getWriter().print("{success:true}");
    }

    public void removeProcessDefinition(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        String id = request.getParameter("id");
        jbpmTemplate.removeProcessDefinitionById(id);
        response.getWriter().print("{success:true}");
    }

    public void transitions(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();

        String type = request.getParameter("type");
        List<Transition> transitions = null;

        if ("taskComplete".equals(type)) {
            long id = Long.parseLong(request.getParameter("dbid"));
            transitions = jbpmTemplate.getTransitionsForTask(id);
        } else if ("processStart".equals(type)) {
            response.getWriter().print("[null]");

            return;
        } else if ("processSignal".equals(type)) {
            String id = request.getParameter("id");
            transitions = jbpmTemplate.getTransitionsForSignalProcess(id);
        }

        StringBuffer buff = new StringBuffer();
        buff.append("[");

        for (Transition t : transitions) {
            buff.append("'").append(t.getName()).append("',");
        }

        if (!transitions.isEmpty()) {
            buff.deleteCharAt(buff.length() - 1);
        }

        buff.append("]");
        response.getWriter().print(buff.toString());
    }

    public void selectTransition(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();

        Map<String, Object> variables = new HashMap<String, Object>();
        String[] names = request.getParameterValues("names");
        String[] values = request.getParameterValues("values");

        if (names != null) {
            for (int i = 0; i < names.length; i++) {
                variables.put(names[i], values[i]);
            }
        }

        String type = request.getParameter("type");

        if ("taskComplete".equals(type)) {
            int dbid = Integer.parseInt(request.getParameter("dbid"));
            String t = request.getParameter("transition");
            jbpmTemplate.completeTask(dbid, t, variables);
        } else if ("processStart".equals(type)) {
            String id = request.getParameter("id");
            jbpmTemplate.startProcess(id, variables);
        } else if ("processSignal".equals(type)) {
            String id = request.getParameter("id");
            String t = request.getParameter("transition");
            jbpmTemplate.signalProcess(id, t, variables);
        }

        response.getWriter().print("{success:true}");
    }

    public void processInstances(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();

        String pdId = request.getParameter("pdId");
        List<ProcessInstance> pis = jbpmTemplate.getProcessInstances(pdId);
        StringBuffer buff = new StringBuffer("{result:[");

        for (ProcessInstance pi : pis) {
            buff.append("{id:'").append(pi.getId()).append("',name:'")
                .append(pi.getName()).append("',key:'").append(pi.getKey())
                .append("',state:'").append(pi.getState()).append("'},");
        }

        if (!pis.isEmpty()) {
            buff.deleteCharAt(buff.length() - 1);
        }

        buff.append("]}");
        response.getWriter().print(buff.toString());
    }

    public void activity(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();

        String id = request.getParameter("id");
        ActivityCoordinates ac = jbpmTemplate.getActivityCoordinates(id);
        response.getWriter()
                .print("{x:" + ac.getX() + ",y:" + ac.getY() + ",w:"
            + ac.getWidth() + ",h:" + ac.getHeight() + "}");
    }

    public void removeProcessInstance(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        String id = request.getParameter("id");
        jbpmTemplate.removeProcessInstance(id);
    }

    public void variables(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        String type = request.getParameter("type");
        Map<String, Object> variables = null;

        if ("taskComplete".equals(type)) {
            long id = Long.parseLong(request.getParameter("dbid"));
            variables = jbpmTemplate.getVariablesForTask(id);
        } else if ("processStart".equals(type)) {
            variables = new HashMap<String, Object>();
        } else if ("processSignal".equals(type)) {
            String id = request.getParameter("id");
            variables = jbpmTemplate.getVariablesForProcess(id);
        }

        StringBuffer buff = new StringBuffer("{result:[");

        for (Map.Entry<String, Object> entry : variables.entrySet()) {
            buff.append("{name:'").append(entry.getKey())
                .append("',value:'").append(entry.getValue()).append("'},");
        }

        if (!variables.isEmpty()) {
            buff.deleteCharAt(buff.length() - 1);
        }

        buff.append("]}");
        response.getWriter().print(buff.toString());
    }

    public void tasks(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        List<Task> tasks = jbpmTemplate.getTasks();
        StringBuffer buff = new StringBuffer("{result:[");

        for (Task task : tasks) {
            buff.append("{name:'").append(task.getName())
                .append("',assignee:'").append(task.getAssignee())
                .append("',create:'").append(task.getCreate())
                .append("',dueDate:'").append(task.getDueDate())
                .append("',priority:'").append(task.getPriority())
                .append("',description:'").append(task.getDescription())
                .append("',dbid:'").append(task.getDbid()).append("'},");
        }

        if (!tasks.isEmpty()) {
            buff.deleteCharAt(buff.length() - 1);
        }

        buff.append("]}");

        response.getWriter().print(buff.toString());
    }

    public void users(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        List<User> users = jbpmTemplate.getUsers();

        StringBuffer buff = new StringBuffer();
        buff.append("{result:[");

        for (User user : users) {
            buff.append("{id:'").append(user.getId())
                .append("',givenName:'").append(user.getGivenName())
                .append("',familyName:'").append(user.getFamilyName())
                .append("',groups:'");

            List<Group> groups = jbpmTemplate.getGroupsByUser(user.getId());

            for (Group group : groups) {
                buff.append("Group(").append(group.getType()).append("): ")
                    .append(group.getName());
                buff.append(",");
            }

            if (!groups.isEmpty()) {
                buff.deleteCharAt(buff.length() - 1);
            }

            buff.append("'},");
        }

        if (!users.isEmpty()) {
            buff.deleteCharAt(buff.length() - 1);
        }

        buff.append("]}");
        response.getWriter().print(buff.toString());
    }

    public void addUser(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String givenName = request.getParameter("givenName");
        String familyName = request.getParameter("familyName");
        jbpmTemplate.addUser(id, password, givenName, familyName);
        response.getWriter().print("{success:true}");
    }

    public void removeUser(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        String id = request.getParameter("id");
        jbpmTemplate.removeUser(id);
        response.getWriter().print("{success:true}");
    }

    public void members(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        String userId = request.getParameter("userId");

        List<Group> groups = jbpmTemplate.getGroupsByUser(userId);
        StringBuffer buff = new StringBuffer();
        buff.append("{result:[");

        for (Group group : groups) {
            buff.append("{userId:'").append(userId).append("',groupId:'")
                .append(group.getId()).append("',groupName:'")
                .append(group.getName()).append("',groupType:'")
                .append(group.getType()).append("'},");
        }

        if (!groups.isEmpty()) {
            buff.deleteCharAt(buff.length() - 1);
        }

        buff.append("]}");
        response.getWriter().print(buff.toString());
    }

    public void addMember(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();

        String userId = request.getParameter("userId");
        String groupId = request.getParameter("groupId");
        String role = request.getParameter("role");
        jbpmTemplate.addMember(userId, groupId, role);
        response.getWriter().print("{success:true}");
    }

    public void removeMember(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        response.getWriter().print("{success:true}");
    }

    public void groups(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        List<Group> groups = jbpmTemplate.getGroups();

        StringBuffer buff = new StringBuffer();
        buff.append("{result:[");

        for (Group group : groups) {
            buff.append("{id:'").append(group.getId()).append("',name:'")
                .append(group.getName()).append("',type:'")
                .append(group.getType()).append("'},");
        }

        if (!groups.isEmpty()) {
            buff.deleteCharAt(buff.length() - 1);
        }

        buff.append("]}");
        response.getWriter().print(buff.toString());
    }

    public void addGroup(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();

        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String parentGroupId = request.getParameter("parentGroupId");
        jbpmTemplate.addGroup(name, type, parentGroupId);
        response.getWriter().print("{success:true}");
    }

    public void removeGroup(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        String id = request.getParameter("id");
        jbpmTemplate.removeGroup(id);
        response.getWriter().print("{success:true}");
    }

    public void isLogin(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        boolean isLogin = session.getAttribute("currentUsername") != null;
        response.getWriter().print("{success:" + isLogin + "}");
    }

    public void login(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (jbpmTemplate.checkLogin(username, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUsername", username);
            response.getWriter().print("{success:true}");
        } else {
            response.getWriter().print("{success:false}");
        }
    }

    public void logout(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        session.invalidate();
        response.getWriter().print("{success:true}");
    }

    public void processDetail(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        String id = request.getParameter("id");
        ProcessDefinition processDefinition = jbpmTemplate
            .getProcessDefinitionByProcessInstanceId(id);
        ActivityCoordinates ac = jbpmTemplate.getActivityCoordinates(id);
        StringBuffer buff = new StringBuffer(
                "<img style='position:absolute;left:0px;top:0px;' src='JpdlImage?id=");
        buff.append(processDefinition.getDeploymentDbid())
            .append("'><div style='position:absolute;left:")
            .append(ac.getX()).append("px;top:").append(ac.getY())
            .append("px;width:").append(ac.getWidth()).append("px;height:")
            .append(ac.getHeight())
            .append("px;border:1px solid red;'></div>");
        response.getWriter().print(buff.toString());
    }

    public void reportOverallActivity(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        String result = jbpmTemplate.reportOverallActivity();
        response.getWriter().print(result);
    }

    public void reportProcessSummary(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        String result = jbpmTemplate.reportOverallActivity();
        response.getWriter().print(result);
    }

    public void reportMostActiveProcess(HttpServletRequest request,
        HttpServletResponse response) throws Exception {
        JbpmTemplate jbpmTemplate = this.getJbpmTemplate();
        String result = jbpmTemplate.reportMostActiveProcess();
        response.getWriter().print(result);
    }
}
