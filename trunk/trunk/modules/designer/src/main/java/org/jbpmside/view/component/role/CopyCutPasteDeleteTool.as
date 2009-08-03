package org.jbpmside.view.component.role
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.jbpmside.view.component.NodeComponent;
	import org.jbpmside.view.component.ConnectionComponent;
	import org.jbpmside.view.component.ShapeComponent;
	import org.jbpmside.view.component.SurfaceComponent;
	import org.jbpmside.view.component.gef.command.CommandService;
	import org.jbpmside.util.CloneUtil;
	
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
			var canMove:Boolean=selectedComponent && selectedComponent is NodeComponent && !selectedComponent.isEditable;
			switch (event.keyCode)
			{
				case Keyboard.DELETE:
					deleteComponent(selectedComponent);
					break;
				case Keyboard.RIGHT:
					if (canMove)
					{
						selectedComponent.x++;
						(selectedComponent as NodeComponent).updateConnectionPositions();
					}
					break;
				case Keyboard.LEFT:
					if (canMove)
					{
						selectedComponent.x--;
						(selectedComponent as NodeComponent).updateConnectionPositions();
					}
					break;
				case Keyboard.UP:
					if (canMove)
					{
						selectedComponent.y--;
						(selectedComponent as NodeComponent).updateConnectionPositions();
					}
					break;
				case Keyboard.DOWN:
					if (canMove)
					{
						selectedComponent.y++;
						(selectedComponent as NodeComponent).updateConnectionPositions();
					}
					break;
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
						pasteComponent(selectedComponent);
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
		
		private function copyComponent(selectedComponent:ShapeComponent):void{
			theModel.isCut=false;
			if (selectedComponent is NodeComponent)
			{
				theModel.copyOrCutComponent=CloneUtil.CloneNodeComponent(selectedComponent as NodeComponent);
			}
		}
		
		private function cutComponent(selectedComponent:ShapeComponent):void{
			theModel.isCut=true;
			if (selectedComponent is NodeComponent)
			{
				var surfaceComponent:SurfaceComponent=this.editor.graphicViewer as SurfaceComponent;
				theModel.copyOrCutComponent=CloneUtil.CloneNodeComponent(selectedComponent as NodeComponent);
				surfaceComponent.removeNodeComponent(selectedComponent as NodeComponent);
				selectedComponent.destory();
				surfaceComponent.clearSelection();
			}
		}
		
		private function pasteComponent(selectedComponent:ShapeComponent):void{
			//			var copyOrCutComponent:ShapeComponent=theModel.copyOrCutComponent;
//			if (copyOrCutComponent != null)
//			{
//				if (theModel.isCut)
//				{
//					theModel.copyOrCutComponent=null;
//				}
//				if (copyOrCutComponent is NodeComponent)
//				{
//					var pasteComponent:NodeComponent=CloneUtil.CloneNodeComponent(copyOrCutComponent as NodeComponent);
//					addNode(pasteComponent, pasteComponent.x + 10, pasteComponent.y + 10);
//					copyOrCutComponent.x=pasteComponent.x;
//					copyOrCutComponent.y=pasteComponent.y;
//					pasteComponent.selected();
//				}
//			}
		}
		
		private function deleteComponent(selectedComponent:ShapeComponent):void{
			var surfaceComponent:SurfaceComponent=this.editor.graphicViewer as SurfaceComponent;
			if (selectedComponent is NodeComponent)
			{
				surfaceComponent.removeNodeComponent(selectedComponent as NodeComponent);
			}
			else
			{
				surfaceComponent.removeConnectionComponent(selectedComponent as ConnectionComponent);
			}
			selectedComponent.destory();
			surfaceComponent.clearSelection();
			theModel.copyOrCutComponent=null;
		}
		
		private function undo():void{
			CommandService.getInstance().undo();
		}
	}
}