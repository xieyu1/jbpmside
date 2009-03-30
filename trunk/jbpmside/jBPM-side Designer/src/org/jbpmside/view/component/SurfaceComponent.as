package org.jbpmside.view.component
{
	import com.degrafa.GeometryGroup;
	import com.degrafa.Surface;
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
	import mx.events.FlexEvent;
	
	import org.jbpmside.dao.DaoFactory;
	import org.jbpmside.event.CustomEvent;
	import org.jbpmside.model.TheModel;
	import org.jbpmside.util.CloneUtil;
	import org.jbpmside.view.component.node.EndComponent;
	import org.jbpmside.view.component.node.ForkComponent;
	import org.jbpmside.view.component.node.JoinComponent;
	import org.jbpmside.view.component.node.StartComponent;
	import org.jbpmside.view.component.node.TaskComponent;
	
	public class SurfaceComponent extends Surface
	{
		
		private var model:TheModel = TheModel.getInstance();
		private var daoFactory:DaoFactory = DaoFactory.getInstance();
		
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
		private var _links:ArrayCollection = new ArrayCollection();
        private var _nodes:ArrayCollection = new ArrayCollection();
        private var _selectedComponent:ShapeComponent;
        
		public function SurfaceComponent()
		{
			addEventListeners();
		}
		
		private function addEventListeners():void{
			addEventListener(MouseEvent.CLICK,mouseClickHandler);
			model.addEventListener(TheModel.ADD_CONNECTION, addConnection);
			model.addEventListener(TheModel.KEYBOARD_EVENT, keyDownEventHandler);
			model.addEventListener(TheModel.CHANGE_SHOW_GRID_EVENT, changeShowGrid);
			model.addEventListener(TheModel.CHANGE_ZOOM_EVENT, changeScale);
			//copy\cut\paste\delete
			model.addEventListener(TheModel.COPY_EVENT, copyComponent);
			model.addEventListener(TheModel.CUT_EVENT, cutComponent);
			model.addEventListener(TheModel.PASTE_EVENT, pasteComponent);
			model.addEventListener(TheModel.DELETE_EVENT, deleteComponent);
			addEventListener(FlexEvent.INITIALIZE, init);
		}
		
		private function init(event:FlexEvent):void
        {   
        	this.height=Application.application.height*2;
        	this.width=Application.application.width*2; 
        	drawCanvasRectangle();                                                 	
        	drawCanvasLines();
        }
        
        private function drawCanvasRectangle():void{
        	var fill:SolidFill = new SolidFill();
        	fill.color="0xFFFFFF";
        	fill.alpha=1;
        	
        	_rectangleGroup = new GeometryGroup();
        	_rectangleGroup.target = this;
        	this.graphicsCollection.addItem(_rectangleGroup);
        	
        	_rectangle = new RegularRectangle(this.x,this.y,this.width,this.height);
        	_rectangle.fill=fill;
        	
        	_rectangleGroup.geometryCollection.addItem(_rectangle);
        	_rectangleGroup.draw(null,null);
        }
        
        private function drawCanvasLines():void{
        	var stroke:SolidStroke = new SolidStroke();
			stroke.color = 0;
			stroke.alpha = 0.2;
			stroke.weight = 1;

			_lineGroup = new GeometryGroup();
			_lineGroup.target = this;
			this.graphicsCollection.addItem(_lineGroup);
			
			_lineGroup.addEventListener(MouseEvent.CLICK,mouseClickHandler);
				
			_hlines = new HorizontalLineRepeater();
			_hlines.stroke=stroke;
			_hlines.count=this.height/20+1;
	        _hlines.x=0;
	        _hlines.y=0;
	        _hlines.x1=this.width;
	        _hlines.moveOffsetX=0;
	        _hlines.moveOffsetY=20;
	        
	        _vlines = new VerticalLineRepeater();
	        _vlines.stroke=stroke;
	        _vlines.count=this.width/20;
	        _vlines.x=0;
	        _vlines.y=0;
	        _vlines.y1=this.height;
	        _vlines.moveOffsetY=0;
	        _vlines.moveOffsetX=20;
	        
			_lineGroup.geometryCollection.addItem(_hlines);
			_lineGroup.geometryCollection.addItem(_vlines);
			_lineGroup.draw(null,null);
        }
        
        //####################################################
		//	画板原生事件的处理器
		//####################################################	
		
		public function mouseClickHandler(event:MouseEvent):void{
			var selectedMode:int = model.selectedMode;
			var compX:Number = (event.stageX-this.x)/this.scaleX;
			var compY:Number = (event.stageY-this.y)/this.scaleY;
			var nodeComponent:NodeComponent;
			if(selectedMode==TheModel.SELECTED_START_NODE){
				nodeComponent = new StartComponent();
			}
			else if(selectedMode==TheModel.SELECTED_TASK_NODE){
				nodeComponent = new TaskComponent();
			}
			else if(selectedMode==TheModel.SELECTED_FORK_NODE){
				nodeComponent = new ForkComponent();
			}
			else if(selectedMode==TheModel.SELECTED_JOIN_NODE){
				nodeComponent = new JoinComponent();
			}
			else if(selectedMode==TheModel.SELECTED_END_NODE){
				nodeComponent = new EndComponent();
			}
			else{
				selectedComponent=null;
			}
			if(nodeComponent!=null){
				addNode(nodeComponent,compX,compY);
			}
		}
		
		public function keyDownEventHandler(customEvent:CustomEvent):void{
			var event:KeyboardEvent=customEvent.data as KeyboardEvent;  
			var canMove:Boolean=  _selectedComponent && _selectedComponent is NodeComponent && !_selectedComponent.isEditable;          
                switch( event.keyCode )
                {
                    case Keyboard.DELETE:
                        deleteComponent(customEvent);
                        break;
                        
                    case Keyboard.RIGHT:
                        if( canMove){
                            _selectedComponent.x++;
                            (_selectedComponent as NodeComponent).updateConnectionPositions();
                        }
                        break;
                    case Keyboard.LEFT:
                        if(canMove){
                            _selectedComponent.x--;
                            (_selectedComponent as NodeComponent).updateConnectionPositions();
                        }
                        break;
                    case Keyboard.UP:
                        if(canMove){
                            _selectedComponent.y--;
                            (_selectedComponent as NodeComponent).updateConnectionPositions();
                        }
                        break;
                    case Keyboard.DOWN:
                        if(canMove){
                            _selectedComponent.y++;
                            (_selectedComponent as NodeComponent).updateConnectionPositions();
                        }
                        break;
                }
//                
                switch( event.charCode )
                {
                    case 67: // C
                    case 99: // c
                        if( event.ctrlKey )
                            copyComponent(customEvent);
                        break;
                        
                    case 88: // X
                    case 120: // x
                        if( event.ctrlKey )
                            cutComponent(customEvent);
                        break;
                        
                    case 86: // V
                    case 118: // v
                        if( event.ctrlKey )
                            pasteComponent(customEvent);
                        break;
                }
		}
		
		private function addNode(node:NodeComponent,x:Number,y:Number):void{
			node.target = this;
			node.x=x;
			node.y=y;
			this.graphicsCollection.addItem(node);
			this._nodes.addItem(node);
			node.canvas=this;
			daoFactory.toolBarDAO.changeSelectedMode(TheModel.SELECTED_NONE);	
		}
		
		private function addConnection(event:CustomEvent):void{
			var fromNode:NodeComponent=this._selectedComponent as NodeComponent;
			var toNode:NodeComponent=event.data as NodeComponent;
			var connection:ConnectionComponent=new ConnectionComponent(fromNode,toNode);
			connection.target=this;
			this.graphicsCollection.addItem(connection);
			this._links.addItem(connection);
			connection.canvas=this;
			connection.selected();
			daoFactory.toolBarDAO.changeSelectedMode(TheModel.SELECTED_NONE);
		}
		
		private function changeShowGrid(event:CustomEvent):void{
			if(model.showGrid){
				_lineGroup.geometryCollection.addItem(_hlines);
				_lineGroup.geometryCollection.addItem(_vlines);
			}else{
				_lineGroup.geometryCollection.removeItem(_hlines);
				_lineGroup.geometryCollection.removeItem(_vlines);
			}
		}
		
		private function changeScale(event:CustomEvent):void{
			var zoomRatio=model.zoomRatio;
			this.scaleX=this.scaleY=zoomRatio;
			updateCanvasLines();
		}
		
		public function updateCanvasLines():void{
        	_hlines.x = -this.x/this.scaleX;
        	_hlines.y = (-(this.y-(this.y-(int(this.y/(20*this.scaleY))*(20*this.scaleY)))))/this.scaleY;
        	if(this.scaleX>=1){
	        	_hlines.x1 = _hlines.x+(Application.application.width*2*this.scaleX);
	        	_hlines.count = (Application.application.height*2*this.scaleX)/20;
        	}else{
	        	_hlines.x1 = _hlines.x+(Application.application.width*2/this.scaleX);
	        	_hlines.count = (Application.application.height*2/this.scaleX)/20;
        		
        	}
        	
        	_vlines.y = -this.y/this.scaleY;
        	_vlines.x = (-(this.x-(this.x-(int(this.x/(20*this.scaleX))*(20*this.scaleX)))))/this.scaleX;
        	if(this.scaleY>=1){
	        	_vlines.y1 = _vlines.y+(Application.application.height*2*this.scaleY);
	        	_vlines.count = (Application.application.width*2*this.scaleY)/20;
        	}else{
	        	_vlines.y1 = _vlines.y+(Application.application.height*2/this.scaleY);
	        	_vlines.count = (Application.application.width*2/this.scaleY)/20;
        	}
        	
        	_lineGroup.draw(null,null);
        }
        
       //####################################################
		//	copy\cut\paste\delete
		//####################################################	
		
		private function copyComponent(event:CustomEvent):void{
			model.isCut=false;
			if(_selectedComponent!=null){
				if(_selectedComponent is NodeComponent){
					model.copyOrCutComponent=CloneUtil.CloneNodeComponent(_selectedComponent as NodeComponent);
				}
			}
		}
		
		private function cutComponent(event:CustomEvent):void{
			model.isCut=true;
			if(_selectedComponent!=null){
				if(_selectedComponent is NodeComponent){
					model.copyOrCutComponent=CloneUtil.CloneNodeComponent(_selectedComponent as NodeComponent);
					removeNode(_selectedComponent as NodeComponent);
					_selectedComponent.destory();
					_selectedComponent=null;
				}
			}
		}
		
		private function deleteComponent(event:CustomEvent):void{
			if(_selectedComponent!=null){
				if(_selectedComponent is NodeComponent){
					removeNode(_selectedComponent as NodeComponent);
				}else{
					removeConnection(_selectedComponent as ConnectionComponent);
				}
				_selectedComponent.destory();
				_selectedComponent=null;
				model.copyOrCutComponent=null;
			}
		}
		
		private function pasteComponent(event:CustomEvent):void{
			var copyOrCutComponent:ShapeComponent=model.copyOrCutComponent;
			if(copyOrCutComponent!=null){
				if(model.isCut){
					model.copyOrCutComponent=null;
				}
				if(copyOrCutComponent is NodeComponent){
					var pasteComponent:NodeComponent=CloneUtil.CloneNodeComponent(copyOrCutComponent as NodeComponent);
					addNode(pasteComponent,pasteComponent.x+10,pasteComponent.y+10);
					copyOrCutComponent.x=pasteComponent.x;
					copyOrCutComponent.y=pasteComponent.y;
					pasteComponent.selected();
				}
			}
		}
		//####################################################
		//	getter/setter
		//####################################################	
		
		public function set selectedComponent(selectedComponent:ShapeComponent):void{
			if(this._selectedComponent!=null && this._selectedComponent!=selectedComponent){
				this._selectedComponent.unSelected();
			}
			this._selectedComponent=selectedComponent;
		}
		
		public function get selectedComponent():ShapeComponent{
			return this._selectedComponent;
		}
		
		public function removeNode(node:NodeComponent):void{
			this._nodes.removeItemAt(this._nodes.getItemIndex(node));
			removeChild(node);
		}
		
		public function removeConnection(connection:ConnectionComponent):void{
			this._links.removeItemAt(this._links.getItemIndex(connection));
			removeChild(connection);
		}

	}
}