package org.jbpmside.view.component.role.manager
{
	import org.jbpmside.model.TheModel;
	import org.jbpmside.view.component.gef.Tool;
	import org.jbpmside.view.component.gef.ToolsManager;
	
	public class SurfaceToolsManager extends AbstractToolsManager
	{
		public function SurfaceToolsManager()
		{
			super();
			this.registerTool(ToolsManager.CREATE_NODE);
			this.registerTool(ToolsManager.SELECT_SURFACE);
		}
		
		public override function getCurrentToolBackup():Tool{
			var barSelectedMode:int=theModel.selectedMode;
			if(barSelectedMode!= TheModel.SELECTED_NONE && barSelectedMode!= TheModel.SELECTED_TRANSITION){
				createTool.type=barSelectedMode;
				return createTool;
			}
			return selectSurfaceTool;
		}
		
		//####################################################
		//	singleton
		//####################################################	
		
		private static var _instance:SurfaceToolsManager
		
		public static function getInstance():SurfaceToolsManager{
			if( !_instance ){
				_instance = new SurfaceToolsManager();
			}
			return _instance;
		}

	}
}