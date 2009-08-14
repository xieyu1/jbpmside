package org.jbpmside.view.component.gef
/**
 * @author liuch 2009-6-1
 */
{
	import com.degrafa.Surface;
	
	import mx.collections.ArrayCollection;
	
	import org.jbpmside.view.component.role.SelectionTool;
	import org.jbpmside.view.component.role.manager.SurfaceToolsManager;

	public class GraphicViewer extends Surface implements IEditPart
	{
		protected var _model:Object;
		
		private var toolsManager:ToolsManager=SurfaceToolsManager.getInstance();

		public function GraphicViewer()
		{
			super();
		}

		public function createControl():void
		{

		}

		public function get model():Object
		{
			return _model;
		}

		public function set model(_model:Object):void
		{
			this._model=_model;
		}

		public function get tool():Tool
		{
			return toolsManager.getCurrentTool();
		}

		public function getModelChildren():ArrayCollection
		{
			return null;
		}

		protected function refreshChildren():void
		{

		}

		public function getModelSourceConnections():ArrayCollection
		{
			return null;
		}

		public function getModelTargetConnections():ArrayCollection
		{
			return null;
		}
		
		public function clearSelection():void{
			
		}

	}
}