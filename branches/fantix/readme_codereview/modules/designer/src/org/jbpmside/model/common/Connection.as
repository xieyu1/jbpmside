package org.jbpmside.model.common
{
	import mx.collections.ArrayCollection;
	
	public interface Connection extends Element
	{
		function getFrom():Node;
		
		function setFrom(node:Node):void;
		
		function getTo():Node;
		
		function setTo(node:Node):void;
		
		function getFromType():String;
		
		function getToType():String;
		
		function getEventListeners():ArrayCollection;
		
		function addEventListener(listener:EventListener):void;
		
		function removeEventListener(listener:EventListener):void;
	}
}