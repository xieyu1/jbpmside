package org.jbpmside.xml
/**
 * @author ronghao
 */
{
	import org.jbpmside.model.ProcessModel;
	
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
			var processModel:ProcessModel=new ProcessModel();
			parse.setProcessModel(processModel);
			try{
				var name:String=xml.@name;
				processModel.name=name;
			}catch(e:ReferenceError){
				
			}
		}
		
		public function getBinding(elementXml:XML,category:String):Binding{
			return bindings.getBinding(elementXml,category);
		}
	}
}