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
	import org.jbpmside.model.CommonObject;

	public class GraphicEditPart extends GeometryGroup implements IEditPart
	{
		private var _model:Object;
		public var _labelName:String="";
		private var nodeToolsManager:ToolsManager=NodeToolsManager.getInstance();
		private var connectionToolsManager:ToolsManager=ConnectionToolsManager.getInstance();

		public function GraphicEditPart()
		{
			super();
			createFigure();
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
			if(_model!=null)
				setLabelName((_model as CommonObject).name);
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

		//被删除时做一些清理工作
		public function destory():void{
			this.model=null;
		}
		
		public function get labelName():String{
			return _labelName;
		}
		
		public function setLabelName(labelName:String):void{
			this._labelName=labelName;
		}

	}
}