package org.jbpmside.xml.binding
{
	import org.jbpmside.model.jpdl4.Activity;
	import org.jbpmside.model.jpdl4.ProcessDefinition;
	import org.jbpmside.model.jpdl4.StartActivity;
	import org.jbpmside.xml.Parse;
	import org.jbpmside.xml.Parser;
	
	public class StartBinding extends JpdlBinding
	{
		public function StartBinding()
		{
			super("start");
		}
		
		public override function parseActivity(elementXml:XML,parse:Parse,parser:Parser):Activity{
			var processDefinition:ProcessDefinition=parse.getProcessDefinition() as ProcessDefinition;
			var startActivity:Activity=new StartActivity();
			processDefinition.setInitial(startActivity);			
			return startActivity;
		}

	}
}