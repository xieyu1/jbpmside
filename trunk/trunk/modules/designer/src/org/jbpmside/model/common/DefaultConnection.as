package org.jbpmside.model.common
{
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	public class DefaultConnection extends DefaultElement implements Connection
	{
		private var fromNode:Node;
		private var toNode:Node;
		private var eventListeners:ArrayCollection=new ArrayCollection();
		
		public function getFrom():Node
		{
			return fromNode;
		}
		
		public function setFrom(node:Node):void
		{
			this.fromNode=node;
		}
		
		public function getTo():Node
		{
			return toNode;
		}
		
		public function setTo(node:Node):void
		{
			this.toNode=node;
		}
		
		public function getFromType():String
		{
			return null;
		}
		
		public function getToType():String
		{
			return null;
		}
		
		public function getEventListeners():ArrayCollection{
			return this.eventListeners;
		}
		
		public function addEventListener(listener:EventListener):void{
			eventListeners.addItem(listener);
		}
		
		public function removeEventListener(listener:EventListener):void{
			eventListeners.removeItemAt(eventListeners.getItemIndex(listener));
		}
		
	}
}