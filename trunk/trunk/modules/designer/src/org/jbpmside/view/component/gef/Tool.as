package org.jbpmside.view.component.gef
/**
 * @author liuch 2009-6-1
 */
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import mx.events.DragEvent;
	

	public interface Tool
	{
		function get type():int;
		
		function set type(_type:int):void;
		
		/**
		 * An active tool is the currently selected tool in the
		 * DrawingView. A tool can be activated/deactivated
		 * by calling the activate()/deactivate() method.
		 *
		 * @return true if the tool is the selected tool in the DrawingView, false otherwise
		 * @see #isEnabled
		 * @see #isUsable
		 */
		function isActive():Boolean;

		/**
		 * Activates the tool for the given view. This method is called
		 * whenever the user switches to this tool. Use this method to
		 * reinitialize a tool.
		 * Note, a valid view must be present in order for the tool to accept activation
		 */
		function activate():void;

		/**
		 * Deactivates the tool. This method is called whenever the user
		 * switches to another tool. Use this method to do some clean-up
		 * when the tool is switched. Subclassers should always call
		 * super.deactivate.
		 */
		function deactivate():void;

		/**
		 * Handles mouse down events in the graphic view.
		 */
		function mouseDown(e:MouseEvent, x:int, y:int):void;
		
		/**
		 * Handles mouse click events in the graphic view.
		 */
		function mouseClick(e:MouseEvent, x:int, y:int):void;

		/**
		 * Handles mouse drag events in the graphic view.
		 */
		function mouseDrag(e:MouseEvent, x:int, y:int):void;

		/**
		 * Handles mouse up in the graphic view.
		 */
		function mouseUp(e:MouseEvent, x:int, y:int):void;

		/**
		 * Handles mouse moves (if the mouse button is up).
		 */
		function mouseMove(e:MouseEvent, x:int, y:int):void;
		//Hanles mouse over a object.

		function mouseOver(e:MouseEvent, x:int, y:int):void;

		function onDragDrop(event:DragEvent):void;

		/**
		 * Handles key down events in the graphic view.
		 */
		function keyDown(evt:KeyboardEvent, key:int):void;

		/**
		 * Handles mouse on node down.
		 */
		function nodeMouseDown(e:Event):void;
		/**
		 * A tool must be enabled in order to use it and to activate/deactivate it.
		 * Typically, the program enables or disables a tool.
		 *
		 * @see #isUsable
		 * @see #isActive
		 */
		function isEnabled():Boolean;
		function setEnabled(enableUsableCheck:Boolean):void;
		/**
		 * A usable tool is a enabled and either active or inactive.
		 * Typically, the tool should be able to determine itself whether it is
		 * usable or not.
		 *
		 * @see #isEnabled
		 * @see #isUsable
		 */
		function isUsable():Boolean;
		function setUsable(newIsUsable:Boolean):void;
		
		function get editor():IGraphicalEditor;

	}
}