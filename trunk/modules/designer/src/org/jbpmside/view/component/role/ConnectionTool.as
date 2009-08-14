package org.jbpmside.view.component.role
/**
 * @author liuch 2009-6-1
 */
{
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.jbpmside.view.component.ConnectionComponent;
	import org.jbpmside.view.component.NodeComponent;
	import org.jbpmside.view.component.ShapeComponent;
	import org.jbpmside.view.component.SurfaceComponent;
	import org.jbpmside.view.component.command.CreateConnectionCommand;
	import org.jbpmside.view.component.gef.command.Command;
	import org.jbpmside.view.component.gef.command.CommandService;

	public class ConnectionTool extends NodeMoveTool
	{

		public function ConnectionTool()
		{
			super();
		}

		override public function mouseClick(event:MouseEvent, x:int, y:int):void
		{
			
			if (isConnectSelect(event))
			{
				var fromNodeComponent:NodeComponent=SurfaceComponent(this.editor.graphicViewer).selectedComponent as NodeComponent;
				var toNodeComponent:NodeComponent=event.currentTarget as NodeComponent;
				if(!hasConnectionBetweenNodes(fromNodeComponent,toNodeComponent)&&
						!hasConnectionBetweenNodes(toNodeComponent,fromNodeComponent)){
					var cmd:Command=new CreateConnectionCommand(fromNodeComponent, toNodeComponent);
					CommandService.getInstance().execute(cmd);
				}else{
					selected(event);
				}
			}
			else
			{
				selected(event);
			}

		}

		private function isConnectSelect(event:MouseEvent):Boolean
		{
			var selectedComponent:ShapeComponent=SurfaceComponent(this.editor.graphicViewer).selectedComponent;
			var toNode:NodeComponent=event.currentTarget as NodeComponent;
			if (selectedComponent != null && (selectedComponent is NodeComponent) && !toNode.isSelected)
			{
				return true;
			}
			return false;
		}
		
		//判断两个节点组件之间是否已有连接线
		private function hasConnectionBetweenNodes(fromNodeComponent:NodeComponent,toNodeComponent:NodeComponent):Boolean{
			var leaveConnections:ArrayCollection=fromNodeComponent.leaveConnections;
			var arriveConnections:ArrayCollection=toNodeComponent.arriveConnections;
			for(var i:int=0;i<leaveConnections.length;i++){
				var connection:ConnectionComponent=leaveConnections[i] as ConnectionComponent;
				if(arriveConnections.contains(connection)){
					return true;
				}
			}
			return false;
		}

		private function selected(e:MouseEvent):void
		{
			var selectedShape:ShapeComponent=e.currentTarget as ShapeComponent
			selectedShape.selected();
		}

	}
}