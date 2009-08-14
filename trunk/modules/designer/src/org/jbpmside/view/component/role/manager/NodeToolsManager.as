package org.jbpmside.view.component.role.manager
/**
 * @author ronghao 2009-8-1
 */
{
	import org.jbpmside.view.component.gef.Tool;
	import org.jbpmside.model.TheModel;
	import org.jbpmside.view.component.gef.ToolsManager;
	
	public class NodeToolsManager extends AbstractToolsManager
	{
		public function NodeToolsManager()
		{
			super();
			this.registerTool(ToolsManager.CREATE_CONNECTION);
			this.registerTool(ToolsManager.SELECT_NODE);
		}
		
		public override function getCurrentToolBackup():Tool{
			var barSelectedMode:int=theModel.selectedMode;
			if(barSelectedMode== TheModel.SELECTED_TRANSITION){
				return connectionTool;
			}
			return selectNodeTool;
		}
		
		//####################################################
		//	singleton
		//####################################################	
		
		private static var _instance:NodeToolsManager
		
		public static function getInstance():NodeToolsManager{
			if( !_instance ){
				_instance = new NodeToolsManager();
			}
			return _instance;
		}

	}
}