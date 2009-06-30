<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="java.util.*"%>
<%@page import="org.jbpm.api.*"%>
<%@page import="org.jbpm.api.env.*"%>
<%@page import="org.jbpm.api.task.*"%>
<%@page import="org.jbpm.pvm.internal.identity.spi.IdentitySession"%>
<%@page import="org.jbpm.api.identity.*"%>
<%@page import="org.jbpm.pvm.internal.identity.impl.MembershipImpl"%>
<%@page import="org.jbpm.pvm.internal.identity.spi.*"%>

<%
    ApplicationContext ctx = null;
    ctx = WebApplicationContextUtils.getWebApplicationContext(application);
    ProcessEngine processEngine = (ProcessEngine) ctx.getBean("jbpmConfiguration");
    RepositoryService repositoryService = processEngine.getRepositoryService();
    ExecutionService executionService = processEngine.getExecutionService();
    TaskService taskService = processEngine.getTaskService();
    IdentityService identityService = processEngine.getIdentityService();

    List<User> users = identityService.findUsers();
    StringBuffer buff = new StringBuffer();
    buff.append("{result:[");
    for (User user : users) {
        buff.append("{id:'").append(user.getId())
            .append("',givenName:'").append(user.getGivenName())
            .append("',familyName:'").append(user.getFamilyName())
            .append("',groups:'");
        List<Group> groups = identityService.findGroupsByUser(user.getId());
        for (Group group : groups) {
            buff.append("Group(").append(group.getType()).append("): ")
                .append(group.getName());
            buff.append(",");
        }
        if (groups.size() > 0) {
            buff.deleteCharAt(buff.length() - 1);
        }
        buff.append("'},");
    }
    if (users.size() > 0) {
        buff.deleteCharAt(buff.length() - 1);
    }
    buff.append("]}");
    out.print(buff.toString());

%>

