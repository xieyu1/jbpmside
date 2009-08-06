package org.jbpmside.xml.binding
{
	import org.jbpmside.xml.Parse;
	import org.jbpmside.xml.Parser;
	
	public class StartBinding extends JpdlBinding
	{
		public function StartBinding()
		{
			super("start");
		}
		
		public override function parse(elementXml:XML,parse:Parse,parser:Parser):Object{
			return null;
		}

	}
}