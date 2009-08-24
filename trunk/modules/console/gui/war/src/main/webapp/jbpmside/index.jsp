<%@page contentType="text/html;charset=UTF-8"%>
<%pageContext.setAttribute("ext", "scripts/ext-2.0.2");%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <meta http-equiv="Cache-Control" content="no-store"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <link rel="stylesheet" type="text/css" href="${ext}/resources/css/ext-all.css" />
    <link rel="stylesheet" type="text/css" href="./styles/ext-patch.css" />
    <link rel="stylesheet" type="text/css" href="./styles/ext-customer.css" />
    <link rel="stylesheet" type="text/css" href="./styles/jbpm.css" />
    <script type="text/javascript" src="${ext}/ext-base.js"></script>
    <script type="text/javascript" src="${ext}/ext-all.js"></script>
    <script type="text/javascript" src="${ext}/ext-lang-zh_CN.js"></script>
    <script type="text/javascript" src="./scripts/ux/patcher.js"></script>
    <link rel="stylesheet" type="text/css" href="./scripts/ux/file-upload.css" />
    <script type="text/javascript" src="./scripts/ux/FileUploadField.js"></script>
    <script type="text/javascript" src="./scripts/ux/jpdl-packed.js"></script>
    <script type="text/javascript" src="./scripts/ux/Ext.JpdlPanel.js"></script>
    <link rel="stylesheet" type="text/css" href="./styles/jpdl/styles/jpdl.css" />
    <script type="text/javascript" src="./scripts/ux/Ext.ux.LoginWindow.js"></script>
    <script type="text/javascript" src="./scripts/FusionCharts/FusionCharts.js"></script>
    <script type="text/javascript" src="./scripts/miframe/miframe-min.js"></script>
    <script type="text/javascript">
Ext.BLANK_IMAGE_URL = '${ext}/resources/images/default/s.gif';
    </script>
    <title>jBPM-Side控制台</title>
  </head>
  <body>
    <div id="loading-mask" style=""></div>
    <div id="loading">
      <div class="loading-indicator"><img src="styles/login/extanim32.gif" width="32" height="32" style="margin-right:8px;" align="absmiddle"/>正在加载数据...</div>
    </div>
    <div id="nav_area">jBPM-Side控制台</div>
    <div id="state_area" style="color:white;font-size:12px;font-weight:bold;text-align:right;">
        <script type="text/javascript">
            document.write(new Date());
        </script>
    </div>
    <script type="text/javascript" src="./scripts/App.accordion.js"></script>
    <script type="text/javascript" src="./scripts/App.viewProcessDefinition.js"></script>
    <script type="text/javascript" src="./scripts/App.emunational.js"></script>
    <script type="text/javascript" src="./scripts/App.viewSuspendedProcessDefinition.js"></script>
    <script type="text/javascript" src="./scripts/App.uploadNewProcessDefinition.js"></script>
    <script type="text/javascript" src="./scripts/App.viewSuspendedProcessInstance.js"></script>
    <script type="text/javascript" src="./scripts/App.viewProcessInstance.js"></script>
    <script type="text/javascript" src="./scripts/App.detailProcessInstance.js"></script>
    <script type="text/javascript" src="./scripts/App.historyActivities.js"></script>
    <script type="text/javascript" src="./scripts/App.viewTask.js"></script>
    <script type="text/javascript" src="./scripts/App.viewJob.js"></script>
    <script type="text/javascript" src="./scripts/App.viewPersonalTask.js"></script>
    <script type="text/javascript" src="./scripts/App.chart.js"></script>
    <script type="text/javascript" src="./scripts/App.transitionForm.js"></script>
    <script type="text/javascript" src="./scripts/App.user.js"></script>
    <script type="text/javascript" src="./scripts/App.group.js"></script>
    <script type="text/javascript" src="./scripts/App.jpdl.js"></script>
    <script type="text/javascript" src="./scripts/App.security.js"></script>
    <script type="text/javascript" src="./scripts/App.js"></script>
    <script type="text/javascript" src="./scripts/i18n/<%=request.getLocale()%>.js"></script>
  </body>
</html>
