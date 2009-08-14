package org.jbpmside.model.common
{
	import mx.collections.ArrayCollection;
	
	public interface Container extends Element
	{
		function getNodes():ArrayCollection;
		
		function getNode(name:String):Node;
		
		function addNode(node:Node):void;
		
		function removeNode(node:Node):void;
		
		function getEventListenerContainers():ArrayCollection;
		
		function getEventListenerContainer(eventType:String):EventListenerContainer;
		
		function addEventListenerContainer(eventListenerContainer:EventListenerContainer):void;
		
		function removeEventListenerContainer(eventListenerContainer:EventListenerContainer):void;
	}
}