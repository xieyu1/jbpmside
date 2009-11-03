
Ext.ns('App');

App.createViewJob = function() {
    var viewJob = new Ext.grid.GridPanel({
        title: App.locale['viewJob.title'],
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
            url: 'jbpm.do?action=jobs',
            root: 'result',
            fields: ['dbid', 'lockOwner', 'dueDate', 'exception', 'retries', 'exclusive', 'lockExpirationTime']
        }),
        columns: [{
            header: App.locale['viewJob.lockOwner'],
            dataIndex: 'lockOwner'
        },{
            header: App.locale['viewJob.dueDate'],
            dataIndex: 'dueDate'
        },{
            header: App.locale['viewJob.exception'],
            dataIndex: 'exception'
        },{
            header: App.locale['viewJob.retries'],
            dataIndex: 'retries'
        },{
            header: App.locale['viewJob.exclusive'],
            dataIndex: 'exclusive'
        },{
            header: App.locale['viewJob.lockExpirationTime'],
            dataIndex: 'lockExpirationTime'
        }]
    });

    viewJob.store.load();

    var panel = new Ext.Panel ({
        id: 'ViewJob',
        title: App.locale['viewJob.title'],
        iconCls: 'processManagement',
        layout: 'absolute',
        closable: true,
        items: [viewJob]
    });
    return panel;
};
