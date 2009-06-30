
Ext.ns('App');

App.createDetailProcessInstance = function(piId, pdDbid) {

    var panel = new Ext.Panel({
        id: 'DetailProcessInstance-' + piId,
        iconCls: 'processInstance',
        closable: true,
        layout: 'absolute',
        items: [{
            x: 20,
            y: 20,
            width: 500,
            height: 500,
            autoScroll: true,
            html: '<iframe frameborder="no" width="500" height="500" src="jbpm.do?action=processDetail&id=' + piId + '"><img src="JpdlImage?id=' + pdDbid + '"></iframe>',
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
            html: App.locale['leaveComments.content'],
            bbar: new Ext.Toolbar([
                '->',
                App.locale['viewOrAddComment']
            ])
        }]
    });

    return panel;
};
