package org.jbpmside.model.common
{
	public class DefaultElement implements Element
	{
		private var name:String;
		
		public function setName(name:String):void
		{
			this.name=name;
		}
		
		public function getName():String
		{
			return name;
		}
	}
}