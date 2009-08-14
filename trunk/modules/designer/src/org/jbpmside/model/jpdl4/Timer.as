package org.jbpmside.model.jpdl4
{
	import org.jbpmside.model.common.DefaultElement;

	public class Timer extends DefaultElement
	{
		private var dueDate:String;
		private var repeat:String;
		private var dueDateTime:String;
		
		public function getDueDate():String{
			return dueDate;
		}
		
		public function setDueDate(dueDate:String):void{
			this.dueDate=dueDate;
		}
		
		public function getDueDateTime():String{
			return dueDateTime;
		}
		
		public function setDueDateTime(dueDateTime:String):void{
			this.dueDateTime=dueDateTime;
		}
		
		public function getRepeat():String{
			return repeat;
		}
		
		public function setRepeat(repeat:String):void{
			this.repeat=repeat;
		}
		
	}
}