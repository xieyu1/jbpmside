<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="java.util.*"%>
<%@page import="org.jbpm.api.*"%>
<%@page import="org.jbpm.api.task.*"%>
<%@page import="org.jbpm.pvm.internal.identity.spi.*"%>
{
    result: [

<%
    ApplicationContext ctx = null;
    ctx = WebApplicationContextUtils.getWebApplicationContext(application);
    ProcessEngine processEngine = (ProcessEngine) ctx.getBean("jbpmConfiguration");
    RepositoryService repositoryService = processEngine.getRepositoryService();
    ExecutionService executionService = processEngine.getExecutionService();
    TaskService taskService = processEngine.getTaskService();
    IdentitySession identitySession = processEngine.get(IdentitySession.class);


    String type = request.getParameter("type");
    if (type.equals("taskComplete")) {
        long id = Long.parseLong(request.getParameter("dbid"));
        Set<String> names = taskService.getVariableNames(id);
        Map<String, Object> variables = taskService.getVariables(id, names);

        for (Map.Entry<String, Object> entry : variables.entrySet()) {
            pageContext.setAttribute("entry", entry);

%>
{
            name:'${entry.key}',
            value:'${entry.value}'
},
<%
        }
%>

        {}

    ]
}
<%
    } else if (type.equals("processSignal")) {
        String id = request.getParameter("id");
        Set<String> names = executionService.getVariableNames(id);
        System.out.println(names);
        Map<String, Object> variables = executionService.getVariables(id, names);

        for (Map.Entry<String, Object> entry : variables.entrySet()) {
            pageContext.setAttribute("entry", entry);

%>
{
            name:'${entry.key}',
            value:'${entry.value}'
},
<%
        }
%>

        {}

    ]
}
<%
    }
%>

