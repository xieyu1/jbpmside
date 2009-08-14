package org.jbpmside.model.common
{
	public class EventListener extends DefaultElement
	{
		private var className:String;
		
		public function getClassName():String{
			return className;
		}
		
		public function setClassName(className:String):void{
			this.className=className;
		}
		
	}
}