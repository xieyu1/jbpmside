package org.jbpmside.model.common
{
	import mx.collections.ArrayCollection;

	public class DefaultNode extends DefaultContainer implements Node
	{
		private var name:String;
		private var container:Container;
		private var incomingConnections:ArrayCollection=new ArrayCollection();
		private var outgoingConnections:ArrayCollection=new ArrayCollection();
		
		public function setName(name:String):void
		{
			this.name=name;
		}
		
		public function getName():String
		{
			return name;
		}
		
		public function setNodeContainer(container:Container):void
		{
			this.container=container;
		}
		
		public function getNodeContainer():Container
		{
			return container;
		}
		
		public function getIncomingConnections():ArrayCollection
		{
			return incomingConnections;
		}
		
		public function getOutgoingConnections():ArrayCollection
		{
			return outgoingConnections;
		}
		
		public function addIncomingConnection(connection:Connection):void
		{
			incomingConnections.addItem(connection);
			connection.setTo(this);
		}
		
		public function addOutgoingConnection(connection:Connection):void
		{
			outgoingConnections.addItem(connection);
			connection.setFrom(this);
		}
		
		public function removeIncomingConnection(connection:Connection):void
		{
			incomingConnections.removeItemAt(incomingConnections.getItemIndex(connection));
			connection.setTo(null);
		}
		
		public function removeOutgoingConnection(connection:Connection):void
		{
			outgoingConnections.removeItemAt(outgoingConnections.getItemIndex(connection));
			connection.setFrom(null);
		}
		
	}
}