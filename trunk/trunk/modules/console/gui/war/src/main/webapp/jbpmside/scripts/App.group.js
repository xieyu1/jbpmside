
App.createGroup = function() {

    App.groupGrid = new Ext.grid.GridPanel({
        x: 20,
        y: 20,
        width: 500,
        height: 350,
        loadMask: true,
        shim: true,
        viewConfig: {
            forceFit: true
        },
        store: new Ext.data.JsonStore({
            url: 'jbpm.do?action=groups',
            root: 'result',
            fields: ['id', 'name', 'type']
        }),
        columns: [{
            header: App.locale['group.id'],
            dataIndex: 'id'
        }, {
            header: App.locale['group.name'],
            dataIndex: 'name'
        }, {
            header: App.locale['group.type'],
            dataIndex: 'type'
        }],
        bbar: new Ext.Toolbar(['->', {
            text: App.locale['delete'],
            handler: function() {
                var selections = App.groupGrid.getSelectionModel().getSelections();
                if (selections.length == 1) {
                    var record = selections[0];
                    var id = record.get('id');
                    Ext.Ajax.request({
                        url: 'jbpm.do?action=removeGroup',
                        params: {
                            id: id
                        },
                        success: function() {
                            App.groupGrid.getStore().reload();
                        }
                    });
                }
            }
        }])
    });

    App.groupForm = new Ext.form.FormPanel({
        x: 550,
        y: 20,
        width: 250,
        height: 200,
        title: App.locale['groupDetail.title'],
        iconCls: 'group',
        frame: true,
        defaultType: 'textfield',
        items: [{
            fieldLabel: App.locale['group.name'],
            name: 'name'
        }, {
            fieldLabel: App.locale['group.type'],
            name: 'type'
        }, {
            xtype: 'combo',
            fieldLabel: App.locale['group.parent'],
            hiddenName: 'parentGroupId',
            name: 'groupName',
            anchor: '95%',
            valueField: 'id',
            displayField: 'name',
            readOnly: true,
            typeAhead: true,
            mode: 'remote',
            triggerAction: 'all',
            emptyText: App.locale['emptySelect'],
            selectOnFocus: true,
            store: new Ext.data.JsonStore({
                url: 'jbpm.do?action=groups',
                root: 'result',
                fields: ['id', 'name']
            })
        }],
        buttons: [{
            text: App.locale['submit'],
            handler: function() {
                App.groupForm.getForm().submit({
                    url: 'jbpm.do?action=addGroup',
                    success: function(form, action) {
                        App.groupGrid.getStore().reload();
                    }
                });
            }
        }]
    });

    var panel = new Ext.Panel({
        id: 'Group',
        closable: true,
        title: App.locale['group.title'],
        iconCls: 'group',
        layout: 'absolute',
        items: [
            App.groupGrid,
            App.groupForm
        ]
    });

    App.groupGrid.getStore().load();
    return panel;
};

