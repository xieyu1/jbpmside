package org.jbpmside.view.component.role
{
	import flash.events.MouseEvent;
	
	import org.jbpmside.view.component.NodeComponent;
	
	public class NodeSelectionTool extends NodeMoveTool
	{
		public function NodeSelectionTool()
		{
			super();
		}
		
		override public function mouseClick(e:MouseEvent, x:int, y:int):void
		{
			var selectedNode:NodeComponent=e.currentTarget as NodeComponent
			selectedNode.selected();
		}

	}
}