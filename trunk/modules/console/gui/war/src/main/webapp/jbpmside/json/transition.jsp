<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="java.util.*"%>
<%@page import="org.jbpm.api.*"%>
<%@page import="org.jbpm.api.activity.*"%>
<%@page import="org.jbpm.api.task.*"%>
<%@page import="org.jbpm.api.model.*"%>
<%@page import="org.jbpm.api.client.*"%>
<%@page import="org.jbpm.api.env.*"%>
<%@page import="org.jbpm.pvm.internal.identity.spi.*"%>
<%
    ApplicationContext ctx = null;
    ctx = WebApplicationContextUtils.getWebApplicationContext(application);
    ProcessEngine processEngine = (ProcessEngine) ctx.getBean("jbpmConfiguration");
    RepositoryService repositoryService = processEngine.getRepositoryService();
    ExecutionService executionService = processEngine.getExecutionService();
    TaskService taskService = processEngine.getTaskService();
    IdentitySession identitySession = processEngine.get(IdentitySession.class);

    EnvironmentFactory environmentFactory = (EnvironmentFactory) ctx.getBean("jbpmConfiguration");

    String type = request.getParameter("type");
    if (type.equals("taskComplete")) {
        long id = Long.parseLong(request.getParameter("dbid"));
        Task task = taskService.getTask(id);
        Environment env = environmentFactory.openEnvironment();
        try {
            OpenTask openTask = (OpenTask) task;
            ActivityExecution activityExecution = (ActivityExecution)openTask.getExecution();
            Activity activity = activityExecution.getActivity();
            List<Transition> transitionList = activity.getOutgoingTransitions();
            StringBuffer buff = new StringBuffer();
            buff.append("[");
            for (Transition t : transitionList) {
                buff.append("'").append(t.getName()).append("',");
            }
            buff.deleteCharAt(buff.length() - 1);
            buff.append("]");
            out.print(buff.toString());
        } finally {
            env.close();
        }
    } else if (type.equals("processStart")) {
        out.print("[null]");
    } else if (type.equals("processSignal")) {
        String id = request.getParameter("id");
        ProcessInstance pi = executionService.findProcessInstanceById(id);
        Environment env = environmentFactory.openEnvironment();
        try {
            ActivityExecution activityExecution = (ActivityExecution) pi;
            Activity activity = activityExecution.getActivity();
            List<Transition> transitionList = activity.getOutgoingTransitions();
            StringBuffer buff = new StringBuffer();
            buff.append("[");
            for (Transition t : transitionList) {
                buff.append("'").append(t.getName()).append("',");
            }
            buff.deleteCharAt(buff.length() - 1);
            buff.append("]");
            out.print(buff.toString());
        } finally {
            env.close();
        }
    }
%>
