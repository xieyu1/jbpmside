package org.jbpmside.xml
/**
 * @author ronghao
 */
{
	import org.jbpmside.model.common.DefaultContainer;
	import org.jbpmside.model.jpdl4.ProcessDefinition;
	
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
				var name:String=xml.@name;
				processDefinition.setName(name);
				
				var key:String=xml.@key;
				processDefinition.setKey(key);
				
				trace(xml.name());
				
				
			}catch(e:ReferenceError){
				
			}
		}
		
		private function parseActivities(xml:XML,parse:Parse,nodeContainer:DefaultContainer):void{
//			xml.
		} 
		
		public function getBinding(elementXml:XML,category:String):Binding{
			return bindings.getBinding(elementXml,category);
		}
	}
}