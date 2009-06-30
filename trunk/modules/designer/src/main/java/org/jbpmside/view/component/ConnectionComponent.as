package org.jbpmside.view.component
{
	import com.degrafa.geometry.Circle;
	import com.degrafa.geometry.Line;
	import com.degrafa.geometry.Polygon;
	import com.degrafa.paint.SolidFill;
	import com.degrafa.paint.SolidStroke;
	
	import flash.geom.Point;
	
	import mx.styles.StyleManager;
	
	public class ConnectionComponent extends ShapeComponent
	{
		//####################################################
		//	连接点
		//####################################################
		private var _fromNode:NodeComponent;
		private var _toNode:NodeComponent;	
		private var _linkFrom:LinkPoint;
		private var _linkTo:LinkPoint;
		
		//####################################################
		//	图形渲染部分
		//####################################################	
		private var _straightLine:Line;
		private var _controlPoint:Circle;
		private var _controlPosition:Point;
		private var _arrow:Polygon;
		private var _straightLineStroke:SolidStroke;
		private var _controlStroke:SolidStroke;
		private var _arrowFill:SolidFill;
		private var _selectedStraightLineStroke:SolidStroke;
		private var _selectedControlStroke:SolidStroke;
		private var _selectedArrowFill:SolidFill;

		public function ConnectionComponent(){
			super();
		}
		
		public function set fromNode(_fromNode:NodeComponent):void{
			this._fromNode = _fromNode;
			fromNode.addLeaveConnection(this);
		}
		
		public function get fromNode():NodeComponent{
			return _fromNode;
		}
		
		public function set toNode(_toNode:NodeComponent):void{
			this._toNode = _toNode;
			toNode.addArriveConnection(this);
		}
		
		public function get toNode():NodeComponent{
			return _toNode;
		}
		
		
		public override function addEventListeners():void{
			super.addEventListeners();
		}
		
		public override function init():void
		{
			_straightLineStroke = new SolidStroke();
            _straightLineStroke.color = 0;
            _straightLineStroke.weight = 1;
            
			_selectedStraightLineStroke = new SolidStroke();
            _selectedStraightLineStroke.color = StyleManager.getColorName("#88b5f2");
            _selectedStraightLineStroke.weight = 1;
            
            _controlStroke = new SolidStroke();
            _controlStroke.color = 0;
            _controlStroke.weight = 3;
            
            _selectedControlStroke = new SolidStroke();
            _selectedControlStroke.color = StyleManager.getColorName("#88b5f2");
            _selectedControlStroke.weight = 3;
			
			_straightLine = new Line(0,0,0,0);
			_straightLine.stroke = _straightLineStroke;
			
			this.geometryCollection.addItem(_straightLine);
			
			_controlPosition = new Point(0,0);
			
			_controlPoint = new Circle(_controlPosition.x,_controlPosition.y,2);
			_controlPoint.stroke = _controlStroke;
			
			this.geometryCollection.addItem(_controlPoint);
			
			_arrow = new Polygon();
			_arrowFill=new SolidFill();;
			_arrowFill.color=0;
			
			_selectedArrowFill=new SolidFill();;
			_selectedArrowFill.color=StyleManager.getColorName("#88b5f2");
			
			_arrow.fill=_arrowFill;
			_arrow.stroke=_straightLineStroke;
			this.geometryCollection.addItem(_arrow);
			
//			refreshPosition();
		}
		
		public function refreshPosition():void{
			setLinkPoints();
			_straightLineStroke.alpha = 0.8;
				
			_straightLine.x = _linkFrom.stageX;
			_straightLine.y = _linkFrom.stageY;
			_straightLine.x1 = _linkTo.stageX;
			_straightLine.y1 = _linkTo.stageY;
				
			_controlPosition = Point.interpolate(new Point(_linkFrom.stageX,_linkFrom.stageY),new Point(_linkTo.stageX, _linkTo.stageY),0.5);
			_controlPoint.centerX = _controlPosition.x;
			_controlPoint.centerY = _controlPosition.y;
			
			labelField.x=_controlPoint.centerX-labelField.width/2;
          	labelField.y=_controlPoint.centerY-labelField.height;
			countArrowPosition();	
			this.draw(null,null);
		}
		
		//根据节点的相对位置选择节点的连接点
		private function setLinkPoints():void{
			if(_fromNode.x<=_toNode.x){
				this._linkFrom = _fromNode.rightLinkPoint;
				this._linkTo = _toNode.leftLinkPoint;
			}else{
				this._linkFrom = _fromNode.leftLinkPoint;
				this._linkTo = _toNode.rightLinkPoint;
			}
		}
		
		//绘制箭头
		private function countArrowPosition():void{
			var topPoint:Point=new Point(_linkTo.stageX, _linkTo.stageY);
			var ratio:Number=25/_straightLine.length;
			var bottomPoint:Point=Point.interpolate(new Point(_linkFrom.stageX,_linkFrom.stageY),topPoint,ratio);
			
			var topx:Number, leftx:Number, rightx:Number, bottomx:Number, topy:Number, bottomy:Number, lefty:Number, righty:Number, x0:Number, y0:Number;
			
			topx=topPoint.x;
			topy=topPoint.y;
			bottomx=bottomPoint.x;
			bottomy=bottomPoint.y;
			
			var l:Number = Math.sqrt(Math.pow((topx - bottomx) ,2) + Math.pow((topy - bottomy),2));
        	x0 = bottomx - 5 * (bottomx - topx) / l;
        	y0 = bottomy - 5 * (bottomy - topy) / l;
       	 	leftx = x0 + 5* (topy - bottomy) / l;
        	lefty = y0 + 5 * (bottomx - topx) / l;
        	rightx = x0 - 5 * (topy - bottomy) / l;
        	righty = y0 - 5 * (bottomx - topx) / l;
			
			_arrow.points=[topPoint,new Point(leftx,lefty),new Point(rightx,righty)];
		}
		
		public override function initLabelField():void{
			super.initLabelField();
          	labelField.height=18;
          	labelField.width=80;
          	labelField.x=_controlPoint.centerX-labelField.width/2;
          	labelField.y=_controlPoint.centerY-labelField.height;
          	labelName="connection name";			
		}
		
		public override function gotoSelectedView():void{			
			_straightLine.stroke=_selectedStraightLineStroke;
			_controlPoint.stroke=_selectedControlStroke;
			_arrow.fill=_selectedArrowFill;
			_arrow.stroke=_selectedStraightLineStroke;
			_straightLine.drawToTargets();
			_controlPoint.drawToTargets();
			_arrow.drawToTargets();
		}
		
		public override function gotoUnSelectedView():void{
			_straightLine.stroke=_straightLineStroke;
			_controlPoint.stroke=_controlStroke;
			_arrow.fill=_arrowFill;
			_arrow.stroke=_straightLineStroke;
			_straightLine.drawToTargets();
			_controlPoint.drawToTargets();
			_arrow.drawToTargets();
		}
		
		//被删除时做一些清理工作
		public override function destory():void{
			_toNode.removeArriveConnection(this);
			_fromNode.removeLeaveConnection(this);
		}

	}
}