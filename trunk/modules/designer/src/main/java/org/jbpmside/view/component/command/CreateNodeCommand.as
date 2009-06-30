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


	public class CreateNodeCommand extends AutoUndoCommand
	{
		private var createNode:NodeModel;
		
		private static var uniqueNum:int = 0;

		public function CreateNodeCommand(type:int, x:int, y:int)
		{
			super();
			createNode = getNodeModel(type,x,y);

		}

		override public function perform():Boolean
		{
			var processModel:ProcessModel = this.editor.graphicViewer.model as ProcessModel;
			processModel.addNode(createNode);

			return true;
		}

		private function getNodeModel(type:int, x:int, y:int):NodeModel
		{
			var selectedMode:int=type;
			var nodeModel:NodeModel;
			if (selectedMode == TheModel.SELECTED_START_NODE)
			{
				nodeModel=new StartNode();
			}
			else if (selectedMode == TheModel.SELECTED_TASK_NODE)
			{
				nodeModel=new TaskNode();
			}
			else if (selectedMode == TheModel.SELECTED_FORK_NODE)
			{
				nodeModel=new ForkNode();
			}
			else if (selectedMode == TheModel.SELECTED_JOIN_NODE)
			{
				nodeModel=new JoinNode();
			}
			else if (selectedMode == TheModel.SELECTED_END_NODE)
			{
				nodeModel=new EndNode();
			}
			
			nodeModel.x = x;
			nodeModel.y = y;
			nodeModel.name = "new node"+ uniqueNum;
			uniqueNum ++;
			
			return nodeModel;
		}

	}
}