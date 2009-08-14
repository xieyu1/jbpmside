package org.jbpmside.view.component.role
/**
 * @author liuch 2009-6-1
 * ronghao 切换到统一的CommandService执行Command
 * 创建节点
 */
{
	import flash.events.MouseEvent;
	
	import org.jbpmside.view.component.command.CreateNodeCommand;
	import org.jbpmside.view.component.gef.command.Command;
	import org.jbpmside.view.component.gef.command.CommandService;

	public class CreationTool extends CopyCutPasteDeleteTool
	{

		public function CreationTool()
		{
			super();
		}

		override public function mouseClick(e:MouseEvent, x:int, y:int):void
		{
			var cmd:Command=new CreateNodeCommand(type, x, y);
			CommandService.getInstance().execute(cmd);
		}

	}
}