
Ext.ns('App');

App.createViewProcessDefinition = function() {
    App.processDefinitions = new Ext.grid.GridPanel({
        title: App.locale['viewDefinitions.title'],
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
            url: 'jbpm.do?action=processDefinitions',
            root: 'result',
            fields: [{
                name: 'id'
            }, {
                name: 'name'
            }, {
                name: 'version'
            }, {
                name: 'dbid'
            }]
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
        bbar: new Ext.Toolbar(['->',{
            text: App.locale['view'],
            handler: function() {
                var selections = App.processDefinitions.getSelectionModel().getSelections();

                if (selections.length == 1) {
                    var record = selections[0];
                    var id = record.get('id');
                    var name = record.get('name');
                    var pdDbid = record.get('dbid');

                    var tabs = Ext.getCmp('centerTabPanel');
                    var tabItem = tabs.getItem('ViewProcessInstance-' + id);

                    if (tabItem == null) {
                        var viewProcessInstance = App.createViewProcessInstance(id, pdDbid);
                        tabItem = tabs.add(viewProcessInstance);
                        tabItem.setTitle(name);
                    }
                    tabs.activate(tabItem);
                }
            }
        },{
            text: App.locale['start'],
            handler: function() {
                var selections = App.processDefinitions.getSelectionModel().getSelections();
                if (selections.length == 1) {
                    var record = selections[0];
                    App.showTransitionForm('processStart', record.get('id'), function() {
                        Ext.Msg.alert(App.locale['info'], App.locale['success']);
                        App.processDefinitions.getStore().reload();
                        var id = record.get('id');
                        var name = record.get('name');
                        var pdDbid = record.get('dbid');

                        var tabs = Ext.getCmp('centerTabPanel');
                        var tabItem = tabs.getItem(id);
                        if (tabItem == null) {
                            var viewProcessInstance = App.createViewProcessInstance(id,pdDbid);
                            tabItem = tabs.add(viewProcessInstance);
                            tabItem.setTitle(name);
                        }
                        tabs.activate(tabItem);
                    });
                }
            }
        },{
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

    App.processes = new Ext.Panel ({
        id: 'ViewProcessDefinition',
        title: App.locale['viewDefinitions.title'],
        iconCls: 'processManagement',
        layout: 'absolute',
        items: [App.processDefinitions, {
            title: App.locale['aboutProcessDefinition.title'],
            iconCls: 'aboutProcessDefinition',
            x: 550,
            y: 20,
            width: 250,
            height: 200,
            html: App.locale['aboutProcessDefinition.content']
        }, {
            title: App.locale['mostActiveProcess.title'],
            iconCls: 'metricsAndStats',
            x: 550,
            y: 250,
            width: 250,
            height: 200,
            html: '<embed type="application/x-shockwave-flash" src="scripts/FusionCharts/FCF_Pie3D.swf" width="200" height="150"   id="mostActiveProcess" name="mostActiveProcess" quality="high" allowScriptAccess="always" flashvars="chartWidth=200&chartHeight=150&debugMode=0&DOMId=mostActiveProcess&registerWithJS=0&scaleMode=noScale&lang=EN&dataURL=mostActiveProcess.xml"/>',
            bbar: new Ext.Toolbar([
                '->',
                App.locale['moreMetrics']
            ])
        }]
    });
    return App.processes;
};