package org.jbpmside.util
{
	import org.jbpmside.view.component.NodeComponent;
	import org.jbpmside.view.component.node.EndComponent;
	import org.jbpmside.view.component.node.ForkComponent;
	import org.jbpmside.view.component.node.JoinComponent;
	import org.jbpmside.view.component.node.StartComponent;
	import org.jbpmside.view.component.node.TaskComponent;
	
	public class CloneUtil
	{
		public static function CloneNodeComponent(source:NodeComponent):NodeComponent{
			var cloneNodeComponent:NodeComponent;
			if(source is StartComponent){
				cloneNodeComponent=new StartComponent();	
			}else if(source is TaskComponent){
				cloneNodeComponent=new TaskComponent();	
			}else if(source is ForkComponent){
				cloneNodeComponent=new ForkComponent();	
			}else if(source is JoinComponent){
				cloneNodeComponent=new JoinComponent();	
			}else{
				cloneNodeComponent=new EndComponent();	
			}
			cloneNodeComponent.x=source.x;
			cloneNodeComponent.y=source.y;
			cloneNodeComponent.labelName=source.labelField.text;
			return cloneNodeComponent;
		}

	}
}