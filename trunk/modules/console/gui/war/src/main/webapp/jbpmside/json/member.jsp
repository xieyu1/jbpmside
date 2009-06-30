<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="java.util.*"%>
<%@page import="org.jbpm.api.*"%>
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

    String userId = request.getParameter("userId");
    List<Group> groups = identityService.findGroupsByUser(userId);
    StringBuffer buff = new StringBuffer();
    buff.append("{result:[");
    for (Group group : groups) {
        buff.append("{userId:'").append(userId)
            .append("',groupId:'").append(group.getId())
            .append("',groupName:'").append(group.getName())
            .append("',groupType:'").append(group.getType())
            //.append("',membershipRole:'").append(membership.getRole())
            .append("'},");
    }
    if (groups.size() > 0) {
        buff.deleteCharAt(buff.length() - 1);
    }
    buff.append("]}");
    out.print(buff.toString());
%>

