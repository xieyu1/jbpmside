package org.jbpmside.view.component
{
	import com.degrafa.GraphicText;
	
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.jbpmside.model.CommonObject;
	import org.jbpmside.model.TheModel;
	import org.jbpmside.util.IdGenerator;
	import org.jbpmside.view.component.gef.GraphicEditPart;
	
	public class ShapeComponent extends GraphicEditPart
	{
		public var theModel:TheModel = TheModel.getInstance();
		
		//####################################################
		//	组件关联
		//####################################################	
		private var _canvas:SurfaceComponent;
		
		//####################################################
		//	图形渲染部分
		//####################################################	
		public var labelField:GraphicText  = new GraphicText();
		
		//####################################################
		//	属性
		//####################################################
		public var isSelected:Boolean=false;
		
		public function ShapeComponent()
		{
			super();
			this.id=IdGenerator.generateComponentId();
			addEventListeners();
		}
		
		/**
		 * 创建图形
		 */
		override public function createFigure():void{
			init();
			initLabelField();
			this.addChild(labelField);
		}
		
		/**
		 * 注册原生事件处理器
		 */
		public function addEventListeners():void{
            addEventListener(MouseEvent.CLICK, mouseClickHandler);
            addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
		}
		
		/**
		 * 子类创建图形
		 */
		public function init():void{}
		
		public function mouseClickHandler(event:MouseEvent):void{
			event.stopPropagation();
			selected();
		}
		
		public function mouseOverHandler(event:MouseEvent):void{
			event.stopPropagation();
			if(!isSelected){
				gotoSelectedView();
			}	

		}
		
		public function mouseOutHandler(event:MouseEvent):void{
			event.stopPropagation();
			if(!isSelected){
				gotoUnSelectedView();
			}	
		}
		
		public function mouseDbClickHandler(event:MouseEvent):void{
			event.stopPropagation();
			selected();
		}
		
		public function selected():void{
			_canvas.selectedComponent=this;
			isSelected=true;
			gotoSelectedView();
		}
		
		public function unSelected():void{
			isSelected=false;
			gotoUnSelectedView();
		}
		
		//初始化label
		public function initLabelField():void{	
			var textFormat:TextFormat=new TextFormat();
			textFormat.align=TextFormatAlign.CENTER;
			labelField.textFormat=textFormat;
			labelField.autoSize=TextFieldAutoSize.CENTER;	
		}
		
		//选中状态
		public function gotoSelectedView():void{			
		}
		
		//非选中状态
		public function gotoUnSelectedView():void{
		}
				
		//####################################################
		//	getter/setter
		//####################################################	
		
		public function get canvas():SurfaceComponent{
			return _canvas;
		}
		
		public function set canvas(canvas:SurfaceComponent):void{
			this._canvas=canvas;
		}
		
		public override function setLabelName(labelName:String):void{
			super.setLabelName(labelName);
			labelField.text=labelName;
		}

	}
}