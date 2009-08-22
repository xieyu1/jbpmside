
Ext.ns('App');

App.createViewPersonalTasks = function() {
    var personalTasks = new Ext.grid.GridPanel({
        id: 'personalTasks',
        title: App.locale['personalTasks.title'],
        x: 20,
        y: 20,
        width: 350,
        height: 250,
        loadMask: true,
        shim: true,
        viewConfig: {
            forceFit: true
        },
        store: new Ext.data.JsonStore({
            url: 'jbpm.do?action=personalTasks',
            root: 'result',
            fields: ['name', 'assignee', 'createTime', 'duedate', 'priority', 'description', 'dbid']
        }),
        columns: [{
            header: App.locale['viewTaskManagement.name'],
            dataIndex: 'name'
        }, {
            header: App.locale['viewTaskManagement.assignTo'],
            dataIndex: 'assignee'
        }, {
            header: App.locale['viewTaskManagement.createTime'],
            dataIndex: 'createTime'
        }, {
            header: App.locale['viewTaskManagement.duedate'],
            dataIndex: 'duedate'
        }, {
            header: App.locale['viewTaskManagement.priority'],
            dataIndex: 'priority'
        }, {
            header: App.locale['viewTaskManagement.description'],
            dataIndex: 'description'
        }],
        bbar: new Ext.Toolbar(['->', {
            text: App.locale['cancel'],
            handler: function() {
                var selections = personalTasks.getSelectionModel().getSelections();
                if (selections.length == 1) {
                    var record = selections[0];
                    Ext.Ajax.request({
                        url: 'jbpm.do?action=cancelTask',
                        params: {
                            id: record.get('dbid')
                        },
                        success: function() {
                            Ext.Msg.alert(App.locale['info'], App.locale['success']);
                            personalTasks.getStore().reload();
                            groupTasks.getStore().reload();
                        }
                    });
                }
            }
        }, {
            text: App.locale['release'],
            handler: function() {
                var selections = personalTasks.getSelectionModel().getSelections();
                if (selections.length == 1) {
                    var record = selections[0];
                    Ext.Ajax.request({
                        url: 'jbpm.do?action=releaseTask',
                        params: {
                            id: record.get('dbid')
                        },
                        success: function() {
                            Ext.Msg.alert(App.locale['info'], App.locale['success']);
                            personalTasks.getStore().reload();
                            groupTasks.getStore().reload();
                        }
                    });
                }
            }
        }])
    });
    personalTasks.getStore().load();

    var groupTasks = new Ext.grid.GridPanel({
        id: 'groupTasks',
        title: App.locale['groupTasks.title'],
        x: 400,
        y: 20,
        width: 350,
        height: 250,
        loadMask: true,
        shim: true,
        viewConfig: {
            forceFit: true
        },
        store: new Ext.data.JsonStore({
            url: 'jbpm.do?action=groupTasks',
            root: 'result',
            fields: ['name', 'assignee', 'createTime', 'duedate', 'priority', 'description', 'dbid']
        }),
        columns: [{
            header: App.locale['viewTaskManagement.name'],
            dataIndex: 'name'
        }, {
            header: App.locale['viewTaskManagement.assignTo'],
            dataIndex: 'assignee'
        }, {
            header: App.locale['viewTaskManagement.createTime'],
            dataIndex: 'createTime'
        }, {
            header: App.locale['viewTaskManagement.duedate'],
            dataIndex: 'duedate'
        }, {
            header: App.locale['viewTaskManagement.priority'],
            dataIndex: 'priority'
        }, {
            header: App.locale['viewTaskManagement.description'],
            dataIndex: 'description'
        }],
        bbar: new Ext.Toolbar(['->', {
            text: App.locale['take'],
            handler: function() {
                var selections = groupTasks.getSelectionModel().getSelections();
                if (selections.length == 1) {
                    var record = selections[0];
                    Ext.Ajax.request({
                        url: 'jbpm.do?action=takeTask',
                        params: {
                            id: record.get('dbid')
                        },
                        success: function() {
                            Ext.Msg.alert(App.locale['info'], App.locale['success']);
                            personalTasks.getStore().reload();
                            groupTasks.getStore().reload();
                        }
                    });
                }
            }
        }])
    });
    groupTasks.getStore().load();

    var panel = new Ext.Panel({
        id: 'ViewPersonalTasks',
        title: App.locale['viewPersonalTasks.title'],
        iconCls: 'taskManagement',
        closable: true,
        layout: 'absolute',
        items: [personalTasks, groupTasks]
    });
    return panel;
};