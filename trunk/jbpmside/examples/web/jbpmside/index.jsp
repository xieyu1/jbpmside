<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="/webwork" prefix="ww" %>
<html lang="en">
    <head>
        <title>
            jbpmside example
        </title>

        <link rel="stylesheet" type="text/css" href="./css/collapser.css"/>
        <link rel="stylesheet" type="text/css" href="./css/docs.css"/>
        <link rel="stylesheet" type="text/css" href="./css/ext-all.css"/>
        <link rel="stylesheet" type="text/css" href="./css/vista.css">

        <script type="text/javascript" src="./js/ext-base.js"></script>
        <script type="text/javascript" src="./js/ext-all.js"></script>
        <script type="text/javascript" src="./js/docs.js"></script>
        <script type="text/javascript" src="./js/SpryCollapsiblePanel.js"></script>
        <script type="text/javascript" src="./js/js4cnltreemenu.js"></script>


        <script type="text/javascript">
            function MM_swapImgRestore() { //v3.0
                var i,x,a = document.MM_sr;
                for (i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++) x.src = x.oSrc;
            }

            function MM_preloadImages() { //v3.0
                var d = document;
                if (d.images) {
                    if (!d.MM_p) d.MM_p = new Array();
                    var i,j = d.MM_p.length,a = MM_preloadImages.arguments;
                    for (i = 0; i < a.length; i++)
                        if (a[i].indexOf("#") != 0) {
                            d.MM_p[j] = new Image;
                            d.MM_p[j++].src = a[i];
                        }
                }
            }

            function MM_findObj(n, d) { //v4.01
                var p,i,x;
                if (!d) d = document;
                if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
                    d = parent.frames[n.substring(p + 1)].document;
                    n = n.substring(0, p);
                }
                if (!(x = d[n]) && d.all) x = d.all[n];
                for (i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
                for (i = 0; !x && d.layers && i < d.layers.length; i++) x = MM_findObj(n, d.layers[i].document);
                if (!x && d.getElementById) x = d.getElementById(n);
                return x;
            }

            function MM_swapImage() { //v3.0
                var i,j = 0,x,a = MM_swapImage.arguments;
                document.MM_sr = new Array;
                for (i = 0; i < (a.length - 2); i += 3)
                    if ((x = MM_findObj(a[i])) != null) {
                        document.MM_sr[j++] = x;
                        if (!x.oSrc) x.oSrc = x.src;
                        x.src = a[i + 2];
                    }
            }
        </script>
    </head>
    <body scroll="no" id="docs" onselectstart="return false">
        <div id="loading-mask" style="width:100%;height:100%;background:#c3daf9;position:absolute;z-index:20000;left:0;top:0;">
            &#160;
        </div>
        <div id="loading">
            <div class="loading-indicator">
                <img src="images/default/grid/loading.gif" style="width:16px;height:16px;"
                     align="absmiddle">&#160;Loading...
            </div>
        </div>

        <div id="header">
            <table border="0" width="100%" cellspacing="0" cellpadding="0">
                <tr>
                    <td><img border="0" src="images/banner_left.gif" height="78"></td>
                    <td background="images/banner_bg.gif" width="100%"></td>
                    <td><img src="images/banner_right.gif"/>

                        
                    </td>
                </tr>
            </table>
        </div>

        <div id="classes" style="overflow:auto;" class="bgTable">
            <table width="90%" align="center" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="20">&nbsp;</td>
                </tr>

                <tr>
                    <td>
                        <div id="CollapsiblePanel1">
                            <div class="CollapsiblePanelTab" tabindex="1">
                                <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="background:url('./images/menu/XPbanner4a.gif') no-repeat 0px -1px;width:28px;height:28px;">
                                        &nbsp;</td>
                                        <td style="background:url('./images/menu/XPbannerb.gif') no-repeat 0px -1px;width:164px;height:28px;">
                                        &nbsp;开发示例</td>
                                        <td style="background:url('./images/menu/XPbannerc.gif') repeat-x 0px -1px;">
                                        &nbsp;</td>
                                        <td style="background:url('./images/menu/XPbannerd.gif') no-repeat 0px -1px;width:25px;height:28px;">
                                        &nbsp;</td>
                                    </tr>
                                </table>
                            </div>
                            <div>
                                <table class="CollapsiblePanelTableContent">
                                    <tr>
                                        <td height="60" class="CollapsiblePanelTableTdContent">
                                            <div class="CNLTreeMenu" id="CNLTreeMenu4">
                                                <ul>
                                                    <li class="Opened"><a href="/jbpmside/findAllProcessDefination.action">流程定义</a></li>
                                                    <li class="Opened"><a href="/jbpmside/todoList.action">待办列表</a></li>
                                                    <li class="Opened"><a href="/jbpmside/completedList.action">已办列表</a></li>
                                                    <li class="Opened"><a href="/jbpmside/processCompletedList.action">办结列表</a></li>
                                                </ul>
                                            </div>
                                            <br/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </td>
                </tr>

                
                <tr>
                    <td>
                        <div id="CollapsiblePanel2">
                            <div class="CollapsiblePanelTab" tabindex="1">
                                <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="background:url('./images/menu/XPbanner2a.gif') no-repeat 0px -1px;width:28px;height:28px;">
                                        &nbsp;</td>
                                        <td style="background:url('./images/menu/XPbannerb.gif') no-repeat 0px -1px;width:164px;height:28px;">
                                        &nbsp;管理控制台</td>
                                        <td style="background:url('./images/menu/XPbannerc.gif') repeat-x 0px -1px;">
                                        &nbsp;</td>
                                        <td style="background:url('./images/menu/XPbannerd.gif') no-repeat 0px -1px;width:25px;height:28px;">
                                        &nbsp;</td>
                                    </tr>
                                </table>
                            </div>
                            <div>
                                <table class="CollapsiblePanelTableContent">
                                    <tr>
                                        <td class="CollapsiblePanelTableTdContent">
                                            <div class="CNLTreeMenu" id="CNLTreeMenu2">
                                                <ul>
                                                    <li class="Opened"><a href="#">实例管理</a>
                                                        <ul>
                                                            <li><a href="#">流程实例</a>
                                                            </li>
                                                            <!--Sub Node 2-->
                                                            <li><a href="#">任务实例</a>
                                                            </li>
                                                            <!--Sub Node 2-->
                                                        </ul>
                                                    </li>
                                                    
                                                    <!--Sub Node 1 -->
                                                </ul>
                                            </div>
                                            <br/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <iframe id="main" frameborder="no"></iframe>
    </body>
    <script type="text/javascript">
        <!--
        var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1");
        var CollapsiblePanel2 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel2");
        //var CollapsiblePanel3 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel3");

        var MyCNLTreeMenu1 = new CNLTreeMenu("CNLTreeMenu1", "li");
        MyCNLTreeMenu1.InitCss("Opened", "Closed", "Child", "./images/menu/s.gif");
        var MyCNLTreeMenu2 = new CNLTreeMenu("CNLTreeMenu2", "li");
        MyCNLTreeMenu2.InitCss("Opened", "Closed", "Child", "./images/menu/s.gif");
        //var MyCNLTreeMenu3 = new CNLTreeMenu("CNLTreeMenu3", "li");
        //MyCNLTreeMenu3.InitCss("Opened", "Closed", "Child", "./images/menu/s.gif");
        //-->
    </script>
</html>