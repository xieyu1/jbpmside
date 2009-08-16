package org.jbpmside.xml.binding
{
	import org.jbpmside.model.jpdl4.Activity;
	import org.jbpmside.model.jpdl4.ProcessDefinition;
	import org.jbpmside.model.jpdl4.Transition;
	import org.jbpmside.xml.Binding;
	import org.jbpmside.xml.Parse;
	import org.jbpmside.xml.Parser;
	
	public class JpdlBinding implements Binding
	{
		public var category:String;
		public var tagName:String;
		
		public function JpdlBinding(tagName:String)
		{
			this.tagName=tagName;
		}
		
		public function getCategory():String{
			return this.category;
		}
		
		public function setCategory(category:String):void{
			this.category=category;
		}
		
		public function matches(elementName:String):Boolean{
			if(elementName==tagName){
				return true;
			}
			return false;
		}
		
		public function parse(elementXml:XML,parse:Parse,parser:Parser):Object{
			var processDefinition:ProcessDefinition=parse.getProcessDefinition() as ProcessDefinition;
			var activity:Activity=parseActivity(elementXml,parse,parser);
			var name:String=elementXml.@name;
			activity.setName(name);
			parseCoordinate(elementXml,activity);
			parseTransition(elementXml,activity,parse);
			processDefinition.addNode(activity);
			return activity;
		}	
		
		public function parseActivity(elementXml:XML,parse:Parse,parser:Parser):Activity{
			return null;
		}
		
		public function parseCoordinate(elementXml:XML,activity:Activity):void{
			var g:String=elementXml.@g;
			var coordinate:Array=g.split(',');
			activity.x=int(coordinate[0]);
			activity.y=int(coordinate[1]);
			activity.width=int(coordinate[2]);
			activity.height=int(coordinate[3]);
		}
		
		public function parseTransition(xml:XML,activity:Activity,parse:Parse):void{
			var elementList:XMLList=xml.transition;
			for each(var element:XML in elementList){
				var name:String=element.@name;
				var toname:String=element.attribute("to");
				var transition:Transition=new Transition();
				transition.setName(name);
				transition.toName=toname;
				activity.addOutgoingConnection(transition);
				parse.addUnresolvedTransition(transition);
			}
		}

	}
}