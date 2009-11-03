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
		
		private var _id:String; //it is not jBPM4 property
		
		private var _description:String;
		
		public function CommonObject()
		{
		}
		
		//####################################################
		//	getter/setter
		//####################################################	
				
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
		
		public function get description():String{
			return _description;
		}
		
		public function set description(_description:String):void{
			this._description = _description;
		}

	}
}