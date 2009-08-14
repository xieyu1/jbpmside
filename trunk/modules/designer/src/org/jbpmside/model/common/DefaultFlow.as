package org.jbpmside.model.common
{
	import mx.collections.ArrayCollection;

	public class DefaultFlow extends DefaultContainer implements Flow
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
		
		public function setVersion(version:String):void
		{
		}
		
		public function getVersion():String
		{
			return null;
		}
		
		public function setType(type:String):void
		{
		}
		
		public function getType():String
		{
			return null;
		}
		
		public function setPackageName(packageName:String):void
		{
		}
		
		public function getPackageName():String
		{
			return null;
		}
		
	}
}