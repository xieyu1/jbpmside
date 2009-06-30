package org.jbpmside.view.component.command
/**
 * @author liuch 2009-6-1
 */
{
	import org.jbpmside.model.ConnectionModel;
	import org.jbpmside.model.NodeModel;
	

	public class CreateConnectionCommand extends AutoUndoCommand
	{
		private var fromNode:NodeModel;
		private var toNode:NodeModel;

		public function CreateConnectionCommand(fromNode:NodeModel, toNode:NodeModel)
		{
			this.fromNode=fromNode;
			this.toNode=toNode;
		}

		override public function perform():Boolean
		{
			var transition1:ConnectionModel=new ConnectionModel();
			transition1.name="to new added";
			transition1.toNode=toNode.name;
			fromNode.addSourceTransition(transition1);
			toNode.addTargetTransition(transition1);
			ProcessEditor.getEditor().graphicViewer.toolDone();
			ProcessEditor.getEditor().graphicViewer.clearSelection();
			return true;
		}

	}
}