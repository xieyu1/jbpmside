
Ext.ns('App');

App.createViewSuspendedProcessInstance = function(pdId, pdDbid) {
    var processInstances = new Ext.grid.GridPanel({
        id: 'piView-' + pdId,
        title: App.locale['viewSuspendedProcessInstances.title'],
        x: 20,
        y: 20,
        width: 500,
        height: 250,
        loadMask: true,
        shim: true,
        viewConfig: {
            forceFit: true
        },
        store: new Ext.data.JsonStore({
            url: 'jbpm.do?action=suspendedProcessInstances',
            root: 'result',
            fields: ['id', 'name', 'key', 'state'],
            baseParams: {
                pdId: pdId
            }
        }),
        columns: [{
            header: App.locale['viewProcessInstances.id'],
            dataIndex: 'id'
        }, {
            header: App.locale['viewProcessInstances.name'],
            dataIndex: 'name'
        }, {
            header: App.locale['viewProcessInstances.key'],
            dataIndex: 'key'
        }, {
            header: App.locale['viewProcessInstances.state'],
            dataIndex: 'state'
        }],
        bbar: new Ext.Toolbar(['->', {
            text: App.locale['resume'],
            handler: function() {
                var selections = processInstances.getSelectionModel().getSelections();
                if (selections.length == 1) {
                    var record = selections[0];
                    Ext.Ajax.request({
                        url: 'jbpm.do?action=resumeProcessInstance',
                        params: {
                            id: record.get('id')
                        },
                        success: function() {
                            Ext.Msg.alert(App.locale['info'], App.locale['success']);
                            processInstances.getStore().reload();
                        }
                    });
                }
            }
        }, {
            text: App.locale['delete'],
            handler: function() {
                var selections = processInstances.getSelectionModel().getSelections();
                if (selections.length == 1) {
                    var record = selections[0];
                    Ext.Ajax.request({
                        url: 'jbpm.do?action=removeProcessInstance',
                        params: {
                            id: record.get('id')
                        },
                        success: function() {
                            Ext.Msg.alert(App.locale['info'], App.locale['success']);
                            processInstances.getStore().reload();
                        }
                    });
                }
            }
        }])
    });
    processInstances.getStore().load();

    var panel = new Ext.Panel({
        id: 'ViewSuspendedProcessInstances-' + pdId,
        iconCls: 'processInstance',
        closable: true,
        layout: 'absolute',
        title: App.locale['viewSuspendedProcessInstances.title'],
        items: [processInstances]
    });
    return panel;
};
