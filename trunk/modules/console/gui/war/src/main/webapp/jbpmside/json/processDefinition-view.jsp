<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.jbpm.api.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="org.jbpm.pvm.internal.identity.spi.*"%>
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

    List<ProcessDefinition> definitions = repositoryService.createProcessDefinitionQuery()
        .orderAsc(ProcessDefinitionQuery.PROPERTY_NAME)
        .list();
    Map<String, ProcessDefinition> map = new LinkedHashMap<String, ProcessDefinition>();
    for (ProcessDefinition pd : definitions) {
        String key = pd.getKey();
        ProcessDefinition processDefinition = map.get(key);
        if (processDefinition == null || processDefinition.getVersion() < pd.getVersion()) {
            map.put(key, pd);
        }
    }

    for (Map.Entry<String, ProcessDefinition> entry : map.entrySet()) {
        pageContext.setAttribute("pd", entry.getValue());

%>
    {
        id: '${pd.id}',
        name: '${pd.name}',
        version: '${pd.version}',
        dbid: '${pd.deploymentDbid}'
    },
<%
}
%>
    {}]

}