package org.jbpmside.dao
/**
 * @author ronghao 
 */
{
	import org.jbpmside.event.CustomEvent;
	import org.jbpmside.model.TheModel;
	
	public class ToolBarDAO
	{
		private var model:TheModel = TheModel.getInstance();
		
		public function ToolBarDAO()
		{
		}
		
		public function changeSelectedMode(mode:int):void{
			model.selectedMode=mode;
			model.dispatchEvent(new CustomEvent(TheModel.SELECTED_MODE_CHANGED));
		}
		
		public function showGrid(enabled:Boolean):void{
			model.showGrid=enabled;
			model.dispatchEvent(new CustomEvent(TheModel.CHANGE_SHOW_GRID_EVENT));
		}

		public function changeZoomRatio(ratio:Number):void{
			model.zoomRatio=ratio;
			model.dispatchEvent(new CustomEvent(TheModel.CHANGE_ZOOM_EVENT));
		}
	}
}