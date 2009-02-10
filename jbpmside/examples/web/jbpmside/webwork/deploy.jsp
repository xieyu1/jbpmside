<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/jbpmside/common/header.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>发布流程</title>
    </head>
    <body>
        <h1>发布流程</h1>
        <form action="/jbpmside/deploy.action" method="post">
            <input type="text" name="processName">
            <input type="submit" value="发布">
        </form>

        <a href="/jbpmside/deployAll.action" >发布所有流程</a>
    </body>
</html>
<%@include file="/jbpmside/common/footer.jsp"%>