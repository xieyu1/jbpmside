package
/**
 * @author liuch 2009-6-1
 */

{
	import mx.core.Application;
	import mx.events.FlexEvent;
	
	import org.jbpmside.model.ConnectionModel;
	import org.jbpmside.model.EndNode;
	import org.jbpmside.model.ProcessModel;
	import org.jbpmside.model.StartNode;
	import org.jbpmside.model.TaskNode;
	import org.jbpmside.model.TheModel;
	import org.jbpmside.view.component.gef.EditPartFactory;
	import org.jbpmside.view.component.gef.GraphicViewer;
	import org.jbpmside.view.component.gef.IGraphicalEditor;

	public class ProcessEditor extends Application implements IGraphicalEditor
	{
		private var _editPartFactory:EditPartFactory;
		
		private static var instance:ProcessDesigner;
		
		private var _contentProcess:ProcessModel;
		
		public function ProcessEditor()
		{
			//TODO: implement function
			super();
			initEditor();
		}
		
		public function initEditor():void{
			addEventListener(FlexEvent.CREATION_COMPLETE,initGraphicViewer);
			_editPartFactory = new EditPartFactory();
		}
		
		private function initGraphicViewer(event:FlexEvent):void{
			
			_contentProcess = new ProcessModel();
			var endNode:EndNode = new EndNode(); 
			endNode.x = 900;
			endNode.y = 300;
			endNode.name = "end";
			_contentProcess.addNode(endNode);
			
			var taskNode:TaskNode = new TaskNode(); 
			taskNode.x = 500;
			taskNode.y = 300;
			taskNode.name = "task";
			_contentProcess.addNode(taskNode);
			var transition2:ConnectionModel = new ConnectionModel();
			transition2.name = "to end";
			taskNode.addSourceTransition(transition2);
			endNode.addTargetTransition(transition2);
			
			var startNode:StartNode = new StartNode(); 
			startNode.x = 100;
			startNode.y = 300;
			startNode.name = "start";
			_contentProcess.addNode(startNode);
			var transition1:ConnectionModel = new ConnectionModel();
			transition1.name = "to task";
			startNode.addSourceTransition(transition1);
			taskNode.addTargetTransition(transition1);
			
			graphicViewer.model = _contentProcess;
			graphicViewer.createControl();
			
			
		}
		
		public function get graphicViewer():GraphicViewer{
			 return getEditor().surface;
		}
		
		public function get editPartFactory():EditPartFactory{
			return _editPartFactory;
		}
		
		public function set editPartFactory(_editPartFactory:EditPartFactory):void{
			this._editPartFactory = _editPartFactory;
		}
		
		public function get contentProcess():ProcessModel{
			return _contentProcess;
		}
		
		public function set contentProcess(_contentProcess:ProcessModel):void{
			this._contentProcess = _contentProcess;
		}
		
		public static function getEditor():ProcessDesigner{
			if(!instance){
				instance = ProcessDesigner(Application.application);
			}
			return instance;
		}
		
	}
	
	
}