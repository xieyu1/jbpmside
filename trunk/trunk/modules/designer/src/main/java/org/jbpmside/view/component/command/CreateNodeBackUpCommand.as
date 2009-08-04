package org.jbpmside.view.component.command
{
	import org.jbpmside.model.EndNode;
	import org.jbpmside.model.ForkNode;
	import org.jbpmside.model.JoinNode;
	import org.jbpmside.model.NodeModel;
	import org.jbpmside.model.ProcessModel;
	import org.jbpmside.model.StartNode;
	import org.jbpmside.model.TaskNode;
	import org.jbpmside.model.TheModel;
	import org.jbpmside.view.component.NodeComponent;
	import org.jbpmside.view.component.SurfaceComponent;
	import org.jbpmside.view.component.node.EndComponent;
	import org.jbpmside.view.component.node.ForkComponent;
	import org.jbpmside.view.component.node.JoinComponent;
	import org.jbpmside.view.component.node.StartComponent;
	import org.jbpmside.view.component.node.TaskComponent;
	
	public class CreateNodeBackUpCommand extends AutoUndoCommand
	{
		public var createNodeModel:NodeModel;
		public var createNodeComponent:NodeComponent;
		
		public static var uniqueNum:int = 0;
		
		public function CreateNodeBackUpCommand()
		{
			super();
		}
				
		override public function canUndo():Boolean
		{
			return true;
		}

		override public function perform():Boolean
		{
			//画板增加节点组件
			var surfaceComponent:SurfaceComponent = this.editor.graphicViewer as SurfaceComponent;
			surfaceComponent.addNodeComponent(createNodeComponent);
			createNodeComponent.selected();
			
			//模型增加节点
			var processModel:ProcessModel = surfaceComponent.model as ProcessModel;
			processModel.addNode(createNodeModel);
			return true;
		}
		
		override public function undo():void
		{
			//画板删除节点组件
			var surfaceComponent:SurfaceComponent = this.editor.graphicViewer as SurfaceComponent;
			surfaceComponent.removeNodeComponent(createNodeComponent);
			
			//模型删除节点
			var processModel:ProcessModel = surfaceComponent.model as ProcessModel;
			processModel.removeNode(createNodeModel);
		}

	}
}