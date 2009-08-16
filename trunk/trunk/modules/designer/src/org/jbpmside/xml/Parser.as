package org.jbpmside.xml
/**
 * @author ronghao
 */
{
	import mx.collections.ArrayCollection;
	
	import org.jbpmside.model.common.DefaultContainer;
	import org.jbpmside.model.common.EventListener;
	import org.jbpmside.model.common.EventListenerContainer;
	import org.jbpmside.model.jpdl4.Activity;
	import org.jbpmside.model.jpdl4.Assignment;
	import org.jbpmside.model.jpdl4.ProcessDefinition;
	import org.jbpmside.model.jpdl4.Swimlane;
	import org.jbpmside.model.jpdl4.Timer;
	import org.jbpmside.model.jpdl4.Transition;
	
	public class Parser
	{
		public static const CATEGORY_ACTIVITY:String="activity";
		public static const CATEGORY_EVENT_LISTENER:String="eventlistener";
		
		private var bindings:Bindings=Bindings.getInstance();
		
		public function Parser()
		{
		}
		
		public function createParse():Parse{
			return new Parse(this);			
		}
		
		//####################################################
		//	parse execution
		//####################################################	

		public function execute(parse:Parse):void {
			parseDocument(parse.getXml(), parse);
		}
		
		public function parseDocument(xml:XML,parse:Parse):void{
			var processDefinition:ProcessDefinition=new ProcessDefinition();
			parse.setProcessDefinition(processDefinition);
			try{
				parseProcessDefinition(xml,processDefinition);
				
				parseActivities(xml,parse,processDefinition);
				
				resolveTransitionDestinations(parse,processDefinition);
			}catch(e:ReferenceError){
				
			}
		}
		
		private function parseProcessDefinition(xml:XML,processDefinition:ProcessDefinition):void{
			var name:String=xml.@name;
			processDefinition.setName(name);
			
			var key:String=xml.@key;
			processDefinition.setKey(key);
			
			var version:String=xml.@version;
			processDefinition.setVersion(version);
			
			var packageName:String=xml.attribute('package');
			processDefinition.setPackageName(packageName);
			
			var description:String=xml.description.text();
			processDefinition.setDescription(description);
			
			parseSwimlanes(xml,processDefinition);
			
			parseTimers(xml,processDefinition);
			
			parseEvents(xml,processDefinition);
		} 
		
		private function parseSwimlanes(xml:XML,processDefinition:ProcessDefinition):void{
			var elementList:XMLList=xml.swimlane;
			for each(var element:XML in elementList){
				var name:String=element.@name;
				var swimlane:Swimlane=new Swimlane();
				swimlane.setName(name);
				parseAssignmentAttributes(element,swimlane);
				processDefinition.addSwimlane(swimlane);
			}
		} 
		
		private function parseEvents(xml:XML,processDefinition:ProcessDefinition):void{
			var elementList:XMLList=xml.on;
			for each(var element:XML in elementList){
				var eventType:String=element.@event;
				var duedate:String=element.timer.@duedate;
				var repeat:String=element.timer.@repeat;
				var event:EventListenerContainer=new EventListenerContainer();
				event.setEventType(eventType);
				event.setDueDate(duedate);
				event.setRepeat(repeat);
				parseEventListeners(element,event);
				processDefinition.addEventListenerContainer(event);
			}
		} 
		
		private function parseEventListeners(xml:XML,container:EventListenerContainer):void{
			var elementList:XMLList=xml.child("event-listener");
			for each(var element:XML in elementList){
				var className:String=element.attribute("class");
				var listener:EventListener=new EventListener();
				listener.setClassName(className);
				container.addEventListener(listener);
			}
		} 
		
		private function parseTimers(xml:XML,processDefinition:ProcessDefinition):void{
			var elementList:XMLList=xml.timer;
			for each(var element:XML in elementList){
				var duedate:String=element.@duedate;
				var repeat:String=element.@repeat;
				var duedatetime:String=element.@duedatetime;
				var timer:Timer=new Timer();
				timer.setDueDate(duedate);
				timer.setRepeat(repeat);
				timer.setDueDateTime(duedatetime);
				processDefinition.addTimer(timer);
			}
		} 
		
		private function parseAssignmentAttributes(xml:XML,swimlane:Swimlane):void{
			var assignment:Assignment=new Assignment();
			var assignee:String=xml.@assignee;
			var candidateUsers:String=xml.attribute('candidate-users');
			var candidateGroups:String=xml.attribute('candidate-groups');
			if(assignee!=''){
				assignment.setExpression(assignee);
				assignment.setType(Assignment.ASSIGNEE);
				assignment.setExpressionLanguage(xml.attribute('assignee-lang'));
			}else if(candidateUsers!=''){
				assignment.setExpression(candidateUsers);
				assignment.setType(Assignment.CANDIDATE_USERS);
				assignment.setExpressionLanguage(xml.attribute('candidate-users-lang'));
			}else if(candidateGroups!=''){
				assignment.setExpression(candidateGroups);
				assignment.setType(Assignment.CANDIDATE_GROUPS);
				assignment.setExpressionLanguage(xml.attribute('candidate-groups-lang'));
			}
			swimlane.setAssignment(assignment);
		} 
		
		private function parseActivities(xml:XML,parse:Parse,nodeContainer:DefaultContainer):void{
			var elementList:XMLList=xml.elements("*");
			for each(var element:XML in elementList){
				var tagName:String=element.name();
				if(tagName=="on"||tagName=="timer"||tagName=="swimlane"||tagName=="description"){
					continue;
				}
				var binding:Binding=getBinding(element,Parser.CATEGORY_ACTIVITY);
				var activity:Activity=binding.parse(element,parse,this) as Activity;
			}
		} 
		
		private function resolveTransitionDestinations(parse:Parse,processDefinition:ProcessDefinition):void{
			var transitions:ArrayCollection=parse.getUnresolvedTransitions();
			for each(var t:Transition in transitions){
				var toname:String=t.toName;
				if(toname==""){
					continue;
				}
				var activity:Activity=processDefinition.getNode(toname) as Activity;
				activity.addIncomingConnection(t);
			}
		}
		
		public function getBinding(elementXml:XML,category:String):Binding{
			return bindings.getBinding(elementXml,category);
		}
	}
}