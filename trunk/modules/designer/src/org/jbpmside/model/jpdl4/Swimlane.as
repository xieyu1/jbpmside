package org.jbpmside.model.jpdl4
{
	import org.jbpmside.model.common.DefaultElement;

	public class Swimlane extends DefaultElement
	{
		private var assignment:Assignment;
        
        public function getAssignment():Assignment{
        	return assignment;
        }
        
        public function setAssignment(assignment:Assignment):void{
        	this.assignment=assignment;
        }
		
	}
}