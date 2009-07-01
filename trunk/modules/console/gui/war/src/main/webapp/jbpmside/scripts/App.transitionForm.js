
App.showTransitionForm = function(type, id, fn) {
    var map = {
        taskComplete: {
            url: 'json/task-complete.jsp',
            id: 'dbid'
        },
        processStart: {
            url: 'json/process-start.jsp',
            id: 'id'
        },
        processSignal: {
            url: 'json/process-signal.jsp',
            id: 'id'
        }
    };
    var config = map[type];

    if (App.variableGrid) {
        App.variableGrid.destroy();
        App.variableGrid = null;
    }

    App.variableGrid = new Ext.grid.EditorGridPanel({
        viewConfig: {
            forceFit: true
        },
        store: new Ext.data.JsonStore({
            url: 'jbpm.do?action=variables',
            root: 'result',
            fields: ['name', 'value']
        }),
        columns: [{
            header: App.locale['variable.name'],
            dataIndex: 'name',
            editor: new Ext.grid.GridEditor(new Ext.form.TextField())
        }, {
            header: App.locale['variable.value'],
            dataIndex: 'value',
            editor: new Ext.grid.GridEditor(new Ext.form.TextField())
        }],
        tbar: new Ext.Toolbar([{
            text: App.locale['add'],
            handler: function() {
                var Record = Ext.data.Record.create([
                    'name', 'value'
                ]);
                App.variableGrid.stopEditing();
                App.variableGrid.store.insert(0, new Record({
                    name: '',
                    value: ''
                }));
                App.variableGrid.startEditing(0, 0);
            }
        }, '-', {
            text: App.locale['delete'],
            handler: function() {
                var sm = App.variableGrid.getSelectionModel();
                var cell = sm.getSelectedCell();

                var record = App.variableGrid.store.getAt(cell[0]);
                App.variableGrid.store.remove(record);
            }
        }])
    });

    var o = {};
    o.type = type;
    o[config.id] = id;
    App.variableGrid.getStore().removeAll();
    App.variableGrid.getStore().load({
        params: o
    });

    var callback = function(url, o, transition) {
        var params = {
            transition: transition,
            names: [],
            values: []
        };
        Ext.apply(params, o);
        var s = App.variableGrid.getStore();
        s.each(function(r) {
            params.names.push(r.get('name'));
            params.values.push(r.get('value'));
        });

        Ext.Ajax.request({
            url: url,
            params: params,
            success: function() {
                App.transitionForm.close();
                fn();
            }
        });
    };

    Ext.Ajax.request({
        url: 'jbpm.do?action=transitions',
        params: o,
        success: function(response) {
            var array = Ext.decode(response.responseText);
            var buttons = [];
            for (var i = 0; i < array.length; i++) {
                var url = 'jbpm.do?action=selectTransition';
                var text = array[i] == null ? App.locale['default'] : array[i];
                var transition = array[i];
                buttons.push({
                    text: text,
                    handler: callback.createDelegate(this, [url, o, transition])
                });
            }
            if (App.transitionForm) {
                App.transitionForm.destroy();
                App.transitionForm = null;
            }

            App.transitionForm = new Ext.Window({
                title: App.locale['variable.transition'],
                width: 400,
                height: 300,
                closeAction: 'hide',
                layout: 'fit',
                items: [App.variableGrid],
                buttons: buttons
            });

            App.transitionForm.show();
        }
    });

};
