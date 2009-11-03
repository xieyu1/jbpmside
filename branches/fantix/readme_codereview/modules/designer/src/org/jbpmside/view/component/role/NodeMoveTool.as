package org.jbpmside.view.component.role
/**
 * @author ronghao 2009-8-1
 * 处理节点移动的原生事件
 */
{
	import flash.events.MouseEvent;
	
	import org.jbpmside.view.component.NodeComponent;
	import org.jbpmside.view.component.command.MoveNodeCommand;
	import org.jbpmside.view.component.gef.command.Command;
	import org.jbpmside.view.component.gef.command.CommandService;
	
	public class NodeMoveTool extends AbstractTool
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
			var cmd:Command=new MoveNodeCommand(nodeComponent);
			commandService.execute(cmd);
		}
		
		private function nodeMoveHandler(event:MouseEvent):void{
			var nodeComponent:NodeComponent=event.currentTarget as NodeComponent;
			nodeComponent.updateConnectionPositions();
		}

	}
}