package org.jbpmside.view.component.gef.command
/**
 * @author liuch 2009-6-1
 */
{
	import mx.collections.ArrayCollection;
	
	public class CommandStack
	{

		/**
		 * Constant indicating notification after a command has been executed (value is 8).
		 */
		public static const POST_EXECUTE:int = 8;
		/**
		 * Constant indicating notification after a command has been redone (value is 16).
		 */
		public static const   POST_REDO:int = 16;
		/**
		 * Constant indicating notification after a command has been undone (value is 32).
		 */
		public static const   POST_UNDO:int = 32;

		public static const   POST_MASK:int = POST_EXECUTE | POST_UNDO | POST_REDO;
		
		/**
		 * Constant indicating notification prior to executing a command (value is 1).
		 */
		public static const    PRE_EXECUTE:int= 1;
		/**
		 * Constant indicating notification prior to redoing a command (value is 2).
		 */
		public static const   PRE_REDO:int = 2;
		
		/**
		 * Constant indicating notification prior to undoing a command (value is 4).
		 */
		public static const   PRE_UNDO:int = 4;
		
		public static const   PRE_MASK:int = PRE_EXECUTE | PRE_UNDO | PRE_REDO;
		
		
		private var redoable:Array = new Array();
		
		private var saveLocation:int = 0;
		
		private var undoable:Array = new Array();
		
		private var undoLimit:int = 0;

		/**
		 * Constructs a new command stack. By default, there is no undo limit, and isDirty() will
		 * return <code>false</code>.
		 */
		public function CommandStack() { }
		
		/**
		 * @return <code>true</code> if it is appropriate to call {@link #redo()}.
		 */
		public function canRedo():Boolean {
			return !redoable.isEmpty();
		}

		/**
		 * @return <code>true</code> if {@link #undo()} can be called
		 */
		public function canUndo():Boolean {
			if (undoable.length == 0)
				return false;
			return (undoable[0] as Command).canUndo();
		}

		/**
		 * This will <code>dispose()</code> all the commands in both the undo and redo stack. Both
		 * stacks will be empty afterwards.
		 */
		public function dispose():void {
			flushUndo();
			flushRedo();
		}

		/**
		 * Executes the specified Command if possible. Prior to executing the command, a
		 * CommandStackEvent for {@link #PRE_EXECUTE} will be fired to event listeners. 
		 * Similarly, after attempting to execute the command, an event for {@link #POST_EXECUTE}
		 * will be fired.  If the execution of the command completely normally,  stack listeners
		 * will receive {@link CommandStackListener#commandStackChanged(EventObject) stackChanged}
		 * notification.
		 * <P>
		 * If the command is <code>null</code> or cannot be executed, nothing happens.
		 * @param command the Command to execute
		 * @see CommandStackEventListener
		 */
		public function execute(command:Command):void {
			if (command == null || !command.canDo())
				return;
			flushRedo();
			try {
				command.perform();
				if (getUndoLimit() > 0) {
					while (undoable.length >= getUndoLimit()) {
						undoable.remove(0);
						if (saveLocation > -1)
							saveLocation--;
					}
				}
				if (saveLocation > undoable.length)
					saveLocation = -1; //The save point was somewhere in the redo stack
				undoable.push(command);
			} finally {
			}
		}
		
		/**
		 * Flushes the entire stack and resets the save location to zero. This method might be
		 * called when performing "revert to saved".
		 */
		public function flush():void {
			flushRedo();
			flushUndo();
			saveLocation = 0;
		}
		
		private function flushRedo():void {
			while (redoable.length>0)
				redoable.pop();
		}
		
		private function flushUndo():void {
			while (redoable.length>0)
				undoable.pop();
		}
		
		/**
		 * @return an array containing all commands in the order they were executed
		 */
		public function getCommands():Object {
			var commands:ArrayCollection = new ArrayCollection(undoable);
			for (var i:int = redoable.length - 1; i >= 0; i--) {
				commands.addItem(redoable.get(i));
			}
			return commands.toArray();
		}
		
		/**
		 * Peeks at the top of the <i>redo</i> stack. This is useful for describing to the User
		 * what will be redone. The returned <code>Command</code> has a label describing it.
		 * @return the top of the <i>redo</i> stack, which may be <code>null</code>
		 */
		public function getRedoCommand():Command {
			if(redoable.isEmpty())
				return null;
			return Command(redoable.pop());
		}
		
		/**
		 * Peeks at the top of the <i>undo</i> stack. This is useful for describing to the User
		 * what will be undone. The returned <code>Command</code> has a label describing it.
		 * @return the top of the <i>undo</i> stack, which may be <code>null</code>
		 */
		public function getUndoCommand():Command {
			if(undoable.isEmpty())
				return null;
			return Command(undoable.pop());
		}
		
		/**
		 * Returns the undo limit. The undo limit is the maximum number of atomic operations that
		 * the User can undo. <code>-1</code> is used to indicate no limit.
		 * @return the undo limit
		 */
		public function getUndoLimit():int {
			return undoLimit;
		}
		
		/**
		 * Returns true if the stack is dirty. The stack is dirty whenever the last executed or
		 * redone command is different than the command that was at the top of the undo stack when
		 * {@link #markSaveLocation()} was last called. 
		 * @return <code>true</code> if the stack is dirty
		 */
		public function isDirty():Boolean {
			return undoable.size() != saveLocation;
		}
		
		/**
		 * Marks the last executed or redone Command as the point at which the changes were saved.
		 * Calculation of {@link #isDirty()} will be based on this checkpoint.
		 */
		public function markSaveLocation():void {
			saveLocation = undoable.size();
		}
		
		
		/**
		 * Calls redo on the Command at the top of the <i>redo</i> stack, and pushes that Command
		 * onto the <i>undo</i> stack. This method should only be called when {@link #canUndo()}
		 * returns <code>true</code>.
		 */
		public function redo():void {
			//Assert.isTrue(canRedo())
			if (!canRedo())
				return;
		 var command:Command = redoable.pop() as Command;
			try {
				command.redo();
				undoable.push(command);
			} finally {
			}
		}
		
		
		
		/**
		 * Sets the undo limit. The undo limit is the maximum number of atomic operations that the
		 * User can undo. <code>-1</code> is used to indicate no limit.
		 * @param undoLimit the undo limit
		 */
		public function setUndoLimit(undoLimit:int):void {
			this.undoLimit = undoLimit;
		}
		
		/**
		 * Undoes the most recently executed (or redone) Command. The Command is popped from the
		 * undo stack to and pushed onto the redo stack. This method should only be called when
		 * {@link #canUndo()} returns <code>true</code>.
		 */
		public function undo():void {
			//Assert.isTrue(canUndo());
			var command:Command = Command(undoable.pop());
			try {
				command.undo();
				redoable.push(command);
			} finally {
			}
		}
	}
}