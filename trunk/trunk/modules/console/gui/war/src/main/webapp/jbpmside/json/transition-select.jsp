<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="java.util.*"%>
<%@page import="org.jbpm.api.*"%>
<%@page import="org.jbpm.pvm.internal.identity.spi.*"%>


<%
    ApplicationContext ctx = null;
    ctx = WebApplicationContextUtils.getWebApplicationContext(application);
    ProcessEngine processEngine = (ProcessEngine) ctx.getBean("jbpmConfiguration");
    RepositoryService repositoryService = processEngine.getRepositoryService();
    ExecutionService executionService = processEngine.getExecutionService();
    TaskService taskService = processEngine.getTaskService();
    IdentitySession identitySession = processEngine.get(IdentitySession.class);

    String type = request.getParameter("type");
    Map<String, Object> variables = new HashMap<String, Object>();
    String[] names = request.getParameterValues("names");
    String[] values = request.getParameterValues("values");
    if (names != null ) {
        for (int i = 0; i < names.length; i++) {
            variables.put(names[i], values[i]);
        }
    }

    if (type.equals("taskComplete")) {
        int dbid = Integer.parseInt(request.getParameter("dbid"));
        String t = request.getParameter("transition");
        taskService.setVariables(dbid, variables);
        taskService.completeTask(dbid, t);
    } else if (type.equals("processStart")) {
        String id = request.getParameter("id");
        ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
            .processDefinitionId(id)
            .uniqueResult();

        Execution execution = executionService.startProcessInstanceById(pd.getId(), variables);
    } else if (type.equals("processSignal")) {
        String id = request.getParameter("id");
        String t = request.getParameter("transition");
        ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
            .processDefinitionId(id)
            .uniqueResult();
        executionService.setVariables(id, variables);
        Execution execution = executionService.signalExecutionById(id, t);
    }
%>
{success:true}