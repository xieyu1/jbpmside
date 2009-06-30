package org.jbpmside.model
/**
 * @author liuch 2009-6-1
 */
{
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	import org.jbpmside.event.CustomEvent;
	
	public class ProcessModel extends CommonObject
	{
		private var _nodeCollection:ArrayCollection = new ArrayCollection();
		
		
		public function ProcessModel()
		{
			_nodeCollection.addEventListener(CollectionEvent.COLLECTION_CHANGE,onNodeCollectionChange);
		}
		
		public function get nodeCollection():ArrayCollection{
			return _nodeCollection;
		}
		
		public function set nodeCollection(_nodeCollection:ArrayCollection):void{
			this._nodeCollection = _nodeCollection;
		}
		
		public function addNode(node:NodeModel):void{
			_nodeCollection.addItem(node);
		}
		
		public function removeNode(node:NodeModel):void{
			_nodeCollection.removeItemAt(_nodeCollection.getItemIndex(node));
		}
		
		private function onNodeCollectionChange(event:CollectionEvent):void{
			theModel.dispatchEvent(new CustomEvent(TheModel.NODE_COLLECTION_CHANGE_EVENT));
		}

	}
}