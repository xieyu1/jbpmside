package org.jbpmside.view.component.role
/**
 * @author liuch 2009-6-1
 */
{
	import flash.events.MouseEvent;
	
	import org.jbpmside.view.component.ShapeComponent;
	import org.jbpmside.view.component.SurfaceComponent;


	public class SelectionTool extends AbstractTool
	{

		public function SelectionTool()
		{
			super();
		}

		override public function mouseClick(e:MouseEvent, x:int, y:int):void
		{
			if(e.currentTarget is ShapeComponent){
				selected(e);
			}
			else{
				this.editor.graphicViewer.clearSelection();
			}

		}

		private function selected(e:MouseEvent):void
		{
			var selectedShape:ShapeComponent=e.currentTarget as ShapeComponent
			selectedShape.selected();
		}

	}
}