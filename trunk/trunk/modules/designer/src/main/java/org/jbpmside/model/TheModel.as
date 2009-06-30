package org.jbpmside.model
{
	import flash.events.EventDispatcher;
	
	import org.jbpmside.view.component.ShapeComponent;
	
	[Bindable]
	public class TheModel extends EventDispatcher
	{
		//####################################################
		//	bindable properties
		//####################################################	
		public var selectedMode:int=SELECTED_NONE;
		public var showGrid:Boolean=true;
		public var alignToGrid:Boolean=false;
		public var zoomRatio:Number=1;
		public var copyOrCutComponent:ShapeComponent;
		public var isCut:Boolean=false;
		
		//####################################################
		//	data constants
		//####################################################	
		public static const SELECTED_NONE:int=0;
		public static const SELECTED_TRANSITION:int=1;
		public static const SELECTED_START_NODE:int=2;
		public static const SELECTED_TASK_NODE:int=3;
		public static const SELECTED_FORK_NODE:int=4;
		public static const SELECTED_JOIN_NODE:int=5;
		public static const SELECTED_END_NODE:int=6;
		
		//####################################################
		//	event constants
		//####################################################	
		public static const SELECTED_MODE_CHANGED:String="selectedModeChanged";
		public static const ADD_CONNECTION:String="addConnection";
		public static const KEYBOARD_EVENT:String="keyboardEvent";
		public static const CHANGE_SHOW_GRID_EVENT:String="changeShowGridEvent";
		public static const CHANGE_ZOOM_EVENT:String="changeZoomEvent";
		//copy\cut\paste\delete
		public static const DELETE_EVENT:String="deleteEvent";
		public static const COPY_EVENT:String="copyEvent";
		public static const CUT_EVENT:String="cutEvent";
		public static const PASTE_EVENT:String="pasteEvent";
		public static const NODE_COLLECTION_CHANGE_EVENT:String="node collection change event";


		//####################################################
		//	shared utility methods
		//####################################################	
		
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean=false, 
														priority:int=0, useWeakReference:Boolean=true):void {
			super.addEventListener(type,listener,useCapture,priority,true);
		}
		
		//####################################################
		//	singleton
		//####################################################	
		
		public function TheModel(){

		}
		
		private static var _instance:TheModel
		
		public static function getInstance():TheModel{
			if( !_instance ){
				_instance = new TheModel();
			}
			return _instance;
		}

	}
}