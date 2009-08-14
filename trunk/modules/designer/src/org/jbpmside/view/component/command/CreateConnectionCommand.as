package org.jbpmside.view.component.command
/**
 * @author liuch 2009-6-1
 */
{
	import org.jbpmside.model.ConnectionModel;
	import org.jbpmside.model.NodeModel;
	import org.jbpmside.view.component.ConnectionComponent;
	import org.jbpmside.view.component.NodeComponent;
	import org.jbpmside.view.component.SurfaceComponent;
	

	public class CreateConnectionCommand extends AutoUndoCommand
	{
		private var fromNode:NodeModel;
		private var toNode:NodeModel;
		private var fromNodeComponent:NodeComponent;
		private var toNodeComponent:NodeComponent;
		private var connectionModel:ConnectionModel;
		private var connectionComponent:ConnectionComponent;

		public function CreateConnectionCommand(fromNodeComponent:NodeComponent, toNodeComponent:NodeComponent)
		{
			this.fromNodeComponent=fromNodeComponent;
			this.toNodeComponent=toNodeComponent;
			this.fromNode=fromNodeComponent.model as NodeModel;
			this.toNode=toNodeComponent.model as NodeModel;
		}
		
		override public function canUndo():Boolean
		{
			return true;
		}

		override public function perform():Boolean
		{			
			connectionComponent=new ConnectionComponent();
			fromNodeComponent.addLeaveConnection(connectionComponent);
			toNodeComponent.addArriveConnection(connectionComponent);
			var surfaceComponent:SurfaceComponent = this.editor.graphicViewer as SurfaceComponent;
			surfaceComponent.addConnectionComponent(connectionComponent);
			surfaceComponent.clearSelection();
			
			connectionModel=new ConnectionModel();
			connectionModel.name=fromNode.name+" to "+toNode.name;
			fromNode.addSourceTransition(connectionModel);
			toNode.addTargetTransition(connectionModel);
			
			connectionComponent.name=connectionModel.name;
			connectionComponent.model=connectionModel;
			connectionComponent.refreshPosition();
			return true;
		}
		
		override public function undo():void{
			var surfaceComponent:SurfaceComponent = this.editor.graphicViewer as SurfaceComponent;
			surfaceComponent.removeConnectionComponent(connectionComponent);
			connectionModel.destory();
		}

	}
}