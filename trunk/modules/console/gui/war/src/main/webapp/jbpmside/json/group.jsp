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
<%@page import="org.jbpm.pvm.internal.identity.impl.IdentitySessionImpl"%>

<%
    ApplicationContext ctx = null;
    ctx = WebApplicationContextUtils.getWebApplicationContext(application);
    ProcessEngine processEngine = (ProcessEngine) ctx.getBean("jbpmConfiguration");
    RepositoryService repositoryService = processEngine.getRepositoryService();
    ExecutionService executionService = processEngine.getExecutionService();
    TaskService taskService = processEngine.getTaskService();
    IdentityService identityService = processEngine.getIdentityService();

    EnvironmentFactory environmentFactory = (EnvironmentFactory) ctx.getBean("jbpmConfiguration");
    Environment env = environmentFactory.openEnvironment();
    try {
        IdentitySession identitySession = env.get(IdentitySession.class);
        List<Group> groups = ((IdentitySessionImpl)identitySession).findGroups();
        StringBuffer buff = new StringBuffer();
        buff.append("{result:[");
        for (Group group : groups) {
            buff.append("{id:'").append(group.getId())
                .append("',name:'").append(group.getName())
                .append("',type:'").append(group.getType())
                .append("'},");
        }
        if (groups.size() > 0) {
            buff.deleteCharAt(buff.length() - 1);
        }
        buff.append("]}");
        out.print(buff.toString());
    } finally {
        env.close();
    }
%>

