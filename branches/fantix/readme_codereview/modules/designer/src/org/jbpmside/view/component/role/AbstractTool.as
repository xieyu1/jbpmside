package org.jbpmside.view.component.role
/**
 * @author liuch 2009-6-1
 */
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import mx.events.DragEvent;
	
	import org.jbpmside.model.TheModel;
	import org.jbpmside.view.component.SurfaceComponent;
	import org.jbpmside.view.component.gef.IGraphicalEditor;
	import org.jbpmside.view.component.gef.Tool;
	import org.jbpmside.view.component.gef.command.CommandService;

	public class AbstractTool implements Tool
	{

		public var theModel:TheModel=TheModel.getInstance();
		private var _type:int;
		
		public function AbstractTool()
		{
			//TODO: implement function
			super();
		}
		
		public function get type():int{
			return _type;
		}
		
		public function set type(_type:int):void{
			this._type = _type;
		}

		public function isActive():Boolean
		{
			//TODO: implement function
			return false;
		}

		public function activate():void
		{
			//TODO: implement function
		}

		public function deactivate():void
		{
			//TODO: implement function
		}

		public function mouseDown(e:MouseEvent, x:int, y:int):void
		{
			//TODO: implement function
		}
		
		public function mouseClick(e:MouseEvent, x:int, y:int):void{
			
		}

		public function mouseDrag(e:MouseEvent, x:int, y:int):void
		{
			//TODO: implement function
		}

		public function mouseUp(e:MouseEvent, x:int, y:int):void
		{
			//TODO: implement function
		}

		public function mouseMove(e:MouseEvent, x:int, y:int):void
		{
			//TODO: implement function
		}

		public function mouseOver(e:MouseEvent, x:int, y:int):void
		{
			//TODO: implement function
		}

		public function onDragDrop(event:DragEvent):void
		{

		}

		public function keyDown(evt:KeyboardEvent, key:int):void
		{
			//TODO: implement function
		}

		public function nodeMouseDown(e:Event):void
		{

		}

		public function isEnabled():Boolean
		{
			//TODO: implement function
			return false;
		}

		public function setEnabled(enableUsableCheck:Boolean):void
		{
			//TODO: implement function
		}

		public function isUsable():Boolean
		{
			//TODO: implement function
			return false;
		}

		public function setUsable(newIsUsable:Boolean):void
		{
			//TODO: implement function
		}
		
		public function get editor():IGraphicalEditor{
			return ProcessEditor.getEditor();
		}
		
		public function get graphicViewer():SurfaceComponent{
			return SurfaceComponent(this.editor.graphicViewer);
		}
		
		public function get commandService():CommandService{
			return graphicViewer.commandService;
		}

	}
}