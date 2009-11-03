package org.jbpmside.xml
/**
 * @author ronghao
 */
{
	import mx.collections.ArrayCollection;
	
	import org.jbpmside.model.common.Element;
	import org.jbpmside.model.common.Flow;
	import org.jbpmside.model.jpdl4.Transition;
	
	public class Parse
	{
		private var parser:Parser;
		private var xml:XML;
		private var processDefinition:Flow;
		private var currentModel:Element;
		private var transitions:ArrayCollection=new ArrayCollection();
		
		public function Parse(parser:Parser)
		{
			this.parser=parser;
		}
		
		//####################################################
		//	specifying the input source
		//####################################################	
		
		/** specify an XML string as the source for this parse */
		public function setString(xmlString:String):Parse{
			this.xml=new XML(xmlString);
			return this;
		}
		
  		//####################################################
		//	parse execution
		//####################################################	
		
	  	/** perform the actual parse operation with the specified input source. */
	  	public function execute():Parse {
	    	parser.execute(this);
	    	return this;
	  	}
		
		//####################################################
		//	getter/setter
		//####################################################	
		
		public function getXml():XML{
			return this.xml;
		}
		
		public function setProcessDefinition(processDefinition:Flow):void{
			this.processDefinition=processDefinition;
		}
		
		public function getProcessDefinition():Flow{
			return this.processDefinition;
		}
		
		public function setCurrentModel(currentModel:Element):void{
			this.currentModel=currentModel;
		}
		
		public function getCurrentModel():Element{
			return this.currentModel;
		}
		
		public function getUnresolvedTransitions():ArrayCollection{
			return this.transitions;
		}
		
		public function addUnresolvedTransition(transition:Transition):void{
			this.transitions.addItem(transition);
		}

	}
}