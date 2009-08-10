package org.jbpmside.xml
{
	import org.jbpmside.model.jpdl4.Activity;
	import org.jbpmside.model.jpdl4.ProcessDefinition;
	
	public class ProcessParsingTest extends JpdlParseTestCase
	{
		public function testSimplestValidProcess():void{
			var processDefinition:ProcessDefinition=parse(
			"<process name='p'>" +
      		"  <start name='s' />" +
      		"</process>");
      		assertEquals("p", processDefinition.getName());
      		assertEquals("",processDefinition.getKey());
      		var startNode:Activity=processDefinition.getInitial();
      		assertEquals("s",startNode.getName());
      		assertEquals(1,processDefinition.getNodes().length);
      		assertEquals(startNode,processDefinition.getNode("s"));
		}
		
	}
}