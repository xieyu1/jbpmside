package org.jbpmside.xml
{
	import org.jbpmside.model.jpdl4.ProcessDefinition;
	import org.jbpmside.model.jpdl4.Activity;
	
	public class TaskParsingTest extends JpdlParseTestCase{
		
		/**
		 * 
		 * 验证最简单的任务节点解析
		 **/
		public function testSimpleTask(){
			var processDefinition:ProcessDefinition=parse(
			"<process name='p'>" +
      		"  <task name='t' g='19,50,48,49'/>" +
      		"</process>");
      		assertEquals("p", processDefinition.getName());
      		assertEquals("",processDefinition.getKey());
      		assertEquals("",processDefinition.getVersion());
      		assertEquals("",processDefinition.getPackageName());
      		assertEquals("",processDefinition.getDescription());
//      		
//      		var taskNode:Activity=processDefinition.getInitial();
//      		assertEquals("t",taskNode.getName());
//      		assertEquals(1,processDefinition.getNodes().length);
//      		assertEquals(taskNode,processDefinition.getNode("t"));
		}

	}
}