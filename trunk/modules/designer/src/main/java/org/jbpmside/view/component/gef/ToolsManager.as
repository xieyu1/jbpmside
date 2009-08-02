package org.jbpmside.view.component.gef
/**
 * @author ronghao 2009-8-1
 * 集中管理view component的tools
 * tools的注册与改变
 */
{
	public class ToolsManager
	{
		//####################################################
		//	tools constants
		//####################################################	
		public static const SELECT_COMPONENT:int=0;
		public static const CREATE_NODE:int=1;
		public static const CREATE_CONNECTION:int=2;
		public static const MOVE_NODE:int=3;
		
		public function registerTool(toolKey:int):void{
			
		}
		
		public function getCurrentTool():Tool{
			return null;
		}
	}
}