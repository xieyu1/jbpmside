<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="java.util.List"%>
<%@page import="org.jbpm.api.*"%>
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

    String pdId = request.getParameter("pdId");
    List<ProcessInstance> pis = executionService
        .createProcessInstanceQuery()
        .processDefinitionId(pdId)
        .list();

    for (ProcessInstance pi : pis) {
        pageContext.setAttribute("pi",pi);

%>
    {
        id: '${pi.id}',
        name:'${pi.name}',
        key:'${pi.key}',
        state:'${pi.state}',
        dbid:${pi.dbid}
    },

<%
    }
%>

{}]

}