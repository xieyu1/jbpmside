Ext.ns('App', 'App.locale');

App.init = function() {
    Ext.QuickTips.init();

    App.security.createLoginWindow();
    App.security.checkLogin();

    App.accordion = App.createAccordion();
    App.viewProcessDefinition = App.createViewProcessDefinition();
    App.processDefinitions.store.load();
    App.uploadNewProcessDefinition = App.createUploadNewProcessDefinition();
    //App.chart = App.createColumnChart();

    App.centerTabPanel = {
        id: 'centerTabPanel',
        activeTab: 0,
        region: 'center',
        xtype: 'tabpanel',
        layoutOnTabChange: true,
        enableTabScroll: true,
        items: [
            App.viewProcessDefinition,
            App.uploadNewProcessDefinition
        ]
    };

    var viewPort = new Ext.Viewport({
        layout: 'border',
        items: [{
            region: 'north',
            height: 50,
            contentEl: 'nav_area'
        },{
            region: 'south',
            height: 18,
            contentEl: 'state_area'
        },App.centerTabPanel,App.accordion]
    });

    setTimeout(function(){
        Ext.get('loading').remove();
        Ext.get('loading-mask').fadeOut({remove:true});
    }, 100);
}

Ext.onReady(App.init, App);
