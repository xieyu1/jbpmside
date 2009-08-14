package org.jbpmside.model.jpdl4
{
	import org.jbpmside.model.common.DefaultElement;

	public class Swimlane extends DefaultElement
	{
		private var name:String;
		private var assignment:Assignment;
		
		public function getName():String{
        	return name;
        }
        
        public function setName(name:String):void{
        	this.name=name;
        }
        
        public function getAssignment():Assignment{
        	return assignment;
        }
        
        public function setAssignment(assignment:Assignment):void{
        	this.assignment=assignment;
        }
		
	}
}