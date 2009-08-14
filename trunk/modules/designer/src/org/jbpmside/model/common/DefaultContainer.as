package org.jbpmside.model.common
{
	import mx.collections.ArrayCollection;

	public class DefaultContainer extends DefaultElement implements Container
	{
		private var nodes:ArrayCollection=new ArrayCollection();
		private var eventListenerContainers:ArrayCollection=new ArrayCollection();
		
		public function getNodes():ArrayCollection
		{
			return nodes;
		}
		
		public function getNode(name:String):Node
		{
			for each(var node:Node in nodes){
				if(node.getName()==name){
					return node;
				}
			}
			return null;
		}
		
		public function addNode(node:Node):void
		{
			this.nodes.addItem(node);
			node.setNodeContainer(this);
		}
		
		public function removeNode(node:Node):void
		{
			this.nodes.removeItemAt(nodes.getItemIndex(node));
			node.setNodeContainer(null);
		}
		
		public function getEventListenerContainers():ArrayCollection{
			return eventListenerContainers;
		}
		
		public function getEventListenerContainer(eventType:String):EventListenerContainer{
			for each(var eventListenerContainer:EventListenerContainer in eventListenerContainers){
				if(eventListenerContainer.getEventType()==eventType){
					return eventListenerContainer;
				}
			}
			return null;
		}
		
		public function addEventListenerContainer(eventListenerContainer:EventListenerContainer):void{
			this.eventListenerContainers.addItem(eventListenerContainer);
		}
		
		public function removeEventListenerContainer(eventListenerContainer:EventListenerContainer):void{
			this.eventListenerContainers.removeItemAt(eventListenerContainers.getItemIndex(eventListenerContainer));
		}
		
	}
}