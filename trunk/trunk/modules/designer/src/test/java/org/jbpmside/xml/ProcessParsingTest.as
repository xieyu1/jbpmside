package org.jbpmside.xml
{
	import org.jbpmside.model.ProcessModel;
	
	public class ProcessParsingTest extends JpdlParseTestCase
	{
		public function testSimplestValidProcess():void{
			var processModel:ProcessModel=parse(
			"<process name='p'>" +
      		"  <start name='s' />" +
      		"</process>");
      		assertEquals("p", processModel.name);
		}
		
	}
}