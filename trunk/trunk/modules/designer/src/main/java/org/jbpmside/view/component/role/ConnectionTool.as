package org.jbpmside.view.component.role
/**
 * @author liuch 2009-6-1
 */
{
	import flash.events.MouseEvent;
	
	import org.jbpmside.model.NodeModel;
	import org.jbpmside.view.component.NodeComponent;
	import org.jbpmside.view.component.ShapeComponent;
	import org.jbpmside.view.component.SurfaceComponent;
	import org.jbpmside.view.component.command.CreateConnectionCommand;
	import org.jbpmside.view.component.gef.command.Command;

	public class ConnectionTool extends AbstractTool
	{

		public function ConnectionTool()
		{
			//TODO: implement function
			super();
		}

		override public function mouseClick(event:MouseEvent, x:int, y:int):void
		{
			if (isConnectSelect(event))
			{
				var fromNode:NodeModel=(SurfaceComponent(this.editor.graphicViewer).selectedComponent as NodeComponent).model as NodeModel;
				var toNode:NodeModel=(event.currentTarget as NodeComponent).model as NodeModel;
				var cmd:Command=new CreateConnectionCommand(fromNode, toNode);
				cmd.perform();

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

		private function selected(e:MouseEvent):void
		{
			var selectedShape:ShapeComponent=e.currentTarget as ShapeComponent
			selectedShape.selected();
		}

	}
}