Ext.ns('App');

App.store = new Ext.data.JsonStore({
	autoDestroy: true,
	url: 'data.txt',
	root: 'root', 
	fields: ['name', {name:'visits', type: 'int'}, {name:'views', type:'int'}]
});
App.store.load();

App.createColumnChart = function() {
	App.columnChart = {
		xtype: 'panel',
		frame: true,
		width: 500,
        height: 300,
		closable: false,
		items: [{
			xtype: 'columnchart',
			store: App.store,
			url: './scripts/ext-3.0-rc1.1/resources/charts.swf',
			xField: 'name',
			yField: 'visits',
			yAxis: new Ext.chart.NumericAxis({
			displayName: 'Visits',
			labelRenderer: Ext.util.Format.numberRenderer('0.0')
			}),
			tipRenderer: function() {
				return Ext.util.Format.number(record.data.visits, '0.0') + ' visit in ' + record.data.name	
			},
			chartStyle: {
                padding: 10,
                animationEnabled: true,
                font: {
                    name: 'Tahoma',
                    color: 0x444444,
                    size: 11
                },
                dataTip: {
                    padding: 5,
                    border: {
                        color: 0x99bbe8,
                        size:1
                    },
                    background: {
                        color: 0xDAE7F6,
                        alpha: .9
                    },
                    font: {
                        name: 'Tahoma',
                        color: 0x15428B,
                        size: 10,
                        bold: true
                    }
                },
                xAxis: {
                    color: 0x69aBc8,
                    majorTicks: {color: 0x69aBc8, length: 4},
                    minorTicks: {color: 0x69aBc8, length: 2},
                    majorGridLines: {size: 1, color: 0xeeeeee}
                },
                yAxis: {
                    color: 0x69aBc8,
                    majorTicks: {color: 0x69aBc8, length: 4},
                    minorTicks: {color: 0x69aBc8, length: 2},
                    majorGridLines: {size: 1, color: 0xdfe8f6}
                }
            },
            series: [{
                type: 'column',
                displayName: 'Page Views',
                yField: 'views',
                style: {
                    image:'bar.gif',
                    mode: 'stretch',
                    color:0x99BBE8
                }
            },{
                type:'line',
                displayName: 'Visits',
                yField: 'visits',
                style: {
                    color: 0x15428B
                }
            }]
		}]
	};
	App.createPieChart();
	App.chartPanel = new Ext.Panel ({
		id: 'ViewChart',
		title: 'chart',
		iconCls: 'metricsAndStats',
		layout: 'absolute',
		items: [App.columnChart, {
			title: 'About Chart',
			iconCls: 'aboutProcessDefinition',
			x: 550,
			y: 20,
			width: 250,
			height: 200,
			html: 'Process definitions are the base classes for any process instance. They act as an execution template for BPM engine.'
		}, {
			title: 'Most Active Process',
            iconCls: 'metricsAndStats',
            x: 550,
            y: 250,
            width: 250,
            height: 200,
			layout:'fit',
            items:[App.pieChart],
            bbar: new Ext.Toolbar([
                '->',
                'More Metrics'
            ])
		}]
	});
	


	return App.chartPanel;
};


App.createPieChart = function() {
	App.pieChart = {
        iconCls:'chart',
        frame:true,
        layout:'fit',

        items: {
            xtype: 'piechart',
            store: App.store,
            url: './scripts/ext-3.0-rc1.1/resources/charts.swf',
            xField: 'name',
            yField: 'visits',
            yAxis: new Ext.chart.NumericAxis({
                displayName: 'Visits',
                labelRenderer : Ext.util.Format.numberRenderer('0,0')
            }),
            tipRenderer : function(chart, record){
                return Ext.util.Format.number(record.data.visits, '0,0') + ' visits in ' + record.data.name;
            }
        }
	};
	
	
	return App.pieChart;
};