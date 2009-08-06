package org.jbpmside.xml
/**
 * @author ronghao
 */
{
	import flexunit.framework.TestCase;
	
	import org.jbpmside.model.ProcessModel;
	
	public class JpdlParseTestCase extends TestCase
	{
		public function parse(xml:String):ProcessModel{
			var parser:Parser=new Parser();
			return parser.createParse().setString(xml).execute().getProcessModel();
		}
	}
}