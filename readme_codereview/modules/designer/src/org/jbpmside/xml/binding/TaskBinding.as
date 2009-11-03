package org.jbpmside.xml.binding
{
	import org.jbpmside.model.jpdl4.Activity;
	import org.jbpmside.model.jpdl4.ProcessDefinition;
	import org.jbpmside.model.jpdl4.TaskActivity;
	import org.jbpmside.xml.Parse;
	import org.jbpmside.xml.Parser;
	public class TaskBinding extends JpdlBinding {
		public function TaskBinding(){
			super("task");
		}
		public override function parseActivity(elementXml:XML,parse:Parse,parser:Parser):Activity{
			var processDefinition:ProcessDefinition=parse.getProcessDefinition() as ProcessDefinition;
			var taskActivity:Activity=new TaskActivity();
			processDefinition.setInitial(taskActivity);			
			return taskActivity;
		}
	}
}