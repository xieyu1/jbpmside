package org.jbpmside.view.component.role
/**
 * @author liuch 2009-6-1
 */
{
	import flash.events.MouseEvent;
	
	import org.jbpmside.view.component.command.CreateNodeCommand;
	import org.jbpmside.view.component.gef.command.Command;

	public class CreationTool extends AbstractTool
	{

		public function CreationTool()
		{
			//TODO: implement function
			super();
		}

		override public function mouseClick(e:MouseEvent, x:int, y:int):void
		{
			var cmd:Command=new CreateNodeCommand(type, x, y);
			cmd.perform();
		}

	}
}