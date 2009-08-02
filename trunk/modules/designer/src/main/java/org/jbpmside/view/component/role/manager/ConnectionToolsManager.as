package org.jbpmside.view.component.role.manager
/**
 * @author ronghao 2009-8-1
 */
{
	import org.jbpmside.view.component.gef.Tool;
	
	public class ConnectionToolsManager extends AbstractToolsManager
	{
		public function ConnectionToolsManager()
		{
			super();
		}
		
		public override function getCurrentToolBackup():Tool{
			return selectTool;
		}
		
		//####################################################
		//	singleton
		//####################################################	
		
		private static var _instance:ConnectionToolsManager
		
		public static function getInstance():ConnectionToolsManager{
			if( !_instance ){
				_instance = new ConnectionToolsManager();
			}
			return _instance;
		}

	}
}