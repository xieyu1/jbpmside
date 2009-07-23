
App.createJpdl = function() {
    Jpdl.ActivityMap.activityBasePath = 'styles/jpdl/images/activities/48/';

    var p = new Ext.Panel({
        id: 'jpdl',
        title: 'JPDL',
        iconCls: 'setting',
        tbar: new Ext.Toolbar([
            'Open', '-', {
                text: 'Save',
                handler: function() {
                    var xml = Jpdl.model.serial();
                    Ext.Ajax.request({
                        method: 'post',
                        url: 'jbpm.do?action=deployXml',
                        success: function(response) {
                            Ext.Msg.alert('信息', '发布成功', function() {
                                Jpdl.model.clear();
                                App.processDefinitions.getStore().reload();
                            });
                        },
                        failure: function(response) {
                            Ext.Msg.alert('错误', '发布失败');
                        },
                        params: {
                            xml: xml
                        }
                    });
                }
            }
        ]),
        bbar: new Ext.Toolbar([
            '->', 'Position'
        ]),
        layout: 'border',
        items: [/*{
            region: 'west',
            title: 'menu',
            width: 150,
            layout: 'accordion',
            items: [{
                title: 'attributes'
            }, {
                title: 'elements'
            }, {
                title: 'forms'
            }]
        }, */{
            region: 'center',
            xtype: 'jpdlpanel'
        }]
    });
    return p;
};
