package org.jbpmside.xml
{
	import mx.collections.ArrayCollection;
	
	import org.jbpmside.model.common.EventListener;
	import org.jbpmside.model.common.EventListenerContainer;
	import org.jbpmside.model.jpdl4.Activity;
	import org.jbpmside.model.jpdl4.Assignment;
	import org.jbpmside.model.jpdl4.ProcessDefinition;
	import org.jbpmside.model.jpdl4.Timer;
	
	public class StateParsingTest extends JpdlParseTestCase
	{
		public function testSimplestValidState():void{
			var processDefinition:ProcessDefinition=parse(
			"<process name='p'>" +
      		"  <start name='s' />" +
      		"</process>");
      		assertEquals("p", processDefinition.getName());
      		assertEquals("",processDefinition.getKey());
      		assertEquals("",processDefinition.getVersion());
      		assertEquals("",processDefinition.getPackageName());
      		assertEquals("",processDefinition.getDescription());
      		var startNode:Activity=processDefinition.getInitial();
      		assertEquals("s",startNode.getName());
      		assertEquals(1,processDefinition.getNodes().length);
      		assertEquals(startNode,processDefinition.getNode("s"));
		}
		
	}
}