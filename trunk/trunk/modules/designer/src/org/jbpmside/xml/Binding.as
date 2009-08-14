package org.jbpmside.xml
{
	public interface Binding
	{
		function getCategory():String;
		
		function setCategory(category:String):void;
		
		function matches(elementName:String):Boolean;
		
		function parse(elementXml:XML,parse:Parse,parser:Parser):Object;

	}
}