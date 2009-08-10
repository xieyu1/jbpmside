package org.jbpmside.model.jpdl4
{
	import mx.collections.ArrayCollection;
	
	import org.jbpmside.model.common.DefaultFlow;

	public class ProcessDefinition extends DefaultFlow
	{
		private var key:String;
		private var version:String;
		private var description:String;
		private var packageName:String;
		private var timers:ArrayCollection=new ArrayCollection();
		private var swimlanes:ArrayCollection=new ArrayCollection();
		private var initial:Activity;
		
		public function getInitial():Activity{
			return initial;
		}
		
		public function setInitial(initial:Activity):void{
			this.initial=initial;
		}
		
		public function setKey(key:String):void
		{
			this.key=key;
		}
		
		public function getKey():String
		{
			return key;
		}
		
		public override function setVersion(version:String):void
		{
			this.version=version;
		}
		
		public override function getVersion():String
		{
			return version;
		}
		
		public function setDescription(description:String):void
		{
			this.description=description;
		}
		
		public function getDescription():String
		{
			return description;
		}
		
		public override function setPackageName(packageName:String):void
		{
			this.packageName=packageName;
		}
		
		public override function getPackageName():String
		{
			return packageName;
		}
		
		public function getTimers():ArrayCollection{
			return this.timers;
		}
		
		public function addTimer(timer:Timer):void{
			this.timers.addItem(timer);
		}
		
		public function removeTimer(timer:Timer):void{
			this.timers.removeItemAt(timers.getItemIndex(timer));
		}
		
		public function getSwimlanes():ArrayCollection{
			return this.swimlanes;
		}
		
		public function addSwimlane(swimlane:Swimlane):void{
			this.swimlanes.addItem(swimlane);
		}
		
		public function removeSwimlane(swimlane:Swimlane):void{
			this.swimlanes.removeItemAt(swimlanes.getItemIndex(swimlane));
		}
		
	}
}