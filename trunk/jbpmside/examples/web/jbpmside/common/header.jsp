<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String name = (String) request.getSession().getAttribute("loginName");
    name = name.equals("null") ? "无" : name;
%>
<html>
    <head>

        <title>jbpmside</title>
        

        <script type="text/javascript">
		//待办列表
        function gotoList(obj) {
            var name = obj.value
            var url = "/jbpmside/todoList.action?name=" + name;
            window.location.href = url;
        }
		//所有流程定义列表
		 function gotoAllList(obj) {
            var name = obj.value
            var url = "/jbpmside/findAllProcessDefination.action?name=" + name;
            window.location.href = url;
        }
		//所有已办列表
		function gotoCompletedList(obj) {
            var name = obj.value
            var url = "/jbpmside/completedList.action?name=" + name;
            window.location.href = url;
        }
    		//所有办结列表
		function gotoProcessCompletedList(obj) {
            var name = obj.value
            var url = "/jbpmside/processCompletedList.action?name=" + name;
            window.location.href = url;
        }    
		//初始化用户
        function initUser() {
 
            var name = "<%=name%>";
            var chooseUser	=	document.getElementById("chooseUser");
            if(chooseUser!=null){
            	chooseUser.value = name;
            }
        }
    </script>
    </head>
<body onload="initUser()">

        <table>
            <tr>
                <td><img src="/jbpmside/images/Info.png" alt="jbpmside"></td>
                <td>
                    jbpmside是一个基于jbpm进行扩展和封装的开源工作流项目，根据国内业务系统使用工作流的特点，对接口重新组织和封装，并增加了一些国内工作流项目常用的功能，例如会签、回退、并发子流程等，并且开发了基于flex的流程设计器，使得jbpm的学习和使用成本降至最低。
                </td>
            </tr>
        </table>
        



        <!--<table border="1" width="100%">
    <tr>
        <td width="15%"><a href="/" >首页</a></td>
        <td width="15%"><a href="/jbpmside/findAllProcessDefination.action">所有的流程</a></td>
        <td width="15%"><a href="/jbpmside/todoList.action">待办列表</a></td>
        <td width="15%"><a href="/jbpmside/completedList.action">已办列表</a></td>
        <td width="15%"><a href="/jbpmside/processCompletedList.action">办结列表</a></td>
        <td width="15%">
            <select id="chooseUser" name="chooseUser" onchange="gotoList(this)">
                <option value="null">切换用户</option>
                <option value="leader1">会签领导1</option>
                <option value="leader2">会签领导2</option>
                <option value="leader3">直接领导3</option>
                <option value="caiwu">财务</option>
            </select>
        </td>

    </tr>
</table>-->

    </body>
</html>