package org.jbpmside.view.component.command
{
	import org.jbpmside.view.component.NodeComponent;
	
	public class CutNodeCommand extends DeleteNodeCommand
	{
		public function CutNodeCommand(nodeComponent:NodeComponent)
		{
			super(nodeComponent);
		}
		
		override public function perform():Boolean
		{
			super.perform();
			this.theModel.isCut=true;
			this.theModel.copyOrCutModel=this.nodeModel;
			return true;
		}
		
		override public function undo():void
		{
			super.undo();
			this.theModel.isCut=false;
			this.theModel.copyOrCutModel=null;
		}

	}
}