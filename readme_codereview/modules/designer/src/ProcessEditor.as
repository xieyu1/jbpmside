package
/**
 * @author liuch 2009-6-1
 */

{
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.core.Container;
	import mx.events.FlexEvent;
	
	import org.jbpmside.event.CustomEvent;
	import org.jbpmside.model.ConnectionModel;
	import org.jbpmside.model.EndNode;
	import org.jbpmside.model.ProcessModel;
	import org.jbpmside.model.StartNode;
	import org.jbpmside.model.TaskNode;
	import org.jbpmside.model.TheModel;
	import org.jbpmside.view.ProcessCanvas;
	import org.jbpmside.view.TabNavigator;
	import org.jbpmside.view.component.SurfaceComponent;
	import org.jbpmside.view.component.gef.EditPartFactory;
	import org.jbpmside.view.component.gef.GraphicViewer;
	import org.jbpmside.view.component.gef.IGraphicalEditor;

	public class ProcessEditor extends Application implements IGraphicalEditor
	{
		private var _editPartFactory:EditPartFactory;
		
		private static var instance:ProcessDesigner;
		
		private var theModel:TheModel=TheModel.getInstance();
		
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
			addEventListeners();
		}
		
		private function addEventListeners():void
		{
			theModel.addEventListener(TheModel.KEYBOARD_EVENT, keyDownEventHandler);
			//copy\cut\paste\delete
			theModel.addEventListener(TheModel.COPY_EVENT, copyComponent);
			theModel.addEventListener(TheModel.CUT_EVENT, cutComponent);
			theModel.addEventListener(TheModel.PASTE_EVENT, pasteComponent);
			theModel.addEventListener(TheModel.DELETE_EVENT, deleteComponent);
			//menu
			theModel.addEventListener(TheModel.NEW_PROCESS, newProcess);
			theModel.addEventListener(TheModel.CLOSE_PROCESS, close);
			theModel.addEventListener(TheModel.CLOSE_ALL_PROCESSES, closeAll);
//			addEventListener(FlexEvent.INITIALIZE, init);
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
			
//			graphicViewer.model = _contentProcess;
//			graphicViewer.model = new ProcessModel();
//			graphicViewer.createControl();
			addNavigatorTab();
			
		}
		
		public function get graphicViewer():GraphicViewer{
			 var processCanvas:ProcessCanvas=currentNavigatorTab;
			 if(processCanvas!=null)
			 	return processCanvas.surface as GraphicViewer;
			 return null;
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
		
		public function keyDownEventHandler(customEvent:CustomEvent):void
		{
			SurfaceComponent(graphicViewer).keyDownEventHandler(customEvent);
		}
		
		//copy\cut\paste\delete
		public function copyComponent(customEvent:CustomEvent):void{
			SurfaceComponent(graphicViewer).copyComponent(customEvent);
		}
		
		public function cutComponent(customEvent:CustomEvent):void{
			SurfaceComponent(graphicViewer).cutComponent(customEvent);
		}
		
		public function pasteComponent(customEvent:CustomEvent):void{
			SurfaceComponent(graphicViewer).pasteComponent(customEvent);
		}
		
		public function deleteComponent(customEvent:CustomEvent):void{
			SurfaceComponent(graphicViewer).deleteComponent(customEvent);
		}
		
		//menu
		public function newProcess(customEvent:CustomEvent):void{
			addNavigatorTab();
		}
		
		public function close(customEvent:CustomEvent):void{
			closeCurrentNavigatorTab();
		}
		
		public function closeAll(customEvent:CustomEvent):void{
			closeAllNavigatorTab();
		}
		
		/**对navigator进行操作，总的入口**/
		private function addNavigatorTab(label:String=""):void{
			
			var processCanvas:ProcessCanvas=navigator.addTab(label);
			var surface:SurfaceComponent=processCanvas.surface;
			surface.model=new ProcessModel();
			surface.createControl();
		}
		
		private function closeCurrentNavigatorTab():void{
			graphicViewer.destory();
			navigator.removeChild(currentNavigatorTab);
		}
		
		private function closeAllNavigatorTab():void{
			for each(var process:ProcessCanvas in navigatorTabs){
				process.surface.destory();
			}
			navigator.removeAllChildren();
		}
		
		private function get currentNavigatorTab():ProcessCanvas{
			var processCanvas:Container=navigator.selectedChild;
			if(processCanvas!=null){
				return processCanvas as ProcessCanvas;
			}
			return null;
		}
		
		private function get navigatorTabs():ArrayCollection{
			var processCanvases:ArrayCollection=new ArrayCollection();
			var children:Array=navigator.getChildren();
			for each(var child:Object in children){
				processCanvases.addItem(child as ProcessCanvas);
			}
			return processCanvases;
		}
		
		private function get navigator():TabNavigator{
			return getEditor().tabNavigator;
		}
	}
	
	
}