package org.jbpmside.view.component
{
	import com.degrafa.GraphicImage;
	import com.degrafa.geometry.RoundedRectangle;
	import com.degrafa.paint.GradientFillBase;
	import com.degrafa.paint.GradientStop;
	import com.degrafa.paint.SolidStroke;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.jbpmside.model.TheModel;
	import org.jbpmside.event.CustomEvent;
	
	import mx.collections.ArrayCollection;
	import mx.styles.StyleManager;
	
	public class NodeComponent extends ShapeComponent
	{
				
		//####################################################
		//	图形渲染部分
		//####################################################	
		private var _nodeIcon:GraphicImage; 
		private var _defaultRectangle:RoundedRectangle;
		private var _defaultStroke:SolidStroke;
		private var _defaultFill:GradientFillBase;
		private var _selectedFill:GradientFillBase;
		private var _labelField:TextField;
		
		//####################################################
		//	四个连接点
		//####################################################	
		private var _topPoint:LinkPoint;
		private var _leftPoint:LinkPoint;
		private var _rightPoint:LinkPoint;
		private var _bottomPoint:LinkPoint;
		
		private var _arriveConnections:ArrayCollection = new ArrayCollection();
        private var _leaveConnections:ArrayCollection = new ArrayCollection();
		
		
		public function NodeComponent()
		{
			super();
		}
		
		public override function isNodeComponent():Boolean{
			return true;
		}
		
		public override function addEventListeners():void{
			super.addEventListeners();
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		public override function init():void{
			//stroke for default rectangle
            _defaultStroke = new SolidStroke();
            _defaultStroke.color = 0x000000;
            _defaultStroke.alpha = 0.2;
            _defaultStroke.weight = 3;
           
			//fill for default rectangle
            _defaultFill = new GradientFillBase();
            _defaultFill.angle = 90;
            var gradStop1:GradientStop = new GradientStop(StyleManager.getColorName("#FFFFFF"), 1,0.3);
            var gradStop2:GradientStop = new GradientStop(StyleManager.getColorName("#FFFFFF"), 1);
            _defaultFill.gradientStopsCollection.addItem(gradStop1);
            _defaultFill.gradientStopsCollection.addItem(gradStop2);
            
            //when is selected this fill is used
            _selectedFill = new GradientFillBase();
            _selectedFill.angle = 90;
            var selectedGradStop1:GradientStop = new GradientStop(StyleManager.getColorName("#88b5f2"), 1,0.3);
            var selectedGradStop2:GradientStop = new GradientStop(StyleManager.getColorName("#4b78b5"), 1);
            _selectedFill.gradientStopsCollection.addItem(selectedGradStop1);
            _selectedFill.gradientStopsCollection.addItem(selectedGradStop2);
            
			_defaultRectangle = new RoundedRectangle(-1,-2,28,28);
			_defaultRectangle.stroke = _defaultStroke;
          	_defaultRectangle.fill = _defaultFill;
          	_defaultRectangle.cornerRadius = 3;
			
			_nodeIcon = new GraphicImage();
			_nodeIcon.width=25;
			_nodeIcon.height=25;
			_nodeIcon.source=getNodeIconUrl();
			
			_defaultRectangle.graphicsTarget=[_nodeIcon];
			_nodeIcon.target=this;
			_nodeIcon.x=-_nodeIcon.width/2;
			_nodeIcon.y=-_nodeIcon.height*2;
			
			this.geometryCollection.addItem(_nodeIcon);
			
			_topPoint = new LinkPoint(this,LinkPoint.POSITION_TOP);
			_leftPoint = new LinkPoint(this,LinkPoint.POSITION_LEFT);
			_rightPoint = new LinkPoint(this,LinkPoint.POSITION_RIGHT);
			_bottomPoint = new LinkPoint(this,LinkPoint.POSITION_BOTTOM);
			
          	geometryCollection.addItem(_topPoint);
          	geometryCollection.addItem(_leftPoint);
          	geometryCollection.addItem(_rightPoint);
          	geometryCollection.addItem(_bottomPoint);

			this.draw(null,null);
		}
		
		private function mouseDownHandler(event:MouseEvent):void{
			event.stopPropagation();
			this.tool.mouseDown(event,0,0);
		}
		
		private function mouseUpHandler(event:MouseEvent):void{
			event.stopPropagation();
			this.tool.mouseUp(event,0,0);
		}
		
		public function updateDragPosition(event:MouseEvent):void{
			if(theModel.alignToGrid){
				var test:Number = ((event.stageY/this.scaleY)-(this.y/this.scaleY)) - int(((event.stageY/this.scaleY)-(this.y/this.scaleY))/20)*20;
        		if(test < 0){
        			test = -test;
        			if(test >= 0 && test < 10){
	        			this.y = ((event.stageY/this.scaleY)-(this.y/this.scaleY))+test;
	        		}else if(test >= 10 && test <= 20){
	        			this.y =((event.stageY/this.scaleY)-(this.y/this.scaleY))-(20-test);
	        		}
        		}else{
        			if(test >= 0 && test < 10){
	        			this.y = ((event.stageY/this.scaleY)-(this.y/this.scaleY))-test;
	        		}else if(test >= 10 && test <= 20){
	        			this.y =((event.stageY/this.scaleY)-(this.y/this.scaleY))+(20-test);
	        		}
        		}
			}
		}
		
		public override function mouseClickHandler(event:MouseEvent):void{
			event.stopPropagation();
			this.tool.mouseClick(event,0,0);
		}
		
		public  function getNodeIconUrl():String{
			return "org/jbpmside/view/assets/arrow.png";
		}
		
		
		public override function gotoSelectedView():void{			
			_defaultRectangle.fill=_selectedFill;
			_defaultRectangle.drawToTargets();
		}
		
		public override function gotoUnSelectedView():void{
			_defaultRectangle.fill=_defaultFill;
			_defaultRectangle.drawToTargets();
		}
		
		public override function initLabelField():void{
			super.initLabelField();
          	labelField.x=_defaultRectangle.width/2-40;
          	labelField.y=-_defaultRectangle.height+5;
          	labelField.height=18;
          	labelField.width=60;
          	labelName="node name";			
		}
		
		public function updateConnectionPositions():void{
			for(var i:int=0;i<_arriveConnections.length;i++){
				var connection:ConnectionComponent=_arriveConnections[i] as ConnectionComponent;
				connection.refreshPosition();
			}
			for(var j:int=0;j<_leaveConnections.length;j++){
				var connection1:ConnectionComponent=_leaveConnections[j] as ConnectionComponent;
				connection1.refreshPosition();
			}
		}
		
		//被删除时做一些清理工作
		public override function destory():void{
			for(var i:int=0;i<_arriveConnections.length;i++){
				var connection:ConnectionComponent=_arriveConnections[i] as ConnectionComponent;
				this.canvas.removeConnectionComponent(connection);
			}
			for(var j:int=0;j<_leaveConnections.length;j++){
				var connection1:ConnectionComponent=_leaveConnections[j] as ConnectionComponent;
				this.canvas.removeConnectionComponent(connection1);
			}
		}
		
		//####################################################
		//	getter/setter
		//####################################################	  
		
		public function get nodeIcon():GraphicImage{
			return _nodeIcon;
		}
		
		public function get topLinkPoint():LinkPoint{
			return _topPoint;
		}
		
		public function get rightLinkPoint():LinkPoint{
			return _rightPoint;
		}
		
		public function get leftLinkPoint():LinkPoint{
			return _leftPoint;
		}
		
		public function get bottomLinkPoint():LinkPoint{
			return _bottomPoint;
		}
		
		public function get arriveConnections():ArrayCollection{
			return _arriveConnections;
		}
		
		public function get leaveConnections():ArrayCollection{
			return _leaveConnections;
		}
		
		public function addArriveConnection(connection:ConnectionComponent):void{
			this._arriveConnections.addItem(connection);
			connection.toNode=this;
		}
		
		public function addLeaveConnection(connection:ConnectionComponent):void{
			this._leaveConnections.addItem(connection);
			connection.fromNode=this;
		}
		
		public function removeArriveConnection(connection:ConnectionComponent):void{
			this._arriveConnections.removeItemAt(this._arriveConnections.getItemIndex(connection));
		}
		
		public function removeLeaveConnection(connection:ConnectionComponent):void{
			this._leaveConnections.removeItemAt(this._leaveConnections.getItemIndex(connection));
		}

		
	}
}