package org.jbpmside.xml
/**
 * @author ronghao
 */
{
	import org.jbpmside.model.CommonObject;
	import org.jbpmside.model.ProcessModel;
	
	public class Parse
	{
		private var parser:Parser;
		private var xml:XML;
		private var processModel:ProcessModel;
		private var currentModel:CommonObject;
		
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
		
		public function setProcessModel(processModel:ProcessModel):void{
			this.processModel=processModel;
		}
		
		public function getProcessModel():ProcessModel{
			return this.processModel;
		}
		
		public function setCurrentModel(currentModel:CommonObject):void{
			this.currentModel=currentModel;
		}
		
		public function getCurrentModel():CommonObject{
			return this.currentModel;
		}

	}
}