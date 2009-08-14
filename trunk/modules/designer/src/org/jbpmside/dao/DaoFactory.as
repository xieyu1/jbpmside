package org.jbpmside.dao
{
	public class DaoFactory
	{
		private var _toolBarDAO:ToolBarDAO = new ToolBarDAO();
		
		public function get toolBarDAO():ToolBarDAO{
			return _toolBarDAO;
		}
		
		//####################################################
		//	singleton
		//####################################################	
		
		public function DaoFactory(){

		}
		
		private static var _instance:DaoFactory
		
		public static function getInstance():DaoFactory{
			if( !_instance ){
				_instance = new DaoFactory();
			}
			return _instance;
		}

	}
}