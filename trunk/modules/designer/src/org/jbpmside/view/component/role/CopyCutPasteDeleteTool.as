package org.jbpmside.view.component.role
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.jbpmside.model.NodeModel;
	import org.jbpmside.util.CloneUtil;
	import org.jbpmside.view.component.ConnectionComponent;
	import org.jbpmside.view.component.NodeComponent;
	import org.jbpmside.view.component.ShapeComponent;
	import org.jbpmside.view.component.SurfaceComponent;
	import org.jbpmside.view.component.command.CutNodeCommand;
	import org.jbpmside.view.component.command.PasteNodeCommand;
	import org.jbpmside.view.component.command.DeleteConnectionCommand;
	import org.jbpmside.view.component.command.DeleteNodeCommand;
	import org.jbpmside.view.component.gef.command.Command;
	import org.jbpmside.view.component.gef.command.CommandService;
	
	public class CopyCutPasteDeleteTool extends AbstractTool
	{
		public function CopyCutPasteDeleteTool()
		{
			super();
		}
		
		public override function keyDown(event:KeyboardEvent, key:int):void
		{
			var surfaceComponent:SurfaceComponent=this.editor.graphicViewer as SurfaceComponent;
			var selectedComponent:ShapeComponent=surfaceComponent.selectedComponent;
			var canMove:Boolean=selectedComponent && selectedComponent is NodeComponent;
			switch (event.keyCode)
			{
				case Keyboard.DELETE:
					deleteComponent(selectedComponent);
					break;
//				case Keyboard.RIGHT:
//					if (canMove)
//					{
//						selectedComponent.x++;
//						(selectedComponent as NodeComponent).updateConnectionPositions();
//					}
//					break;
//				case Keyboard.LEFT:
//					if (canMove)
//					{
//						selectedComponent.x--;
//						(selectedComponent as NodeComponent).updateConnectionPositions();
//					}
//					break;
//				case Keyboard.UP:
//					if (canMove)
//					{
//						selectedComponent.y--;
//						(selectedComponent as NodeComponent).updateConnectionPositions();
//					}
//					break;
//				case Keyboard.DOWN:
//					if (canMove)
//					{
//						selectedComponent.y++;
//						(selectedComponent as NodeComponent).updateConnectionPositions();
//					}
//					break;
			}              
			switch (event.charCode)
			{
				case 67: // C
				case 99: // c
					if (event.ctrlKey)
						copyComponent(selectedComponent);
					break;

				case 88: // X
				case 120: // x
					if (event.ctrlKey)
						cutComponent(selectedComponent);
					break;

				case 86: // V
				case 118: // v
					if (event.ctrlKey)
						pasteComponent();
					break;
					
				case 90: // Z
				case 122: // z
					if (event.ctrlKey)
						undo();
					break;
			}
		}
		
		//####################################################
		//	copy\cut\paste\delete
		//####################################################	
		
		public function copyComponent(selectedComponent:ShapeComponent):void{
			theModel.isCut=false;
			if (selectedComponent is NodeComponent)
			{
				theModel.copyOrCutModel=CloneUtil.CloneNodeModel(selectedComponent.model as NodeModel);
			}
		}
		
		public function cutComponent(selectedComponent:ShapeComponent):void{
			if (selectedComponent is NodeComponent)
			{
				var cmd:Command=new CutNodeCommand(selectedComponent as NodeComponent);
				CommandService.getInstance().execute(cmd);
			}
		}
		
		public function pasteComponent():void{
			var copyOrCutModel:NodeModel=theModel.copyOrCutModel;
			if (copyOrCutModel != null)
			{
				if (theModel.isCut)
				{
					theModel.copyOrCutModel=null;
				}

				var cmd:Command=new PasteNodeCommand(copyOrCutModel);
				CommandService.getInstance().execute(cmd);
			}
		}
		
		public function deleteComponent(selectedComponent:ShapeComponent):void{
			var cmd:Command;
			if (selectedComponent is NodeComponent)
			{
				cmd=new DeleteNodeCommand(selectedComponent as NodeComponent);
			}
			else if (selectedComponent is ConnectionComponent)
			{
				cmd=new DeleteConnectionCommand(selectedComponent as ConnectionComponent);
			}
			CommandService.getInstance().execute(cmd);
			theModel.copyOrCutModel=null;
		}
		
		public function undo():void{
			CommandService.getInstance().undo();
		}
	}
}