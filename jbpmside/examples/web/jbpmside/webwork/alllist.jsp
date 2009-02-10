<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/webwork" prefix="ww" %>
<%@include file="/jbpmside/common/header.jsp"%>
<html>
<head>
    <title>流程定义列表</title>
    <script type="text/javascript">
        function startProcess(processName) {
            var money = document.getElementById("expense_money").value;
            var url = "/jbpmside/startProcess.action?processname=" + processName + "&expense_money=" + money;
            window.location.href = url;
        }
        function showImage(img) {
            var imgs = "/jbpmside/images/processdef/" + img + ".jpg";
            var url = "/jbpmside/webwork/showimage.jsp?img=" + imgs+"&processName="+img;
            window.location.href = url;
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
                <td background="/jbpmside/images/red_BODY_bg.gif"><table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td><table height="23"  border="0" cellpadding="1" cellspacing="1" bgcolor="#9F6666">
                                    <tr align="center">
                                        <td  bgcolor="#FFFFFF" class="Column_blue">流程定义</td>
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

<table border="1" width="100%">
    <tr>
        <td width="20%">名称</td>
        <td width="20%">版本</td>
        <td width="20%">操作</td>
        <td width="20%">流程图</td>
        <td width="20%"><a href="/jbpmside/deployAll.action"><img src="/jbpmside/images/box_download_48.png"  border="0" alt="重新发布所有流程"/></a></td>
    </tr>
    
    	<select id="chooseUser" name="chooseUser" onchange="gotoAllList(this)">
                <option value="null">切换用户</option>
                <option value="proposer">申请人</option>
                <option value="leader1">会签领导1</option>
                <option value="leader2">会签领导2</option>
                <option value="leader3">直接领导3</option>
                <option value="caiwu">财务</option>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;
    申请金额： <input type="text" id="expense_money" name="expense_money" value="1500"/>

    <ww:iterator value="jbpmProcessDefinitionList">
        <tr>
            <td>
                <ww:property value="name"/>
            </td>
            <td>
                <ww:property value="version"/>
            </td>
            <td>
                <a href="#" onclick="startProcess('<ww:property value="name"/>')">创建流程实例</a>
            </td>
            <td>
                <a href="#" onclick="showImage('<ww:property value="name"/>')">查看流程图</a>
            </td>
            <td>
                <a href="/jbpmside/deploy.action?processname=<ww:property value="name"/>"><img src="/jbpmside/images/reload.gif"  border="0" alt="发布新版本"/></a>
            </td>
        </tr>
    </ww:iterator>
</table>

总共数量： <ww:property value="{page.recordCount}"/>
每页显示：<ww:property value="{page.pageSize}"/>
当前页： <ww:property value="{page.currentPage}"/> <br/>
<a href="/jbpmside/findAllProcessDefination.action?currentpagenum=1"> 第1页 </a>
<a href="/jbpmside/findAllProcessDefination.action?currentpagenum=2"> 第2页 </a>
<a href="/jbpmside/findAllProcessDefination.action?currentpagenum=3"> 第3页 </a>
<a href="/jbpmside/findAllProcessDefination.action?currentpagenum=4"> 第4页 </a>
<a href="/jbpmside/findAllProcessDefination.action?currentpagenum=5"> 第5页 </a>

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

