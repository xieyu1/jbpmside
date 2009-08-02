package org.jbpmside.model
/**
 * @author liuch 2009-6-1
 */
{
	public class ConnectionModel extends CommonObject
	{
		private var _toNode:NodeModel;
		private var _fromNode:NodeModel;
		
		public function ConnectionModel()
		{
		}
		
		//被删除时做一些清理工作
		public function destory():void{
			_toNode.removeTargetTransition(this);
			_fromNode.removeSourceTransition(this);
		}
		
		//####################################################
		//	getter/setter
		//####################################################	
		public function get toNode():NodeModel{
			return _toNode;
		}
		
		public function set toNode(_toNode:NodeModel):void{
			this._toNode = _toNode;
		}
		
		public function get fromNode():NodeModel{
			return _fromNode;
		}
		
		public function set fromNode(_fromNode:NodeModel):void{
			this._fromNode = _fromNode;
		}

	}
}