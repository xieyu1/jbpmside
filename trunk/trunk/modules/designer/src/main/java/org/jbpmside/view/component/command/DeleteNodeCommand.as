package org.jbpmside.view.component.command
/**
 * @author ronghao 2009-8-4
 */
{
	import mx.collections.ArrayCollection;
	
	import org.jbpmside.model.ConnectionModel;
	import org.jbpmside.model.NodeModel;
	import org.jbpmside.model.ProcessModel;
	import org.jbpmside.view.component.ConnectionComponent;
	import org.jbpmside.view.component.NodeComponent;
	import org.jbpmside.view.component.SurfaceComponent;
	
	public class DeleteNodeCommand extends AutoUndoCommand
	{
		private var nodeComponent:NodeComponent;
		public var nodeModel:NodeModel;
		
		private var arriveConnectionComponents:ArrayCollection=new ArrayCollection();
		private var fromNodesOfArriveConnectionComponents:ArrayCollection=new ArrayCollection();
		private var leaveConnectionComponents:ArrayCollection=new ArrayCollection();
		private var toNodesOfLeaveConnectionComponents:ArrayCollection=new ArrayCollection();
		
		private var arriveConnectionModels:ArrayCollection=new ArrayCollection();
		private var fromNodesOfArriveConnectionModels:ArrayCollection=new ArrayCollection();
		private var leaveConnectionModels:ArrayCollection=new ArrayCollection();
		private var toNodesOfLeaveConnectionModels:ArrayCollection=new ArrayCollection();
		
		public function DeleteNodeCommand(nodeComponent:NodeComponent)
		{
			this.nodeComponent=nodeComponent;
			this.nodeModel=this.nodeComponent.model as NodeModel;
			
			var acs:ArrayCollection=this.nodeComponent.arriveConnections;
			for(var i:int=0;i<acs.length;i++){
				var connection:ConnectionComponent=acs[i] as ConnectionComponent;
				fromNodesOfArriveConnectionComponents.addItem(connection.fromNode);
				this.arriveConnectionComponents.addItem(connection);
			}
			
			var lcs:ArrayCollection=this.nodeComponent.leaveConnections;
			for(var i:int=0;i<lcs.length;i++){
				var connection:ConnectionComponent=lcs[i] as ConnectionComponent;
				toNodesOfLeaveConnectionComponents.addItem(connection.toNode);
				this.leaveConnectionComponents.addItem(connection);
			}
			
			var acm:ArrayCollection=this.nodeModel.targetTransitions;
			for(var i:int=0;i<acm.length;i++){
				var connectionModel:ConnectionModel=acm[i] as ConnectionModel;
				fromNodesOfArriveConnectionModels.addItem(connectionModel.fromNode);
				this.arriveConnectionModels.addItem(connectionModel);
			}
			
			var lcm:ArrayCollection=this.nodeModel.sourceTransitions;
			for(var i:int=0;i<lcm.length;i++){
				var connectionModel:ConnectionModel=lcm[i] as ConnectionModel;
				toNodesOfLeaveConnectionModels.addItem(connectionModel.toNode);
				this.leaveConnectionModels.addItem(connectionModel);
			}			
		}
		
		override public function canUndo():Boolean
		{
			return true;
		}
		
		override public function perform():Boolean
		{
			//画板删除节点组件
			var surfaceComponent:SurfaceComponent = this.editor.graphicViewer as SurfaceComponent;
			surfaceComponent.removeNodeComponent(nodeComponent);
			
			//模型删除节点
			var processModel:ProcessModel = surfaceComponent.model as ProcessModel;
			processModel.removeNode(nodeModel);
			
			surfaceComponent.clearSelection();
			return true;
		}
		
		override public function undo():void
		{
			//画板增加节点组件
			var surfaceComponent:SurfaceComponent = this.editor.graphicViewer as SurfaceComponent;
			nodeComponent.model=nodeModel;
			surfaceComponent.addNodeComponent(nodeComponent);
			for(var i:int=0;i<arriveConnectionComponents.length;i++){
				var connection:ConnectionComponent=arriveConnectionComponents[i] as ConnectionComponent;
				surfaceComponent.addConnectionComponent(connection);
				var fromNodeComponent:NodeComponent=fromNodesOfArriveConnectionComponents[i] as NodeComponent;
				fromNodeComponent.addLeaveConnection(connection);
				this.nodeComponent.addArriveConnection(connection);
				connection.model=arriveConnectionModels[i] as ConnectionModel;
				connection.refreshPosition();
			}
			for(var i:int=0;i<leaveConnectionComponents.length;i++){
				var connection:ConnectionComponent=leaveConnectionComponents[i] as ConnectionComponent;
				surfaceComponent.addConnectionComponent(connection);
				var toNodeComponent:NodeComponent=toNodesOfLeaveConnectionComponents[i] as NodeComponent;
				toNodeComponent.addArriveConnection(connection);
				this.nodeComponent.addLeaveConnection(connection);
				connection.model=leaveConnectionModels[i] as ConnectionModel;
				connection.refreshPosition();
			}
			
			//模型增加节点
			var processModel:ProcessModel = surfaceComponent.model as ProcessModel;
			processModel.addNode(nodeModel);
			for(var i:int=0;i<arriveConnectionModels.length;i++){
				var connectionModel:ConnectionModel=arriveConnectionModels[i] as ConnectionModel;
				var fromNodeModel:NodeModel=fromNodesOfArriveConnectionModels[i] as NodeModel;
				fromNodeModel.addSourceTransition(connectionModel);
				this.nodeModel.addTargetTransition(connectionModel);
			}
			for(var i:int=0;i<leaveConnectionModels.length;i++){
				var connectionModel:ConnectionModel=leaveConnectionModels[i] as ConnectionModel;
				var toNodeModel:NodeModel=toNodesOfLeaveConnectionModels[i] as NodeModel;
				toNodeModel.addTargetTransition(connectionModel);
				this.nodeModel.addSourceTransition(connectionModel);
			}
		}

	}
}