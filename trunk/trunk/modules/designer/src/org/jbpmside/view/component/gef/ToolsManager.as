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
		//处理连接线组件原生事件的Tool
		public static const SELECT_CONNECTION:int=1;
		//处理节点组件原生事件的Tool
		public static const SELECT_NODE:int=2;
		public static const CREATE_CONNECTION:int=3;
		//处理面板组件原生事件的Tool
		public static const CREATE_NODE:int=4;
		public static const SELECT_SURFACE:int=5;
		
		
		public function registerTool(toolKey:int):void{
			
		}
		
		public function getCurrentTool():Tool{
			return null;
		}
	}
}