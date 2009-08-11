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
		
		public override function parse(elementXml:XML,parse:Parse,parser:Parser):Object{
			var processDefinition:ProcessDefinition=parse.getProcessDefinition() as ProcessDefinition;
			var startActivity:Activity=new StartActivity();
			var name:String=elementXml.@name;
			startActivity.setName(name);
			processDefinition.addNode(startActivity);
			processDefinition.setInitial(startActivity);
			return startActivity;
		}

	}
}