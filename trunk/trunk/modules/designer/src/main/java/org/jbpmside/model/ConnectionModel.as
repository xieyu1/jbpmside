package org.jbpmside.model
/**
 * @author liuch 2009-6-1
 */
{
	public class ConnectionModel extends CommonObject
	{
		private var _toNode:String;
		
		public function ConnectionModel()
		{
		}
		
		public function get toNode():String{
			return _toNode;
		}
		
		public function set toNode(_toNode:String):void{
			this._toNode = _toNode;
		}

	}
}