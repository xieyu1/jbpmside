package org.jbpmside.view.component.gef
/**
 * @author liuch 2009-6-1
 * ronghao modified
 */
{
	import com.degrafa.GeometryGroup;
	
	import mx.collections.ArrayCollection;
	
	import org.jbpmside.model.NodeModel;
	import org.jbpmside.view.component.role.manager.NodeToolsManager;
	import org.jbpmside.view.component.role.manager.ConnectionToolsManager;

	public class GraphicEditPart extends GeometryGroup implements IEditPart
	{
		private var _model:Object;
		
		private var nodeToolsManager:ToolsManager;
		private var connectionToolsManager:ToolsManager;

		public function GraphicEditPart()
		{
			super();
			//初始化原生事件处理管理器
			initToolsManager();
			createFigure();
		}
		
		public function initToolsManager():void{
			nodeToolsManager=NodeToolsManager.getInstance();
			nodeToolsManager.registerTool(ToolsManager.CREATE_CONNECTION);
			nodeToolsManager.registerTool(ToolsManager.MOVE_NODE);

			connectionToolsManager=ConnectionToolsManager.getInstance();				
			connectionToolsManager.registerTool(ToolsManager.SELECT_COMPONENT);
		}
		
		public function get tool():Tool
		{
			if(isNodeComponent()){
				return nodeToolsManager.getCurrentTool();
			}else{
				return connectionToolsManager.getCurrentTool();
			}			
		}
		
		//区分节点组件和连接线组件
		public function isNodeComponent():Boolean{
			return false;
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