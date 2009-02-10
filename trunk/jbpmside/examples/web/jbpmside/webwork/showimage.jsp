<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/jbpmside/common/header.jsp"%>

<%
        String img = (String) request.getParameter("img");
        String processName = request.getParameter("processName");
%>

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
                                <td  bgcolor="#FFFFFF" class="Column_blue"><%=processName%>流程图</td>
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
                        <br>
                        <img src="<%=img%>" alt="流程图">

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
<%@include file="/jbpmside/common/footer.jsp"%>