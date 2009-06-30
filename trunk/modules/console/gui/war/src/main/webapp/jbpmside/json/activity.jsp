<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="java.util.*"%>
<%@page import="org.jbpm.api.*"%>
<%@page import="org.jbpm.api.activity.*"%>
<%@page import="org.jbpm.api.task.*"%>
<%@page import="org.jbpm.api.model.*"%>
<%@page import="org.jbpm.pvm.internal.identity.spi.*"%>
<%@page import="org.jbpm.api.env.*"%>

<%
    ApplicationContext ctx = null;
    ctx = WebApplicationContextUtils.getWebApplicationContext(application);
    ProcessEngine processEngine = (ProcessEngine) ctx.getBean("jbpmConfiguration");
    RepositoryService repositoryService = processEngine.getRepositoryService();
    ExecutionService executionService = processEngine.getExecutionService();
    TaskService taskService = processEngine.getTaskService();
    IdentitySession identitySession = processEngine.get(IdentitySession.class);

    EnvironmentFactory environmentFactory = (EnvironmentFactory) ctx.getBean("jbpmConfiguration");

    String id = request.getParameter("id");
    ProcessInstance pi = executionService.findProcessInstanceById(id);

    Environment env = environmentFactory.openEnvironment();
    try {
        ProcessDefinition pd = ((OpenProcessInstance)pi).getProcessDefinition();
        String activityName = ((ActivityExecution)pi).getActivityName();
        ActivityCoordinates ac = repositoryService.getActivityCoordinates(pd.getId(), activityName);

        out.print("{x:" + ac.getX()
                + ",y:" + ac.getY()
                + ",w:" + ac.getWidth()
                + ",h:" + ac.getHeight()
                + "}");
    } finally {
        env.close();
    }
%>

