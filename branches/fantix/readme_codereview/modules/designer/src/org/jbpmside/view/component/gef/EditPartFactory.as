package org.jbpmside.view.component.gef
/**
 * @author liuch 2009-6-1
 */
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.jbpmside.view.component.gef.IEditPart;
	
	public class EditPartFactory
	{
		private static var modelEditPartMap:Dictionary = new Dictionary();
			modelEditPartMap["org.jbpmside.model.StartNode"] = "org.jbpmside.view.component.node.StartComponent";
			modelEditPartMap["org.jbpmside.model.TaskNode"] = "org.jbpmside.view.component.node.TaskComponent";
			modelEditPartMap["org.jbpmside.model.JoinNode"] = "org.jbpmside.view.component.node.JoinComponent";
			modelEditPartMap["org.jbpmside.model.ForkNode"] = "org.jbpmside.view.component.node.ForkComponent";
			modelEditPartMap["org.jbpmside.model.EndNode"] = "org.jbpmside.view.component.node.EndComponent";
			modelEditPartMap["org.jbpmside.model.ConnectionModel"] = "org.jbpmside.view.component.ConnectionComponent";
			
		public function EditPartFactory()
		{
		}
		
		public function createEditPart(obj:Object):IEditPart{
			var className:String=getQualifiedClassName(obj).replace("::", ".");
			var editPartClassName:String = modelEditPartMap[className];
			var ClassReference:Class = getDefinitionByName(editPartClassName) as Class;
			var editPart:IEditPart = new ClassReference() as IEditPart;
			return editPart;
		}
		

	}
}