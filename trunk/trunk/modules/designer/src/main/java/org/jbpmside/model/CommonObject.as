package org.jbpmside.model
/**
 * @author liuch 2009-6-1
 */
{
	import flash.events.EventDispatcher;
	
	public class CommonObject extends EventDispatcher
	{
		protected var theModel:TheModel=TheModel.getInstance();
		
		private var _name:String;
		
		private var _id:String;
		
		public function CommonObject()
		{
			//TODO: implement function
		}
		
		public function get name():String{
			return _name;
		}
		
		public function set name(_name:String):void{
			this._name = _name;
		}
		
		public function get id():String{
			return _id;
		}
		
		public function set id(_id:String):void{
			this._id = _id;
		}

	}
}