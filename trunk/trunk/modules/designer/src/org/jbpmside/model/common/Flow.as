package org.jbpmside.model.common
{
	public interface Flow extends Container, Element
	{
		function setName(name:String):void;
		
		function getName():String;
		
		function setVersion(version:String):void;
		
		function getVersion():String;
		
		function setType(type:String):void;
		
		function getType():String;
		
		function setPackageName(packageName:String):void;
		
		function getPackageName():String;
	}
}