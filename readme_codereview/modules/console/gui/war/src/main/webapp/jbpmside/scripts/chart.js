/**
 * @author kayzhan
 * 
 * chart for ext 2009-04-19
 */

 
 Ext.onReady(function() {
	Ext.BLANK_IMAGE_URL = 'images/default/s.gif';
	
	var store = new Ext.data.JsonStore({
		autoDestroy: true,
		url: 'data.txt',
		root: 'root', // *see Note  
		fields: ['name', {name:'visits', type: 'int'}, {name:'views', type:'int'}]
	});
	store.load();
	new Ext.Panel({
		title: 'Simple line chart',
		renderTo: 'container',
		width: 500,
		height: 300,
		layout: 'fit',

		items:{
		    xtype: 'linechart',
		    store: store,
			xField: 'name',
			yField: 'visits',
			listeners: {
				itemclick: function(o) {
					var rec = store.getAt(o.index);
					Ext.example.msg('Item selected', 'You choose {0}', rec.get('name'));
				}
			}
		}
	});
	
	 // extra simple
    new Ext.Panel({
        iconCls:'chart',
        title: 'swf chart',
        frame:true,
        renderTo: 'container',
        width:500,
        height:300,
        layout:'fit',

        items: {
            xtype: 'linechart',
            store: store,
            url: 'ext3.0/resources/charts.swf',
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
    });

	new Ext.Panel({
		iconCls: 'chart',
		title: 'hight chart',
		frame: true,
		width: 500,
		height: 300,
		layout: 'fit',
		renderTo: 'container',
		items: {
			xtype: 'columnchart',
			store: store,
			url: 'ext3.0/resources/charts.swf',
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
					name: 'Tohoma',
					color: 0x99cce8,
					size: 11
				},
				dataTip: {
					padding: 5,
					border: {
						color: 0xfffff0,
						size: 1
					},
					background: {
						color: 0x33333f,
						alpaha: .9	
					},
					font: {
						name: 'Tohoma',
						size: 5,
						color: 0x555333,
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
                    image:'images/icons/bar.gif',
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
		}
	});
 });

