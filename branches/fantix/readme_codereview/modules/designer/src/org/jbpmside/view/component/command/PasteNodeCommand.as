package org.jbpmside.view.component.command
{
	import org.jbpmside.util.CloneUtil;
	import org.jbpmside.view.component.NodeComponent;
	import org.jbpmside.model.NodeModel;
	
	public class PasteNodeCommand extends CreateNodeBackUpCommand
	{
		public function PasteNodeCommand(copyOrCutModel:NodeModel)
		{
			initPastedNode(copyOrCutModel);
		}
		
		public function initPastedNode(copyOrCutModel:NodeModel):void
		{
			this.createNodeModel=CloneUtil.CloneNodeModel(copyOrCutModel);
			createNodeComponent=this.editor.editPartFactory.createEditPart(createNodeModel) as NodeComponent;
			//每次向下偏移一点点
			createNodeModel.x = createNodeModel.x+15;
			createNodeModel.y = createNodeModel.y+15;
			copyOrCutModel.x=createNodeModel.x;
			copyOrCutModel.y=createNodeModel.y;
			createNodeModel.name = createNodeModel.name+ uniqueNum;
			
			createNodeComponent.model=createNodeModel;
			createNodeComponent.x=createNodeModel.x;
			createNodeComponent.y=createNodeModel.y;
			uniqueNum ++;
		}

	}
}