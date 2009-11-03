
Ext.JpdlPanel = Ext.extend(Ext.Panel, {
    initComponent: function() {
        this.on('bodyresize', function(p, w, h) {
            var b = p.getBox();
            this.jpdlCanvas.setX(b.x);
            this.jpdlCanvas.setWidth(b.width - 200);
            this.jpdlCanvas.setHeight(b.height);
            this.jpdlPalette.setX(b.x + this.jpdlCanvas.getWidth());
            this.jpdlPalette.setHeight(b.height);
            this.jpdlModel.resize(b.x, b.y, b.width - 200, b.height);
        });
    },

    afterRender: function() {
        Ext.JpdlPanel.superclass.afterRender.call(this);
        var box = this.getBox();

        Ext.DomHelper.append(this.body, [{
            id: '_jpdl_canvas',
            tag: 'div',
            cls: 'jpdlcanvas'
        }, {
            id: '_jpdl_palette',
            tag: 'div',
            cls: 'jpdlpalette',
            html: this.createPalette()
        }]);

        this.jpdlCanvas = Ext.get('_jpdl_canvas');
        this.jpdlPalette = Ext.get('_jpdl_palette');
        this.jpdlModel = new Jpdl.Model({
            id: '_jpdl_canvas'
        });
    },

    createPalette: function() {
        // header
        var html = '<div class="dragHandle move">'
            +'<span class="move" unselectable="on">palette</span>'
            +'</div>';
        html += '<ul>'
        // part1
        html += this.createPart('Operations',['select','marquee']);
        // part2
        html += this.createPart('Components',['transition-straight','transition-broken','start','end','cancel','error',
            'state','hql','sql','java','script','esb','task','decision','fork','join']);
        html += '</ul>'
        return html;
    },

    createPart: function(title, items) {
        var html = '<li class="paletteBar"><div unselectable="on">' + title+ '</div><ul>';
        for (var i = 0; i < items.length; i++) {
            var t = items[i];
            html += '<li id="' + t + '" class="paletteItem ' + t + '">'
                + '<span class="paletteItem-' + t + '" unselectable="on">' + t + '</span>'
                + '</li>';
        }
        html += '</ul></li>';
        return html;
    }
});
Ext.reg('jpdlpanel', Ext.JpdlPanel);
/*
Ext.onReady(function() {
    var viewport = new Ext.Viewport({
        layout: 'fit',
        items: [{
            tbar: new Ext.Toolbar([
                'Open', '-', 'Save'
            ]),
            bbar: new Ext.Toolbar([
                '->', 'Position'
            ]),
            layout: 'border',
            items: [{
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
            }, {
                region: 'center',
                xtype: 'jpdlpanel'
            }]
        }]
    });
});
*/
/*
Jpdl.onReady(function(){
    var model = new Jpdl.Model({
        id: 'canvas'
    });
});
*/
