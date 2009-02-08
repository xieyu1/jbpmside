<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/webwork" prefix="ww" %>
 <%@include file="/jbpmside/common/header.jsp"%>
 <%
    String img  =   (String)request.getParameter("img");
 %>
<html>
<head>
    <title>流程跟踪，详细任务列表</title>
</head>

<body>

    <table width="100%" height="10"  border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td> </td>
            </tr>
        </table>
        <table width="94%"  border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="23"><img src="/jbpmside/images/red_BODY_left.gif" width="23" height="23"></td>
                <td background="/jbpmside/images/red_BODY_bg.gif"><table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td><table height="23"  border="0" cellpadding="1" cellspacing="1" bgcolor="#9F6666">
                                    <tr align="center">
                                        <td  bgcolor="#FFFFFF" class="Column_blue">详细跟踪图</td>
                                    </tr>
                            </table></td>
                        </tr>
                </table></td>
                <td width="15"><img src="/jbpmside/images/red_BODY_right.gif" width="15" height="23"></td>
            </tr>
        </table>
        <table width="94%"  border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="15" background="/jbpmside/images/red_BODY_leftbg.gif">&nbsp;</td>
                <td><table width="100%" height="15"  border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>

                               <img src="/jbpmside/images/processdef/<%=img%>.jpg" alt="流程图">
<table border="1" width="100%">
    <tr>
        <td width="13%">任务号</td>
        <td width="13%">任务名称</td>
        <td width="13%">办理人</td>
        <td width="13%">创建日期</td>
        <td width="13%">办理日期</td>
        <td width="13%">流程名称</td>
        <td width="13%">流程版本号</td>
    </tr>
    <ww:iterator value="jbpmTaskInstanceList">
        <tr>
            <td>
                <ww:property value="id"/>
            </td>
            <td>
                <ww:property value="name"/>
            </td>
            <td>
                <ww:property value="actorId"/>
            </td>
            <td>
                <ww:property value="create"/>
            </td>
            <td>
                <ww:property value="end"/>
            </td>
            <td>
                <ww:property value="processDefinitionName"/>
            </td>
            <td>
                <ww:property value="processDefinitionVersion"/>
            </td>
        </tr>
    </ww:iterator>
</table>

                            </td>
                        </tr>
                    </table>
                </td>
                <td width="15" background="/jbpmside/images/red_BODY_rightbg.gif">&nbsp;</td>
            </tr>
        </table>
        <table width="94%"  border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="18"><img src="/jbpmside/images/red_BODY_downleft.gif" width="24" height="24"></td>
                <td background="/jbpmside/images/red_BODY_downbg.gif">&nbsp;</td>
                <td width="18"><img src="/jbpmside/images/red_BODY_downright.gif" width="24" height="24"></td>
            </tr>
        </table>

</body>
</html>
<%@include file="/jbpmside/common/footer.jsp"%>


