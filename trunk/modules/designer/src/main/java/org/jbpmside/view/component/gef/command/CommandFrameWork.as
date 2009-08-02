package org.jbpmside.view.component.gef.command
/**
 * @author liuch 2009-6-1
 */
{
	public class CommandFrameWork
	{
		private var commandStack:CommandStack;
		public function CommandFrameWork(commandStack:CommandStack)
		{
			this.commandStack = commandStack;
		}

		public function execute(command:Command):void
		{
			commandStack.execute(command);
		}
		
		public function undo():void
		{
			commandStack.undo();
		}
		
	}
}