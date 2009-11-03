Ext.ns('App');

App.createAccordion = function() {
    App.accordion = {
        region: 'west',
        layout: 'accordion',
        split: true,
        width: '200',
        collapsible: true,
        listeners: {
            'beforerender': function() {
                Ext.Ajax.request({
                    url:'accordion.txt',
                    success: function(request) {
                        var data = Ext.decode(request.responseText);

                        for (var i = 0; i < data.root.length; i++) {
                            var item = data.root[i];

                            var panel = new Ext.Panel({
                                title: item.title,
                                iconCls: item.iconCls,
                                items: item.items,
                                region: 'west',
                                border: false
                            });

                            this.add(panel);
                            this.doLayout(true);
                        }
                    },
                    failure: function() {
                        Ext.Msg.alert('error');
                    },
                    scope: this
                });
            }
        }

    };
    return App.accordion;
};

/*App.createTree0 = function() {

    App.processManagementTree = {
        rootVisible : false,
        xtype: 'treepanel',
        root: new Ext.tree.AsyncTreeNode({
            text: 'Process Definitions',
            expanded: true
        }),
        loader: new Ext.tree.TreeLoader({dataUrl: 'processManagementTree.txt'}),
        listeners: {
            'click': App.clickNode
        }
    };

    return App.processManagementTree;
};

App.createTree1 = function() {

    App.taskManagementTree = {
        rootVisible : false,
        xtype: 'treepanel',
        root: new Ext.tree.AsyncTreeNode({
            text: 'Task',
            expanded: true
        }),
        loader: new Ext.tree.TreeLoader({dataUrl: 'taskManagementTree.txt'}),
        listeners: {
            'click': App.clickNode
        }
    };

    return App.processManageTree;
};

App.createTree2 = function() {

    App.metricsAndStatsTree = {
        rootVisible : false,
        xtype: 'treepanel',
        root: new Ext.tree.AsyncTreeNode({
            text: 'Metrics And Stats',
            expanded: true
        }),
        loader: new Ext.tree.TreeLoader({dataUrl: 'metricsAndStatsTree.txt'}),
        listeners: {
            'click': App.clickNode
        }
    };

    return App.metricsAndStatsTree;
};
*/
App.clickNode = function(node) {
    if (node.id == 'Logout') {
        App.security.logout();
    } else {
        var tabs = Ext.getCmp('centerTabPanel');
        var tabItem = tabs.getItem(node.id);

        if (tabItem == null) {
            eval("tabItem = tabs.add(App.create" + node.id + "())");
        }
        tabs.activate(tabItem);
    }
}

App.createProcessWorkLoad = function() {
    return {
        id: 'processWorkLoad',
        title: App.locale['processWorkLoad.title'],
        closable: true,
        iconCls: 'metricsAndStats',
        html: App.locale['processWorkLoad.content']
    }
}
App.createExportStats = function() {
    return {
        id: 'ExportStats',
        closable: true,
        title: App.locale['exportStats.title'],
        iconCls: 'metricsAndStats',
        html: App.locale['exportStats.content']
    };
};
