package org.jbpmside.view.component.command
/**
 * @author ronghao 2009-8-3
 * 移动节点
 */
{
	import org.jbpmside.model.NodeModel;
	import org.jbpmside.view.component.NodeComponent;
	
	public class MoveNodeCommand extends AutoUndoCommand
	{
		private var nodeModel:NodeModel;
		private var nodeComponent:NodeComponent;
		private var prior_x:Number;
		private var prior_y:Number;
		
		public function MoveNodeCommand(_nodeComponent:NodeComponent)
		{
			this.nodeComponent=_nodeComponent;
			this.nodeModel=_nodeComponent.model as NodeModel;
			this.prior_x=nodeModel.x;
			this.prior_y=nodeModel.y;
		}
		
		override public function canRedo():Boolean
		{
			return false;
		}
		
		override public function perform():Boolean
		{			
			//模型节点改变位置
			nodeModel.x=nodeComponent.x;
			nodeModel.y=nodeComponent.y;
			return true;
		}
		
		override public function undo():void{
			nodeModel.x=prior_x;
			nodeModel.y=prior_y;
			
			this.prior_x=nodeComponent.x;
			this.prior_y=nodeComponent.y;
			
			nodeComponent.x=nodeModel.x;
			nodeComponent.y=nodeModel.y;
			nodeComponent.updateConnectionPositions();			
		}
		
		override public function redo():void{
			nodeModel.x=prior_x;
			nodeModel.y=prior_y;
			
			this.prior_x=nodeComponent.x;
			this.prior_y=nodeComponent.y;
			
			nodeComponent.x=nodeModel.x;
			nodeComponent.y=nodeModel.y;
			nodeComponent.updateConnectionPositions();			
		}

	}
}