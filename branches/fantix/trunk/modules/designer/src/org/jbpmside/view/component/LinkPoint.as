package org.jbpmside.view.component
{
	import com.degrafa.GraphicImage;
	import com.degrafa.geometry.Circle;
	import com.degrafa.paint.SolidFill;
	import com.degrafa.paint.SolidStroke;
	
	public class LinkPoint extends Circle
	{
		
		//####################################################
		//	连接点位置
		//####################################################	
		public static const POSITION_TOP:String="top";
		public static const POSITION_LEFT:String="left";
		public static const POSITION_RIGHT:String="right";
		public static const POSITION_BOTTOM:String="bottom";
		
		//####################################################
		//	组件关联
		//####################################################	
		private var _nodeComponent:NodeComponent;
		
		//####################################################
		//	图形渲染部分
		//####################################################	
		private var _defaultFill:SolidFill;
		private var _defaultStroke:SolidStroke;
		public var directio:String;
		
		//####################################################
		//	相对于画板的位置
		//####################################################	
		private var _stageX:Number;
		private var _stageY:Number;
		
		public function LinkPoint(nodeComponent:NodeComponent,directio:String)
		{
			_defaultFill = new SolidFill();
            _defaultFill.color = 0xFFFFFF;
            _defaultFill.alpha = 0.8;
            
            _defaultStroke = new SolidStroke();
            _defaultStroke.color = 0xFFFFFF;
            _defaultStroke.alpha = 0.4;
            _defaultStroke.weight = 2;
            
           
            this.radius = 3;
            this.fill = _defaultFill;
            this.stroke = _defaultStroke;
            
            _nodeComponent = nodeComponent;
            this.directio=directio;
            
            confirmPosition();
		}
		
		private function confirmPosition():void{
			var nodeIcon:GraphicImage=this.nodeComponent.nodeIcon;
			var x:Number=nodeIcon.x;
			var y:Number=nodeIcon.y;
			var nwidth:Number=nodeIcon.width;
			var nheight:Number=nodeIcon.height;
			if(this.directio==POSITION_TOP){
				this.centerX = x+nwidth/2;
            	this.centerY = y;
			}else if(this.directio==POSITION_LEFT){
				this.centerX = x;
            	this.centerY = y+nheight/2;
			}else if(this.directio==POSITION_RIGHT){
				this.centerX = x+nwidth;
            	this.centerY = y+nheight/2;
			}else if(this.directio==POSITION_BOTTOM){
				this.centerX = x+nwidth/2;
            	this.centerY = y+nheight;
				
			}
		}
		
		//####################################################
		//	getter/setter
		//####################################################	
		
		public function get nodeComponent():NodeComponent{
			return _nodeComponent;
		}
		
		public function get stageX():Number{
			 _stageX = this.centerX + _nodeComponent.x;
			return _stageX;
		}
				
		public function get stageY():Number{
			_stageY = this.centerY + _nodeComponent.y;
			return _stageY;
		}

	}
}