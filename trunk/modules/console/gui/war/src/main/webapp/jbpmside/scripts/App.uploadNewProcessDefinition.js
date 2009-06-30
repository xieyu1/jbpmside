
Ext.ns('App');

App.createUploadNewProcessDefinition = function() {
    var form = new Ext.form.FormPanel({
        title: App.locale['uploadNewDefinition.title'],
        x: 20,
        y: 20,
        width: 350,
        height: 100,
        fileUpload: true,
        labelAlign: 'right',
        url: 'jbpm.do?action=deploy',
        items: [{
            xtype: "fileuploadfield",
            name: 'processFile',
            fieldLabel: App.locale['processFile']
        }],
        buttons: [{
            text: App.locale['deploy'],
            handler: function() {
                form.getForm().submit({
                    success: function() {
                        Ext.Msg.alert(App.locale['info'], App.locale['success'], function() {
                            App.processDefinitions.getStore().reload();
                            //form.getForm().reset();
                        });
                    }
                });
            }
        }]
    });

    return {
        id: 'UploadNewProcessDefinition',
        title: App.locale['uploadNewDefinition.title'],
        iconCls: 'processManagement',
        layout: 'absolute',
        items: [form]
    };
};
