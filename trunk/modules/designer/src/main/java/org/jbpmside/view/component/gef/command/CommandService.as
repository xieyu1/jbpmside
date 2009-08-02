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
		
		//####################################################
		//	singleton
		//####################################################	
		
		public function CommandService(){
			_commandStack=new CommandStack();
			_commandStack.setUndoLimit(10);
			_commandFrameWork=new CommandFrameWork(_commandStack);
		}
		
		private static var _instance:CommandService
		
		public static function getInstance():CommandService{
			if( !_instance ){
				_instance = new CommandService();
			}
			return _instance;
		}

	}
}