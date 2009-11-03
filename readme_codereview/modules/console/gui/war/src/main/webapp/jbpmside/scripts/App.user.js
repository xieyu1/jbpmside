
App.createUser = function() {

    App.userGrid = new Ext.grid.GridPanel({
        x: 20,
        y: 20,
        width: 500,
        height: 200,
        loadMask: true,
        shim: true,
        viewConfig: {
            forceFit: true
        },
        store: new Ext.data.JsonStore({
            url: 'jbpm.do?action=users',
            root: 'result',
            fields: ['id', 'givenName', 'familyName', 'groups']
        }),
        columns: [{
            header: App.locale['user.id'],
            dataIndex: 'id'
        }, {
            header: App.locale['user.givenName'],
            dataIndex: 'givenName'
        }, {
            header: App.locale['user.familyName'],
            dataIndex: 'familyName'
        }, {
            header: App.locale['user.groups'],
            dataIndex: 'groups'
        }],
        bbar: new Ext.Toolbar(['->', {
            text: App.locale['delete'],
            handler: function() {
                var selections = App.userGrid.getSelectionModel().getSelections();
                if (selections.length == 1) {
                    var record = selections[0];
                    var id = record.get('id');
                    Ext.Ajax.request({
                        url: 'jbpm.do?action=removeUser',
                        params: {
                            id: id
                        },
                        success: function() {
                            App.userGrid.getStore().reload();
                        }
                    });
                }
            }
        }])
    });

    App.userGrid.on('rowclick', function(grid, rowindex, e) {
        var userId = grid.getStore().getAt(rowindex).get("id");
        App.membershipGrid.getStore().load({
            params: {
                userId: userId
            }
        });
    });

    App.userForm = new Ext.form.FormPanel({
        x: 550,
        y: 20,
        width: 250,
        height: 200,
        title: App.locale['userDetail.title'],
        iconCls: 'users',
        frame: true,
        defaultType: 'textfield',
        items: [{
            fieldLabel: App.locale['user.id'],
            name: 'id'
        }, {
            fieldLabel: App.locale['user.password'],
            name: 'password',
            inputType: 'password'
        }, {
            fieldLabel: App.locale['user.givenName'],
            name: 'givenName'
        }, {
            fieldLabel: App.locale['user.familyName'],
            name: 'familyName'
        }],
        buttons: [{
            text: App.locale['submit'],
            handler: function() {
                App.userForm.getForm().submit({
                    url: 'jbpm.do?action=addUser',
                    success: function(form, action) {
                        App.userGrid.getStore().reload();
                    }
                });
            }
        }]
    });

    App.membershipGrid = new Ext.grid.GridPanel({
        x: 20,
        y: 250,
        width: 500,
        height: 200,
        loadMask: true,
        shim: true,
        viewConfig: {
            forceFit: true
        },
        store: new Ext.data.JsonStore({
            url: 'jbpm.do?action=members',
            root: 'result',
            fields: ['userId', 'groupId', 'groupName', 'groupType', 'membershipRole']
        }),
        columns: [{
            header: App.locale['membership.groupName'],
            dataIndex: 'groupName'
        }, {
            header: App.locale['membership.groupType'],
            dataIndex: 'groupType'
        }, {
            header: App.locale['membership.role'],
            dataIndex: 'membershipRole'
        }],
        bbar: new Ext.Toolbar(['->', {
            text: App.locale['delete'],
            handler: function() {
                var selections = App.membershipGrid.getSelectionModel().getSelections();
                if (selections.length == 1) {
                    var record = selections[0];

                    Ext.Ajax.request({
                        url: 'jbpm.do?action=removeMember',
                        params: {
                            userId: record.get('userId'),
                            groupId: record.get('groupId'),
                            role: record.get('membershipRole')
                        },
                        success: function() {
                            App.userGrid.getStore().reload();
                            App.membershipGrid.getStore().reload();
                        }
                    });
                }
            }
        }])
    });

    App.membershipForm = new Ext.form.FormPanel({
        x: 550,
        y: 250,
        width: 250,
        height: 200,
        title: App.locale['membershipDetail.title'],
        iconCls: 'users',
        frame: true,
        defaultType: 'textfield',
        items: [{
            xtype: 'combo',
            fieldLabel: App.locale['membership.user'],
            hiddenName: 'userId',
            name: 'userName',
            anchor: '95%',
            valueField: 'id',
            displayField: 'givenName',
            readOnly: true,
            typeAhead: true,
            mode: 'remote',
            triggerAction: 'all',
            emptyText: App.locale['emptySelect'],
            selectOnFocus: true,
            allowBlank: false,
            store: new Ext.data.JsonStore({
                url: 'jbpm.do?action=users',
                root: 'result',
                fields: ['id', 'givenName']
            })
        }, {
            xtype: 'combo',
            fieldLabel: App.locale['membership.user'],
            hiddenName: 'groupId',
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
            allowBlank: false,
            store: new Ext.data.JsonStore({
                url: 'jbpm.do?action=groups',
                root: 'result',
                fields: ['id', 'name']
            })
        }, {
            fieldLabel: App.locale['membership.role'],
            name: 'role',
            anchor: '95%'
        }],
        buttons: [{
            text: App.locale['submit'],
            handler: function() {
                App.membershipForm.getForm().submit({
                    url: 'jbpm.do?action=addMember',
                    success: function(form, action) {
                        App.userGrid.getStore().reload();
                        App.membershipGrid.getStore().reload();
                    }
                });
            }
        }]
    });

    var panel = new Ext.Panel({
        id: 'User',
        closable: true,
        title: App.locale['user.title'],
        iconCls: 'users',
        layout: 'absolute',
        items: [
            App.userGrid,
            App.userForm,
            App.membershipGrid,
            App.membershipForm
        ]
    });

    App.userGrid.getStore().load();

    return panel;
};

