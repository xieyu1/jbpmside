<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/webwork" prefix="ww" %>
<%@include file="/jbpmside/common/header.jsp"%>

<html>
    <head>
        <title>待签列表</title>
    </head>

    <body>
        <h1>待签列表</h1>
        <table border="1">
            <tr>
                <td width="200">参与者</td>
                <td width="200">任务名称</td>
                <td width="200">任务号</td>
                <td width="200">阅读</td>
                <td width="200">执行</td>
                <td width="200">流程跟踪</td>
            </tr>
            <ww:iterator value="jbpmTaskInstanceList">
                <tr>
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
                        <a href="/jbpmside/signTask.action?taskid=<ww:property value="id"/>"> 阅读 </a>
                    </td>
                    <td>
                        <a href="/jbpmside/completdTask.action?taskid=<ww:property value="id"/>"> 同意 </a>
                    </td>
                    <td>
                        <a href="/jbpmside/processDetailList.action?tokenid=<ww:property value="tokenId"/>"> 详细 </a>
                    </td>
                </tr>
            </ww:iterator>
        </table>
        总共数量： <ww:property value="{page.recordCount}"/>
        每页显示：<ww:property value="{page.pageSize}"/>
        当前页： <ww:property value="{page.currentPage}"/> <br/>
        <a href="/jbpmside/todoSignList.action?currentpagenum=1"> 第1页 </a>
        <a href="/jbpmside/todoSignList.action?currentpagenum=2"> 第2页 </a>
        <a href="/jbpmside/todoSignList.action?currentpagenum=3"> 第3页 </a>
        <a href="/jbpmside/todoSignList.action?currentpagenum=4"> 第4页 </a>
        <a href="/jbpmside/todoSignList.action?currentpagenum=5"> 第5页 </a>
    </body>
</html>
<%@include file="/jbpmside/common/footer.jsp"%>


