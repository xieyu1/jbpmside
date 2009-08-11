package org.jbpmside.xml
/**
 * @author ronghao
 */
{
	import org.jbpmside.model.common.DefaultContainer;
	import org.jbpmside.model.jpdl4.Activity;
	import org.jbpmside.model.jpdl4.Assignment;
	import org.jbpmside.model.jpdl4.ProcessDefinition;
	import org.jbpmside.model.jpdl4.Swimlane;
	
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
		
		public function getBinding(elementXml:XML,category:String):Binding{
			return bindings.getBinding(elementXml,category);
		}
	}
}