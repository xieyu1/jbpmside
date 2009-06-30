package org.jbpmside.view.component

{
	import com.degrafa.GeometryGroup;
	import com.degrafa.geometry.RegularRectangle;
	import com.degrafa.geometry.repeaters.HorizontalLineRepeater;
	import com.degrafa.geometry.repeaters.VerticalLineRepeater;
	import com.degrafa.paint.SolidFill;
	import com.degrafa.paint.SolidStroke;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	
	import org.jbpmside.dao.DaoFactory;
	import org.jbpmside.event.CustomEvent;
	import org.jbpmside.model.ConnectionModel;
	import org.jbpmside.model.NodeModel;
	import org.jbpmside.model.ProcessModel;
	import org.jbpmside.model.TheModel;
	import org.jbpmside.util.CloneUtil;
	import org.jbpmside.view.component.gef.GraphicViewer;
	import org.jbpmside.view.component.gef.IEditPart;

	public class SurfaceComponent extends GraphicViewer
	{

		private var theModel:TheModel=TheModel.getInstance();
		private var daoFactory:DaoFactory=DaoFactory.getInstance();

		//####################################################
		// 加一层RegularRectangle使得可以监听画板事件
		//####################################################
		private var _rectangleGroup:GeometryGroup;
		private var _rectangle:RegularRectangle;

		//####################################################
		//	画板的方格线
		//####################################################	
		private var _lineGroup:GeometryGroup;
		private var _hlines:HorizontalLineRepeater;
		private var _vlines:VerticalLineRepeater;

		//####################################################
		// 保存加入画板的组件
		//####################################################
		private var _links:ArrayCollection=new ArrayCollection();
		private var _nodes:ArrayCollection=new ArrayCollection();
		private var _selectedComponent:ShapeComponent;


		public function SurfaceComponent()
		{
			super();
			addEventListeners();
		}

		private function addEventListeners():void
		{
			addEventListener(MouseEvent.CLICK, mouseClickHandler);

			theModel.addEventListener(TheModel.KEYBOARD_EVENT, keyDownEventHandler);
			theModel.addEventListener(TheModel.CHANGE_SHOW_GRID_EVENT, changeShowGrid);
			theModel.addEventListener(TheModel.CHANGE_ZOOM_EVENT, changeScale);
			//copy\cut\paste\delete
			theModel.addEventListener(TheModel.COPY_EVENT, copyComponent);
			theModel.addEventListener(TheModel.CUT_EVENT, cutComponent);
			theModel.addEventListener(TheModel.PASTE_EVENT, pasteComponent);
			theModel.addEventListener(TheModel.DELETE_EVENT, deleteComponent);
//			addEventListener(FlexEvent.INITIALIZE, init);
		}

		override public function createControl():void
		{
			this.height=Application.application.height * 2;
			this.width=Application.application.width * 2;
			drawCanvasRectangle();
			drawCanvasLines();
			refreshChildren();
		}

		override public function set model(_model:Object):void
		{
			this._model=_model;
			//node collection changed
			theModel.addEventListener(TheModel.NODE_COLLECTION_CHANGE_EVENT, onNodeCollectionChanged);
		}
		
		override public function clearSelection():void{
			if(_selectedComponent){
				this._selectedComponent.unSelected();
			}
			
		}

		override public function getModelChildren():ArrayCollection
		{
			var nodeCollection:ArrayCollection=ProcessModel(model).nodeCollection;
			var linkCollection:ArrayCollection=new ArrayCollection();
			var array:ArrayCollection=new ArrayCollection();
			for each (var nodeModel:NodeModel in nodeCollection)
			{
				if (nodeModel.sourceTransitions.length > 0)
				{
					for each (var linkModel:ConnectionModel in nodeModel.sourceTransitions)
					{
						array.addItem(linkModel);
					}
				}
				array.addItem(nodeModel);
			}

			return array;

		}

		override protected function refreshChildren():void
		{

			var objCollection:ArrayCollection=getModelChildren();
			//refresh node editpart
			for each (var obj:Object in objCollection)
			{
				var isExist:Boolean=false;
				for each (var child1:Object in this._nodes)
				{
					if (ShapeComponent(child1).model == obj)
					{
						isExist=true
						break;
					}
				}
				if (isExist)
				{
					continue;
				}
				var editPart:IEditPart=ProcessEditor.getEditor().editPartFactory.createEditPart(obj);
				if (editPart is NodeComponent)
				{
					var nodeEditPart:NodeComponent=editPart as NodeComponent;
					var nodeModel:NodeModel=obj as NodeModel;
					nodeEditPart.model=nodeModel;
					nodeEditPart.x=nodeModel.x;
					nodeEditPart.y=nodeModel.y;
					nodeEditPart.labelName=nodeModel.name;
					this.graphicsCollection.addItem(nodeEditPart);
					this._nodes.addItem(nodeEditPart);
					nodeEditPart.canvas=this;
					nodeEditPart.target=this;
				}
			}
			//refresh connection editpart
			for each (var nodePart:NodeComponent in this._nodes)
			{
				if (nodePart.getModelSourceConnections().length > 0)
				{
					for each (var connectionModel:ConnectionModel in nodePart.getModelSourceConnections())
					{
						var isExist1:Boolean=false;
						for each (var child2:Object in this._links)
						{
							if (ShapeComponent(child2).model == connectionModel)
							{
								isExist1=true
								break;
							}
						}
						if (isExist1)
						{
							continue;
						}
						var connectionEditPart:ConnectionComponent=ProcessEditor.getEditor().editPartFactory.createEditPart(connectionModel) as ConnectionComponent;
						connectionEditPart.model = connectionModel;
						connectionEditPart.fromNode=nodePart;
						connectionEditPart.toNode=this.getNodeEditPartByName(connectionModel.toNode);
						connectionEditPart.target=this;
						this.graphicsCollection.addItem(connectionEditPart);
						this._links.addItem(connectionEditPart);
						connectionEditPart.canvas=this;
						connectionEditPart.refreshPosition();
					}
				}
			}


		}

		public function getNodeEditPartByName(name:String):NodeComponent
		{
			for each (var nodeEditPart:NodeComponent in this._nodes)
			{
				if (nodeEditPart.labelName == name)
				{
					return nodeEditPart;
				}
			}
			return null;
		}

		private function drawCanvasRectangle():void
		{
			var fill:SolidFill=new SolidFill();
			fill.color="0xFFFFFF";
			fill.alpha=1;

			_rectangleGroup=new GeometryGroup();
			_rectangleGroup.target=this;
			this.graphicsCollection.addItem(_rectangleGroup);

			_rectangle=new RegularRectangle(this.x, this.y, this.width, this.height);
			_rectangle.fill=fill;

			_rectangleGroup.geometryCollection.addItem(_rectangle);
			_rectangleGroup.draw(null, null);
		}

		private function drawCanvasLines():void
		{
			var stroke:SolidStroke=new SolidStroke();
			stroke.color=0;
			stroke.alpha=0.2;
			stroke.weight=1;

			_lineGroup=new GeometryGroup();
			_lineGroup.target=this;
			this.graphicsCollection.addItem(_lineGroup);

			_lineGroup.addEventListener(MouseEvent.CLICK, mouseClickHandler);

			_hlines=new HorizontalLineRepeater();
			_hlines.stroke=stroke;
			_hlines.count=this.height / 20 + 1;
			_hlines.x=0;
			_hlines.y=0;
			_hlines.x1=this.width;
			_hlines.moveOffsetX=0;
			_hlines.moveOffsetY=20;

			_vlines=new VerticalLineRepeater();
			_vlines.stroke=stroke;
			_vlines.count=this.width / 20;
			_vlines.x=0;
			_vlines.y=0;
			_vlines.y1=this.height;
			_vlines.moveOffsetY=0;
			_vlines.moveOffsetX=20;

			_lineGroup.geometryCollection.addItem(_hlines);
			_lineGroup.geometryCollection.addItem(_vlines);
			_lineGroup.draw(null, null);
		}

		//####################################################
		//	画板原生事件的处理器
		//####################################################	

		public function mouseClickHandler(event:MouseEvent):void
		{
			var compX:Number=(event.stageX - this.x) / this.scaleX;
			var compY:Number=(event.stageY - this.y) / this.scaleY;
			this.tool.mouseClick(event, compX, compY);
			this.toolDone();
		}

		public function keyDownEventHandler(customEvent:CustomEvent):void
		{
			var event:KeyboardEvent=customEvent.data as KeyboardEvent;
			var canMove:Boolean=_selectedComponent && _selectedComponent is NodeComponent && !_selectedComponent.isEditable;
			switch (event.keyCode)
			{
				case Keyboard.DELETE:
					deleteComponent(customEvent);
					break;

				case Keyboard.RIGHT:
					if (canMove)
					{
						_selectedComponent.x++;
						(_selectedComponent as NodeComponent).updateConnectionPositions();
					}
					break;
				case Keyboard.LEFT:
					if (canMove)
					{
						_selectedComponent.x--;
						(_selectedComponent as NodeComponent).updateConnectionPositions();
					}
					break;
				case Keyboard.UP:
					if (canMove)
					{
						_selectedComponent.y--;
						(_selectedComponent as NodeComponent).updateConnectionPositions();
					}
					break;
				case Keyboard.DOWN:
					if (canMove)
					{
						_selectedComponent.y++;
						(_selectedComponent as NodeComponent).updateConnectionPositions();
					}
					break;
			}
//                
			switch (event.charCode)
			{
				case 67: // C
				case 99: // c
					if (event.ctrlKey)
						copyComponent(customEvent);
					break;

				case 88: // X
				case 120: // x
					if (event.ctrlKey)
						cutComponent(customEvent);
					break;

				case 86: // V
				case 118: // v
					if (event.ctrlKey)
						pasteComponent(customEvent);
					break;
			}
		}

		public function onNodeCollectionChanged(event:CustomEvent):void
		{
			this.refreshChildren();
		}

		private function changeShowGrid(event:CustomEvent):void
		{
			if (theModel.showGrid)
			{
				_lineGroup.geometryCollection.addItem(_hlines);
				_lineGroup.geometryCollection.addItem(_vlines);
			}
			else
			{
				_lineGroup.geometryCollection.removeItem(_hlines);
				_lineGroup.geometryCollection.removeItem(_vlines);
			}
		}

		private function changeScale(event:CustomEvent):void
		{
			var zoomRatio:Number=theModel.zoomRatio;
			this.scaleX=this.scaleY=zoomRatio;
			updateCanvasLines();
		}

		public function updateCanvasLines():void
		{
			_hlines.x=-this.x / this.scaleX;
			_hlines.y=(-(this.y - (this.y - (int(this.y / (20 * this.scaleY)) * (20 * this.scaleY))))) / this.scaleY;
			if (this.scaleX >= 1)
			{
				_hlines.x1=_hlines.x + (Application.application.width * 2 * this.scaleX);
				_hlines.count=(Application.application.height * 2 * this.scaleX) / 20;
			}
			else
			{
				_hlines.x1=_hlines.x + (Application.application.width * 2 / this.scaleX);
				_hlines.count=(Application.application.height * 2 / this.scaleX) / 20;

			}

			_vlines.y=-this.y / this.scaleY;
			_vlines.x=(-(this.x - (this.x - (int(this.x / (20 * this.scaleX)) * (20 * this.scaleX))))) / this.scaleX;
			if (this.scaleY >= 1)
			{
				_vlines.y1=_vlines.y + (Application.application.height * 2 * this.scaleY);
				_vlines.count=(Application.application.width * 2 * this.scaleY) / 20;
			}
			else
			{
				_vlines.y1=_vlines.y + (Application.application.height * 2 / this.scaleY);
				_vlines.count=(Application.application.width * 2 / this.scaleY) / 20;
			}

			_lineGroup.draw(null, null);
		}

		//####################################################
		//	copy\cut\paste\delete
		//####################################################	

		private function copyComponent(event:CustomEvent):void
		{
			theModel.isCut=false;
			if (_selectedComponent != null)
			{
				if (_selectedComponent is NodeComponent)
				{
					theModel.copyOrCutComponent=CloneUtil.CloneNodeComponent(_selectedComponent as NodeComponent);
				}
			}
		}

		private function cutComponent(event:CustomEvent):void
		{
			theModel.isCut=true;
			if (_selectedComponent != null)
			{
				if (_selectedComponent is NodeComponent)
				{
					theModel.copyOrCutComponent=CloneUtil.CloneNodeComponent(_selectedComponent as NodeComponent);
					removeNode(_selectedComponent as NodeComponent);
					_selectedComponent.destory();
					_selectedComponent=null;
				}
			}
		}

		private function deleteComponent(event:CustomEvent):void
		{
			if (_selectedComponent != null)
			{
				if (_selectedComponent is NodeComponent)
				{
					removeNode(_selectedComponent as NodeComponent);
				}
				else
				{
					removeConnection(_selectedComponent as ConnectionComponent);
				}
				_selectedComponent.destory();
				_selectedComponent=null;
				theModel.copyOrCutComponent=null;
			}
		}

		private function pasteComponent(event:CustomEvent):void
		{
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

		//####################################################
		//	getter/setter
		//####################################################	

		public function set selectedComponent(selectedComponent:ShapeComponent):void
		{
			if (this._selectedComponent != null && this._selectedComponent != selectedComponent)
			{
				this._selectedComponent.unSelected();
			}
			this._selectedComponent=selectedComponent;
		}

		public function get selectedComponent():ShapeComponent
		{
			return this._selectedComponent;
		}

		public function removeNode(node:NodeComponent):void
		{
			this._nodes.removeItemAt(this._nodes.getItemIndex(node));
			removeChild(node);
		}

		public function removeConnection(connection:ConnectionComponent):void
		{
			this._links.removeItemAt(this._links.getItemIndex(connection));
			removeChild(connection);
		}

	}
}