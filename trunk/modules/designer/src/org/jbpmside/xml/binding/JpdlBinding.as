package org.jbpmside.xml.binding
{
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
			return null;
		}	

	}
}