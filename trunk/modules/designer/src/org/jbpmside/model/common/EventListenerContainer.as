package org.jbpmside.model.common
{
	import mx.collections.ArrayCollection;
	
	public class EventListenerContainer extends DefaultElement
	{
		private var eventType:String;
		private var dueDate:String;
		private var repeat:String;
		private var eventListeners:ArrayCollection=new ArrayCollection();
		
		public function getEventType():String{
			return eventType;
		}
		
		public function setEventType(type:String):void{
			this.eventType=type;
		}
		
		public function getDueDate():String{
			return dueDate;
		}
		
		public function setDueDate(dueDate:String):void{
			this.dueDate=dueDate;
		}
		
		public function getRepeat():String{
			return repeat;
		}
		
		public function setRepeat(repeat:String):void{
			this.repeat=repeat;
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