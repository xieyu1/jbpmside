package org.jbpmside.view.component.gef.command
/**
 * @author liuch 2009-6-1
 */
{
	import org.jbpmside.view.component.gef.IGraphicalEditor;
	
	public interface Command
	{
		function canDo():Boolean;
		
		function perform():Boolean;
		
		function canUndo():Boolean;
		
		function canRedo():Boolean;
		
		function redo():void;
		
		function undo():void;
		
		function get editor():IGraphicalEditor;
	}
}