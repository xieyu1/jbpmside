
Ext.ns('App');

App.createOperationEmulational = function() {
	App.emunationalTree = new Ext.tree.TreePanel({
		animate:true,
        autoScroll:true,
        loader: new Ext.tree.TreeLoader({dataUrl:'jbpm.do?action=emulational'}),
        containerScroll: true,
        border: false,
		region:'west',
        height: 300,
        width: 200,
		root: new Ext.tree.AsyncTreeNode({
			id: 'emulational',
			text: App.locale['emulational.title'],
			draggable: false	
		})	
	});
	App.emunationalForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        title: '业务仿真',
        labelWidth: 50,
        frame:true,
		region:'center',
        width: 600,
		height: 400,
        items: [{
        	layout: 'column',
        	items: [{
        		columnWidth: .5,
        		layout: 'form',
        		defaultType: 'textfield',
        		items: [{
		            fieldLabel: '申请人',
					anchor: '90%',
		            name: 'proposer'
        		},{
        			fieldLabel: '决策值',
					anchor: '90%',
        			name: 'desicion'
        		}]
        	},{
        		columnWidth: .5,
        		layout: 'form',
        		defaultType: 'textfield',
        		items: [{
		            fieldLabel: '标题',
					anchor: '90%',
		            name: 'title'
        		},{
        			fieldLabel: '优先级',
					anchor: '90%',
        			name: 'pri'
        		}]
        	}]
        	
        }, {
			width: 345,
            height: 100,
            xtype: 'textarea',
			anchor: '95%',
            fieldLabel: '备注'
		}],
        buttons: [{
            text: '保存',
            handler: function() {
                form.getForm().submit();
            }
        },{
            text: '提交任务',
            handler: function() {
                form.getForm().submit();
            }
        }]
	});
	
	App.emunationalGrid = new Ext.grid.GridPanel({
		region: 'south',
		title: App.locale['viewEmunational.head'],
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
            url: 'jbpm.do?action=processInstances',
            root: 'result',
            fields: ['proposer', 'title', 'desicion', 'pri']
        }),
        columns: [{
            header: App.locale['viewEmunational.proposer'],
            dataIndex: 'proposer'
        }, {
            header: App.locale['viewEmunational.title'],
            dataIndex: 'title'
        }, {
            header: App.locale['viewEmunational.desicion'],
            dataIndex: 'desicion'
        }, {
            header: App.locale['viewEmunational.pri'],
            dataIndex: 'pri'
        }]
	});

	App.panel = new Ext.Panel({
		id: 'OperationEmulational',
		iconCls: 'metricsAndStats',
		layout: 'absolute',
		title: '仿真',
		items: [{
			layout: 'border',
			//bodyStyle: 'background-color:white',
			x: 30,
			y: 30,
			height: 450,
			width: 800,
			items: [App.emunationalTree,{
				layout: 'border',
				region: 'center',
				items:[App.emunationalForm,App.emunationalGrid]
			}]
		},{
            id: 'emunational',
            title: App.locale['emunationalDetail.title'],
            iconCls: 'aboutProcessDefinition',
            x: 850,
            y: 30,
            width: 200,
            height: 450,
            layout: 'fit',
            items: [{
                html: App.locale['emunationalDetail.content']
			}]
		}]
	});
		
	return App.panel;
}