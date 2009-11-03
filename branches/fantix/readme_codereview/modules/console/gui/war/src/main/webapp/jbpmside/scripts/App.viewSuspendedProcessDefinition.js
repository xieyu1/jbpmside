
Ext.ns('App');

App.createViewSuspendedProcessDefinition = function() {
    App.suspendedProcessDefinitions = new Ext.grid.GridPanel({
        title: App.locale['viewSuspendedDefinitions.title'],
        x: 20,
        y: 20,
        width: 500,
        height: 300,
        loadMask: true,
        shim: true,
        viewConfig: {
            forceFit: true
        },
        store: new Ext.data.JsonStore({
            url: 'jbpm.do?action=suspendedProcessDefinitions',
            root: 'result',
            fields: ['id', 'name', 'version', 'dbid']
        }),
        columns: [{
            header: App.locale['viewDefinitions.id'],
            dataIndex: 'id'
        },{
            header: App.locale['viewDefinitions.name'],
            dataIndex: 'name'
        },{
            header: App.locale['viewDefinitions.version'],
            dataIndex: 'version'
        }],
        bbar: new Ext.Toolbar(['->', {
            text: App.locale['resume'],
            handler: function() {
                var selections = App.processDefinitions.getSelectionModel().getSelections();
                if (selections.length == 1 ) {
                    var record = selections[0];
                    Ext.Ajax.request({
                        url: 'jbpm.do?action=resumeProcessDefinition',
                        params: {
                            id: record.get('id')
                        },
                        success: function() {
                            Ext.Msg.alert(App.locale['info'], App.locale['success']);
                            App.processDefinitions.getStore().reload();
                        }
                    });
                }

            }
        }, {
            text: App.locale['delete'],
            handler: function() {
                var selections = App.processDefinitions.getSelectionModel().getSelections();
                if (selections.length == 1 ) {
                    var record = selections[0];
                    Ext.Ajax.request({
                        url: 'jbpm.do?action=removeProcessDefinition',
                        params: {
                            id: record.get('id')
                        },
                        success: function() {
                            Ext.Msg.alert(App.locale['info'], App.locale['success']);
                            App.processDefinitions.getStore().reload();
                        }
                    });
                }

            }
        }])
    });

    App.suspendedProcessDefinitions.store.load();

    App.suspendedProcesses = new Ext.Panel ({
        id: 'ViewSuspendedProcessDefinition',
        title: App.locale['viewSuspendedDefinitions.title'],
        iconCls: 'processManagement',
        layout: 'absolute',
        closable: true,
        items: [App.suspendedProcessDefinitions, {
            x: 550,
            y: 20,
            width: 240,
            title: 'CR1下存在问题',
            html: '查看已暂停的流程定义，在CR1下有BUG，无法正常显示，在trunk下已经修正，等待GA发布。'
        }]
    });
    return App.suspendedProcesses;
};