
Ext.ns('App');

App.createViewProcessInstance = function(pdId, pdDbid) {
    var processInstances = new Ext.grid.GridPanel({
        id: 'piView-' + pdId,
        title: App.locale['viewProcessInstances.title'],
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
            url: 'jbpm.do?action=processInstances',
            root: 'result',
            fields: [{
                name: 'id'
            }, {
                name: 'name'
            }, {
                name: 'key'
            }, {
                name: 'state'
            }],
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
            text: App.locale['view'],
            handler: function() {
                var selections = processInstances.getSelectionModel().getSelections();
                if (selections.length == 1) {
                    var record = selections[0];
                    var id = record.get('id');
                    var key = record.get('key');
                    var dbid = record.get('dbid');
                    //

                    var tabs = Ext.getCmp('centerTabPanel');
                    var tabItem = tabs.getItem('DetailProcessInstance-' + id);
                    if (tabItem == null) {
                        var detailProcessInstance = App.createDetailProcessInstance(id, pdDbid);
                        tabItem = tabs.add(detailProcessInstance);
                        tabItem.setTitle(id);
                    }
                    tabs.activate(tabItem);
                }
            }
        }, {
            text: App.locale['signal'],
            handler: function() {
                var selections = processInstances.getSelectionModel().getSelections();
                if (selections.length == 1) {
                    var record = selections[0];
                    App.showTransitionForm('processSignal', record.get('id'), function() {
                        Ext.Msg.alert(App.locale['info'], App.locale['success']);
                        processInstances.getStore().reload();
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
    processInstances.on('rowclick', function(grid, rowIndex) {
        var r = grid.getStore().getAt(rowIndex);
        Ext.getCmp('piDetail-' + pdId).removeAll();
        Ext.getCmp('piDetail-' + pdId).add({
            html: '<p>' + App.locale['viewProcessInstances.id'] + ':' + r.get('id') + '</p>'
                + '<p>' + App.locale['viewProcessInstances.name'] + ':' + r.get('name') + '</p>'
                + '<p>' + App.locale['viewProcessInstances.key'] + ':' + r.get('key') + '</p>'
                + '<p>' + App.locale['viewProcessInstances.state'] + ':' + r.get('state') + '</p>'
        });
        Ext.getCmp('piDetail-' + pdId).doLayout();
    });
    processInstances.getStore().load();

    var panel = new Ext.Panel({
        id: 'ViewProcessInstance-' + pdId,
        iconCls: 'processInstance',
        closable: true,
        layout: 'absolute',
        items: [processInstances, {
            id: 'piDetail-' + pdId,
            title: App.locale['processInstanceDetail.title'],
            iconCls: 'aboutProcessDefinition',
            x: 20,
            y: 300,
            width: 500,
            height: 150,
            layout: 'fit',
            items: [{
                html: App.locale['processInstanceDetail.content']
            }]
        }]
    });
    return panel;
};
