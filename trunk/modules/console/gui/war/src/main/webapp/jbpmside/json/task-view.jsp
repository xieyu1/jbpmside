<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="java.util.List"%>
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

    List<Task> tasks = taskService
        .createTaskQuery()
        .list();

    for (Task task : tasks) {
        pageContext.setAttribute("task",task);

%>
    {
        name:'${task.name}',
        assignee:'${task.assignee}',
        create:'${task.create}',
        dueDate:'${task.dueDate}',
        priority:'${task.priority}',
        description:'${task.description}',
        dbid: ${task.dbid}
    },

<%
    }
%>

    {}]

}