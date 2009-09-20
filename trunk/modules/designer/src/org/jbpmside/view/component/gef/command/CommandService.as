package org.jbpmside.view.component.gef.command
{
	public class CommandService
	{
		
		private var _commandFrameWork:CommandFrameWork;
		private var _commandStack:CommandStack;
		
		public function execute(command:Command):void
		{
			_commandFrameWork.execute(command);
		}
		
		public function undo():void
		{
			if(_commandStack.canUndo())
				_commandFrameWork.undo();
		}
		
		public function redo():void
		{
			if(_commandStack.canRedo())
				_commandFrameWork.redo();
		}
		
		//####################################################
		//	singleton
		//####################################################	
		
		public function CommandService(){
			_commandStack=new CommandStack();
			_commandStack.setUndoLimit(10);
			_commandFrameWork=new CommandFrameWork(_commandStack);
		}

	}
}