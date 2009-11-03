package org.jbpmside.xml.binding
{
	import org.jbpmside.model.jpdl4.Activity;
	import org.jbpmside.model.jpdl4.ProcessDefinition;
	import org.jbpmside.model.jpdl4.StateActivity;
	import org.jbpmside.xml.Parse;
	import org.jbpmside.xml.Parser;
	
	public class StateBinding extends JpdlBinding
	{
		public function StateBinding()
		{
			super("state");
		}
		
		public override function parseActivity(elementXml:XML,parse:Parse,parser:Parser):Activity{
			var stateActivity:Activity=new StateActivity();	
			return stateActivity;
		}
	}
}