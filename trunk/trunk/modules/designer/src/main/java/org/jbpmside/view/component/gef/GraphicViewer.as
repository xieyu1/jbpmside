package org.jbpmside.view.component.gef
/**
 * @author liuch 2009-6-1
 */
{
	import com.degrafa.Surface;

	import mx.collections.ArrayCollection;

	import org.jbpmside.view.component.role.SelectionTool;

	public class GraphicViewer extends Surface implements IEditPart
	{
		protected var _model:Object;

		private var currentTool:Tool;
		private var defaultTool:Tool=new SelectionTool();

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
			if(!currentTool){
				currentTool = defaultTool;
			}
			return currentTool;
		}

		public function set tool(currentTool:Tool):void
		{
			this.currentTool=currentTool;
		}

		public function toolDone():void
		{
			this.tool=defaultTool;
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