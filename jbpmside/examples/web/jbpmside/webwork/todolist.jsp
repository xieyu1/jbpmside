<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/webwork" prefix="ww" %>
<%@include file="/jbpmside/common/header.jsp"%>
<html>
    <head>
        <title>待办列表</title>
        <script type="text/javascript">
            function gotoList(obj) {
                var name = obj.value
                var url = "/jbpmside/todoList.action?name=" + name;
                window.location.href = url;
                document.getElementById("chooseUser").value = name;
            }
        </script>
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
                <td background="/jbpmside/images/red_BODY_bg.gif">
                    <table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td><table height="23"  border="0" cellpadding="1" cellspacing="1" bgcolor="#9F6666">
                                    <tr align="center">
                                        <td width="82" bgcolor="#FFFFFF" class="Column_blue">待办列表</td>
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
                <td>
                    <table width="100%" height="15"  border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <select id="chooseUser" name="chooseUser" onchange="gotoList(this)">
                                    <option value="null">切换用户</option>
                                    <option value="proposer">申请人</option>
                                    <option value="leader1">会签领导1</option>
                                    <option value="leader2">会签领导2</option>
                                    <option value="leader3">直接领导3</option>
                                    <option value="caiwu">财务</option>
                                </select><br>
                                <table border="1" width="100%">
                                    <tr>
                                        <td width="15%">流程名称</td>
                                        <td width="15%">版本号</td>
                                        <td width="15%">参与者</td>
                                        <td width="15%">任务名称</td>
                                        <td width="15%">任务号</td>
                                        <td width="15%">执行</td>
                                        <td width="15%">流程跟踪</td>
                                    </tr>
                                    <ww:iterator value="jbpmTaskInstanceList">
                                        <tr>
                                            <td>
                                                <ww:property value="processDefinitionName"/>
                                            </td>
                                            <td>
                                                <ww:property value="processDefinitionVersion"/>
                                            </td>
                                            <td>
                                                <ww:property value="actorId"/>
                                            </td>
                                            <td>
                                                <ww:property value="name"/>
                                            </td>
                                            <td>
                                                <ww:property value="id"/>
                                            </td>
                                            <td>
                                                <a href="/jbpmside/completdTask.action?taskid=<ww:property value="id"/>"> 同意 </a>
                                            </td>
                                            <td>
                                                <a href="/jbpmside/processDetailList.action?tokenid=<ww:property value="tokenId"/>&img=<ww:property value="processDefinitionName"/>"> 详细 </a>
                                            </td>
                                        </tr>
                                    </ww:iterator>
                                </table>
                                总共数量： <ww:property value="{page.recordCount}"/>
                                每页显示：<ww:property value="{page.pageSize}"/>
                                当前页： <ww:property value="{page.currentPage}"/> <br/>
                                <a href="/jbpmside/todoList.action?currentpagenum=1"> 第1页 </a>
                                <a href="/jbpmside/todoList.action?currentpagenum=2"> 第2页 </a>
                                <a href="/jbpmside/todoList.action?currentpagenum=3"> 第3页 </a>
                                <a href="/jbpmside/todoList.action?currentpagenum=4"> 第4页 </a>
                                <a href="/jbpmside/todoList.action?currentpagenum=5"> 第5页 </a>
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


