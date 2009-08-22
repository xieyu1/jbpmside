package org.jbpmside.xml
{
	import mx.collections.ArrayCollection;
	
	import org.jbpmside.model.common.EventListener;
	import org.jbpmside.model.common.EventListenerContainer;
	import org.jbpmside.model.jpdl4.Activity;
	import org.jbpmside.model.jpdl4.ProcessDefinition;
	import org.jbpmside.model.jpdl4.Transition;
	
	/**
	 * start节点没有timer 因为其没有等待状态
	 * */
	public class StartParsingTest extends JpdlParseTestCase
	{
		public function testSimplestValidStart():void{
			var processDefinition:ProcessDefinition=parse(
			"<process name='p'>" +
      		"  <start name='s' g='19,50,48,49'/>" +
      		"</process>");
      		assertEquals("p", processDefinition.getName());
      		var startNode:Activity=processDefinition.getInitial();
      		assertEquals("s",startNode.getName());
      		assertEquals(1,processDefinition.getNodes().length);
      		assertEquals(startNode,processDefinition.getNode("s"));
      		assertEquals(19,startNode.x);
      		assertEquals(50,startNode.y);
      		assertEquals(48,startNode.width);
      		assertEquals(49,startNode.height);
		}
		
		public function testStartWithTransition():void{
			var processDefinition:ProcessDefinition=parse(
			"<process name='p'>" +
      		"  <start name='s'>" +
      		"    <transition name='t' to='guardedWait'/>"+
      		"  </start>"+
      		"  <state name='guardedWait'/>"+
      		"</process>");
      		assertEquals("p", processDefinition.getName());
      		var startNode:Activity=processDefinition.getInitial();
      		var transition:Transition=startNode.getOutgoingConnections().getItemAt(0) as Transition;
      		assertEquals("t",transition.getName());
      		var stateNode:Activity=processDefinition.getNode("guardedWait") as Activity;
      		assertEquals(startNode,transition.getFrom());
      		assertEquals(stateNode,transition.getTo());
		}
		
		public function testStartWithEvent():void{
			var processDefinition:ProcessDefinition=parse(
			"<process name='p'>" +
      		"  <start name='s'>" +
      		"  <on event='start'>"+
      		"		<event-listener class='org.jbpm.examples.timer.event.Escalate' />"+
    		"  </on>" +
    		"  </start>"+
      		"</process>");
      		assertEquals("p", processDefinition.getName());
      		var startNode:Activity=processDefinition.getInitial();
      		var events:ArrayCollection=startNode.getEventListenerContainers();
      		assertEquals(1,events.length);
      		var startEvent:EventListenerContainer=startNode.getEventListenerContainer("start");
      		var startEventListener:EventListener=startEvent.getEventListeners().getItemAt(0) as EventListener;
      		assertEquals("org.jbpm.examples.timer.event.Escalate",startEventListener.getClassName());
		}
	}
}