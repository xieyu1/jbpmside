package org.jbpmside.event
{
	import flash.events.Event;
	
	public class CustomEvent extends Event{
		
		public var data:* = "default data";
		public var msg:* = "default msg";
		
		//type, data, arg
		public function CustomEvent(type:String, ... args){
			
			super(type, true, true);
			
			if(args){
				this.data = ( args[0] != undefined ) ? args[0] : trace("");
				this.msg = ( args[1] != undefined ) ? args[1] : trace("");
			}
		}
		
	}
}