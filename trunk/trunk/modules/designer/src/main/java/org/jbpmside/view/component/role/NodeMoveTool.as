package org.jbpmside.view.component.role
/**
 * @author ronghao 2009-8-1
 * 处理节点移动的原生事件
 */
{
	import flash.events.MouseEvent;
	
	import org.jbpmside.view.component.NodeComponent;
	
	public class NodeMoveTool extends SelectionTool
	{
		public function NodeMoveTool()
		{
			super();
		}
		
		public override function mouseDown(event:MouseEvent, x:int, y:int):void{
			var nodeComponent:NodeComponent=event.currentTarget as NodeComponent;
			nodeComponent.startDrag();
			nodeComponent.addEventListener(MouseEvent.MOUSE_MOVE, nodeMoveHandler);
		}
		
		public override function mouseUp(event:MouseEvent, x:int, y:int):void{
			var nodeComponent:NodeComponent=event.currentTarget as NodeComponent;
			nodeComponent.stopDrag();
			nodeComponent.removeEventListener(MouseEvent.MOUSE_MOVE, nodeMoveHandler);
		}
		
		private function nodeMoveHandler(event:MouseEvent):void{
			var nodeComponent:NodeComponent=event.currentTarget as NodeComponent;
			nodeComponent.updateConnectionPositions();
		}

	}
}