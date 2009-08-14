package org.jbpmside.view.component.command
/**
 * @author ronghao 2009-8-4
 */
{
	import org.jbpmside.model.ConnectionModel;
	import org.jbpmside.model.NodeModel;
	import org.jbpmside.view.component.ConnectionComponent;
	import org.jbpmside.view.component.NodeComponent;
	import org.jbpmside.view.component.SurfaceComponent;
	
	public class DeleteConnectionCommand extends AutoUndoCommand
	{
		private var fromNode:NodeModel;
		private var toNode:NodeModel;
		private var fromNodeComponent:NodeComponent;
		private var toNodeComponent:NodeComponent;
		private var connectionModel:ConnectionModel;
		private var connectionComponent:ConnectionComponent;
		
		public function DeleteConnectionCommand(connectionComponent:ConnectionComponent)
		{
			this.connectionComponent=connectionComponent;
			this.fromNodeComponent=connectionComponent.fromNode;
			this.toNodeComponent=connectionComponent.toNode;
			this.connectionModel=this.connectionComponent.model as ConnectionModel;
			this.fromNode=this.fromNodeComponent.model as NodeModel;
			this.toNode=this.toNodeComponent.model as NodeModel;
		}
		
		override public function canUndo():Boolean
		{
			return true;
		}
		
		override public function undo():void
		{			
			fromNodeComponent.addLeaveConnection(connectionComponent);
			toNodeComponent.addArriveConnection(connectionComponent);
			var surfaceComponent:SurfaceComponent = this.editor.graphicViewer as SurfaceComponent;
			surfaceComponent.addConnectionComponent(connectionComponent);
			surfaceComponent.clearSelection();
			
			fromNode.addSourceTransition(connectionModel);
			toNode.addTargetTransition(connectionModel);
			
			connectionComponent.model=connectionModel;
			connectionComponent.refreshPosition();			
		}
		
		override public function perform():Boolean{
			var surfaceComponent:SurfaceComponent = this.editor.graphicViewer as SurfaceComponent;
			surfaceComponent.removeConnectionComponent(connectionComponent);
			connectionModel.destory();
			return true;
		}

	}
}