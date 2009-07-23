
Ext.ns('App');

App.createDetailProcessInstance = function(piId, pdDbid) {

    var iframeId = Ext.id();

    var panel = new Ext.Panel({
        id: 'DetailProcessInstance-' + piId,
        iconCls: 'processInstance',
        closable: true,
        layout: 'absolute',
        items: [{
            id: iframeId,
            xtype: 'iframepanel',
            x: 20,
            y: 20,
            width: 500,
            height: 450,
            defaultSrc: 'jbpm.do?action=processDetail&id=' + piId,
            tbar: new Ext.Toolbar([{
                text: App.locale['prev'],
                handler: function() {
                    var win = Ext.getCmp(iframeId).iframe.getWindow();
                    win.prev();
                }
            }, {
                text: App.locale['next'],
                handler: function() {
                    var win = Ext.getCmp(iframeId).iframe.getWindow();
                    win.next();
                }
            }, {
                text: App.locale['replay'],
                handler: function() {
                    var win = Ext.getCmp(iframeId).iframe.getWindow();
                    win.replay();
                }
            }]),
            bbar: new Ext.Toolbar(['->', {
                text: App.locale['enlarge']
            }])
        },  {
            title: App.locale['associatedTasks.title'],
            iconCls: 'taskManagement',
            x: 550,
            y: 20,
            width: 250,
            height: 200,
            bodyStyle: 'padding:5px;font-size:12px;',
            html: App.locale['associatedTasks.content'],
            bbar: new Ext.Toolbar([
                '->',
                App.locale['viewTasks']
            ])
        }, {
            title: App.locale['leaveComments.title'],
            iconCls: 'comment',
            x: 550,
            y: 250,
            width: 250,
            height: 200,
            bodyStyle: 'padding:5px;font-size:12px;',
            html: App.locale['leaveComments.content'],
            bbar: new Ext.Toolbar([
                '->',
                App.locale['viewOrAddComment']
            ])
        }]
    });

    return panel;
};
