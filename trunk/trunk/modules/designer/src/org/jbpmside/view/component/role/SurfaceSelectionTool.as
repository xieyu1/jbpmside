package org.jbpmside.view.component.role
{
	import flash.events.MouseEvent;
	
	import org.jbpmside.view.component.SurfaceComponent;
	
	public class SurfaceSelectionTool extends CopyCutPasteDeleteTool
	{
		public function SurfaceSelectionTool()
		{
			super();
		}
		
		override public function mouseClick(e:MouseEvent, x:int, y:int):void
		{
			this.editor.graphicViewer.clearSelection();
		}

	}
}