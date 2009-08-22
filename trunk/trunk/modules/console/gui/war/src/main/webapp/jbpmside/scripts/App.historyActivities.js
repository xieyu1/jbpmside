

App.createViewHistoryActivities = function(piId) {
    var historyActivities = new Ext.grid.GridPanel({
        id: 'ha-' + piId,
        title: App.locale['historyActivities.title'],
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
            url: 'jbpm.do?action=historyActivities',
            root: 'result',
            fields: ['activityName', 'startTime', 'endTime', 'duration'],
            baseParams: {
                id: piId
            }
        }),
        columns: [{
            header: App.locale['historyActivities.activityName'],
            dataIndex: 'activityName'
        }, {
            header: App.locale['historyActivities.startTime'],
            dataIndex: 'startTime'
        }, {
            header: App.locale['historyActivities.endTime'],
            dataIndex: 'endTime'
        }, {
            header: App.locale['historyActivities.duration'],
            dataIndex: 'duration'
        }]
    });
    historyActivities.getStore().load();

    var panel = new Ext.Panel({
        id: 'ViewHistoryActivities-' + piId,
        iconCls: 'processInstance',
        closable: true,
        layout: 'absolute',
        items: [historyActivities]
    });
    return panel;
};
