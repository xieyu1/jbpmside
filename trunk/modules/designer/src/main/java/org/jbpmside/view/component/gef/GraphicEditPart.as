package org.jbpmside.view.component.gef
/**
 * @author liuch 2009-6-1
 */
{
	import com.degrafa.GeometryGroup;
	
	import mx.collections.ArrayCollection;
	
	import org.jbpmside.model.NodeModel;
	import org.jbpmside.view.component.role.SelectionTool;

	public class GraphicEditPart extends GeometryGroup implements IEditPart
	{
		private var _model:Object;
		
		private var currentTool:Tool;
		private var defaultTool:Tool=new SelectionTool();

		public function GraphicEditPart()
		{
			super();
			createFigure();
		}

		public function createFigure():void
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

		public function getModelChildren():ArrayCollection
		{
			return null;
		}

		public function getModelSourceConnections():ArrayCollection
		{
			var nodeModel:NodeModel=this.model as NodeModel;
			return nodeModel.sourceTransitions;
		}

		public function getModelTargetConnections():ArrayCollection
		{
			var nodeModel:NodeModel=this.model as NodeModel;
			return nodeModel.targetTransitions;
		}



	}
}