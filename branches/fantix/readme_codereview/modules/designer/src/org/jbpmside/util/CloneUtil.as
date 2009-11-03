package org.jbpmside.util
/**
 * @author ronghao 2009-8-4
 */
{
	import org.jbpmside.model.NodeModel;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class CloneUtil
	{
		
		public static function CloneNodeModel(source:NodeModel):NodeModel{
			var className:String=getQualifiedClassName(source);
			var ClassReference:Class = getDefinitionByName(className) as Class;
			var cloneNode:NodeModel = new ClassReference() as NodeModel;
			//未来还是需要根据不同的节点分别copy属性
			cloneNode.x=source.x;
			cloneNode.y=source.y;
			cloneNode.name=source.name;
			return cloneNode;
		}

	}
}