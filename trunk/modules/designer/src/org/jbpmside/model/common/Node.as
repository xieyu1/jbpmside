package org.jbpmside.model.common
{
	import mx.collections.ArrayCollection;
	
	public interface Node extends Container, Element
	{
		function setName(name:String):void;
		
		function getName():String;
		
		function setNodeContainer(container:Container):void;
		
		function getNodeContainer():Container;
		
		function getIncomingConnections():ArrayCollection;
		
		function getOutgoingConnections():ArrayCollection;
		
		function addIncomingConnection(connection:Connection):void;
		
		function addOutgoingConnection(connection:Connection):void;
		
		function removeIncomingConnection(connection:Connection):void;
		
		function removeOutgoingConnection(connection:Connection):void;
	}
}