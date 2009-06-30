<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="org.springframework.context.ApplicationContext" %>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.jbpm.api.*"%>
<%@page import="java.io.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="java.util.*"%>
<%@page import="org.jbpm.pvm.internal.identity.spi.*"%>

<%
    System.out.println("deploy....");
    ApplicationContext ctx = null;
    ctx = WebApplicationContextUtils.getWebApplicationContext(application);
    ProcessEngine processEngine = (ProcessEngine) ctx.getBean("jbpmConfiguration");
    RepositoryService repositoryService = processEngine.getRepositoryService();
    ExecutionService executionService = processEngine.getExecutionService();
    TaskService taskService = processEngine.getTaskService();
    IdentitySession identitySession = processEngine.get(IdentitySession.class);

    String temp = getServletContext().getRealPath("/temp");
    String uploadDir = getServletContext().getRealPath("/upload");
    DiskFileUpload diskFileUpload = new DiskFileUpload();
    diskFileUpload.setSizeMax(1*1024*1024);
    diskFileUpload.setSizeThreshold(4096);
    diskFileUpload.setRepositoryPath(temp);

    List fileItems = diskFileUpload.parseRequest(request);
    Iterator iter = fileItems.iterator();
    System.out.println("size: " + fileItems.size());
    System.out.println("boolean: " + iter.hasNext());
    if (iter.hasNext()) {
        FileItem item = (FileItem) iter.next();
        if (!item.isFormField()) {
            String name = item.getName();
            long size = item.getSize();
            BufferedReader br = new BufferedReader(new InputStreamReader(item.getInputStream()));
            String line = null;
            while ((line = br.readLine()) != null) {
                System.out.println(line);
            }

            if (name != null && !name.equals("") && size != 0) {
                repositoryService.createDeployment()
                    .addResourceFromInputStream("process.jpdl.xml",item.getInputStream())
                    .deploy();
            }
        }
    }
%>

{success: true}