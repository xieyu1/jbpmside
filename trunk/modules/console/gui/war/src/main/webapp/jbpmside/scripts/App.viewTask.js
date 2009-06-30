
Ext.ns('App');

App.createViewTaskManagement = function() {
    var tasks = new Ext.grid.GridPanel({
        id: 'taskView',
        title: App.locale['viewTaskManagement.title'],
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
            url: 'jbpm.do?action=tasks',
            root: 'result',
            fields: [{
                name: 'name'
            }, {
                name: 'assignee'
            }, {
                name: 'create'
            }, {
                name: 'dueDate'
            }, {
                name: 'priority'
            }, {
                name: 'description'
            }, {
                name: 'dbid'
            }]
        }),
        columns: [{
            header: App.locale['viewTaskManagement.name'],
            dataIndex: 'name'
        }, {
            header: App.locale['viewTaskManagement.assignTo'],
            dataIndex: 'assignee'
        }, {
            header: App.locale['viewTaskManagement.create'],
            dataIndex: 'create'
        }, {
            header: App.locale['viewTaskManagement.dueDate'],
            dataIndex: 'dueDate'
        }, {
            header: App.locale['viewTaskManagement.priority'],
            dataIndex: 'priority'
        }, {
            header: App.locale['viewTaskManagement.description'],
            dataIndex: 'description'
        }],
        bbar: new Ext.Toolbar(['->',{
            text: App.locale['complete'],
            handler: function() {
                var selections = tasks.getSelectionModel().getSelections();
                if (selections.length == 1) {
                    var record = selections[0];
                    App.showTransitionForm('taskComplete', record.get('dbid'), function() {
                        tasks.getStore().reload();
                    });
                }
            }
        }])
    });
    tasks.on('rowclick', function(grid,rowIndex) {
        var r = grid.getStore().getAt(rowIndex);
        Ext.getCmp('taskDetail').removeAll();
        Ext.getCmp('taskDetail').add({
            html: '<p>' + App.locale['viewTaskManagement.name'] + ':' + r.get('name') + '</p>'
                + '<p>' + App.locale['viewTaskManagement.assignTo'] + ':' + r.get('assignee') + '</p>'
                + '<p>' + App.locale['viewTaskManagement.create'] + ':' + r.get('create') + '</p>'
                + '<p>' + App.locale['viewTaskManagement.dueDate'] + ':' + r.get('dueDate') + '</p>'
                + '<p>' + App.locale['viewTaskManagement.priority'] + ':' + r.get('priority') + '</p>'
                + '<p>' + App.locale['viewTaskManagement.description'] + ':' + r.get('description') + '</p>'
        });
        Ext.getCmp('taskDetail').doLayout();
    });
    tasks.getStore().load();
    var treePanel = new Ext.Panel({
        id: 'ViewTaskManagement',
        title: App.locale['viewTaskManagement.title'],
        iconCls: 'taskManagement',
        closable: true,
        layout: 'absolute',
        items: [tasks, {
            id: 'taskDetail',
            title: App.locale['taskDetail.title'],
            iconCls: 'taskManagement',
            x: 20,
            y: 300,
            width: 500,
            height: 180,
            layout: 'fit',
            items: [{
                html: App.locale['taskDetail.content']
            }]
        }]
    });
    return treePanel;
};