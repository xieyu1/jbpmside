package org.jbpmside.xml
{
	import mx.collections.ArrayCollection;
	
	import org.jbpmside.model.jpdl4.Activity;
	import org.jbpmside.model.jpdl4.Assignment;
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
      		assertEquals("",processDefinition.getVersion());
      		assertEquals("",processDefinition.getPackageName());
      		assertEquals("",processDefinition.getDescription());
      		var startNode:Activity=processDefinition.getInitial();
      		assertEquals("s",startNode.getName());
      		assertEquals(1,processDefinition.getNodes().length);
      		assertEquals(startNode,processDefinition.getNode("s"));
		}
		
		public function testProcessWithCompleteAttributes():void{
			var processDefinition:ProcessDefinition=parse(
			"<process name='p' key='db' version='1' package='oa' >" +
			"  <description>it is a test process.</description>" +
      		"  <start name='s' />" +
      		"</process>");
      		assertEquals("p", processDefinition.getName());
      		assertEquals("db",processDefinition.getKey());
      		assertEquals("1",processDefinition.getVersion());
      		assertEquals("oa",processDefinition.getPackageName());
      		assertEquals("it is a test process.",processDefinition.getDescription());
		}
		
		public function testProcessWithTimer():void{
			var processDefinition:ProcessDefinition=parse(
			"<process name='p' key='db' version='1' package='oa' >" +
			"  <description>it is a test process.</description>" +
      		"  <start name='s' />" +
      		"</process>");
      		assertEquals("p", processDefinition.getName());
      		assertEquals("db",processDefinition.getKey());
      		assertEquals("1",processDefinition.getVersion());
      		assertEquals("oa",processDefinition.getPackageName());
      		assertEquals("it is a test process.",processDefinition.getDescription());
		}
		
		public function testProcessWithEvent():void{
			var processDefinition:ProcessDefinition=parse(
			"<process name='p' key='db' version='1' package='oa' >" +
			"  <description>it is a test process.</description>" +
      		"  <start name='s' />" +
      		"</process>");
      		assertEquals("p", processDefinition.getName());
      		assertEquals("db",processDefinition.getKey());
      		assertEquals("1",processDefinition.getVersion());
      		assertEquals("oa",processDefinition.getPackageName());
      		assertEquals("it is a test process.",processDefinition.getDescription());
		}
		
		public function testProcessWithSwimlane():void{
			var processDefinition:ProcessDefinition=parse(
			"<process name='p' key='db' version='1' package='oa' >" +
			"  <swimlane candidate-groups='sales-dept' name='sales representative'/>" +
			"  <swimlane candidate-users='ronghao,wuhao' name='dev representative'/>" +
			"  <swimlane assignee='ronghao' name='manager'/>" +
			"  <swimlane name='dev'/>" +
      		"  <start name='s' />" +
      		"</process>");
      		assertEquals("p", processDefinition.getName());
      		var swimlanes:ArrayCollection=processDefinition.getSwimlanes();
      		assertEquals(4,swimlanes.length);
      		assertEquals("sales-dept",processDefinition.getSwimlane('sales representative').getAssignment().getExpression());
      		assertEquals(Assignment.CANDIDATE_GROUPS,processDefinition.getSwimlane('sales representative').getAssignment().getType());
      		assertEquals("ronghao,wuhao",processDefinition.getSwimlane('dev representative').getAssignment().getExpression());
      		assertEquals(Assignment.CANDIDATE_USERS,processDefinition.getSwimlane('dev representative').getAssignment().getType());
      		assertEquals("ronghao",processDefinition.getSwimlane('manager').getAssignment().getExpression());
      		assertEquals(Assignment.ASSIGNEE,processDefinition.getSwimlane('manager').getAssignment().getType());
      		assertEquals("",processDefinition.getSwimlane('dev').getAssignment().getExpression());
      		assertEquals(Assignment.NONE,processDefinition.getSwimlane('dev').getAssignment().getType());
		}
		
	}
}