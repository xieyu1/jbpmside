package org.jbpmside.view.component.command
/**
 * @author liuch 2009-6-1
 */
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


	public class CreateNodeCommand extends AutoUndoCommand
	{
		private var createNodeModel:NodeModel;
		private var createNodeComponent:NodeComponent;
		
		private static var uniqueNum:int = 0;

		public function CreateNodeCommand(type:int, x:int, y:int)
		{
			super();
			initNode(type,x,y);
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

		private function initNode(type:int, x:int, y:int):void
		{
			var selectedMode:int=type;
			if (selectedMode == TheModel.SELECTED_START_NODE)
			{
				createNodeModel=new StartNode();
				createNodeComponent=new StartComponent();
			}
			else if (selectedMode == TheModel.SELECTED_TASK_NODE)
			{
				createNodeModel=new TaskNode();
				createNodeComponent=new TaskComponent();
			}
			else if (selectedMode == TheModel.SELECTED_FORK_NODE)
			{
				createNodeModel=new ForkNode();
				createNodeComponent=new ForkComponent();
			}
			else if (selectedMode == TheModel.SELECTED_JOIN_NODE)
			{
				createNodeModel=new JoinNode();
				createNodeComponent=new JoinComponent();
			}
			else if (selectedMode == TheModel.SELECTED_END_NODE)
			{
				createNodeModel=new EndNode();
				createNodeComponent=new EndComponent();
			}
			
			createNodeModel.x = x;
			createNodeModel.y = y;
			createNodeModel.name = "new node"+ uniqueNum;
			
			createNodeComponent.model=createNodeModel;
			createNodeComponent.x=x;
			createNodeComponent.y=y;
			createNodeComponent.name=createNodeModel.name;
			uniqueNum ++;
		}

	}
}