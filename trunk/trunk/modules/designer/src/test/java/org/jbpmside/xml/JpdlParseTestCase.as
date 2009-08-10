package org.jbpmside.xml
/**
 * @author ronghao
 */
{
	import flexunit.framework.TestCase;
	
	import org.jbpmside.model.jpdl4.ProcessDefinition;
	
	public class JpdlParseTestCase extends TestCase
	{
		public function parse(xml:String):ProcessDefinition{
			var parser:Parser=new Parser();
			return parser.createParse().setString(xml).execute().getProcessDefinition() as ProcessDefinition;
		}
	}
}