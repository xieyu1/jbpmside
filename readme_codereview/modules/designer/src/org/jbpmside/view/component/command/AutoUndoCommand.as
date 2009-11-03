package org.jbpmside.view.component.command
/**
 * @author liuch 2009-6-1
 */
{
	import org.jbpmside.view.component.gef.IGraphicalEditor;
	import org.jbpmside.view.component.gef.command.Command;
	import org.jbpmside.model.TheModel;
	
	public class AutoUndoCommand implements Command
	{
		public var theModel:TheModel=TheModel.getInstance();
		
		public function AutoUndoCommand()
		{
			//TODO: implement function
		}

		public function canDo():Boolean
		{
			//TODO: implement function
			return true;
		}
		
		public function perform():Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function canUndo():Boolean
		{
			//TODO: implement function
			return true;
		}
		
		public function canRedo():Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function redo():void
		{
			//TODO: implement function
		}
		
		public function undo():void
		{
			//TODO: implement function
		}
		
		public function get editor():IGraphicalEditor{
			return ProcessEditor.getEditor();
		}
		
	}
}