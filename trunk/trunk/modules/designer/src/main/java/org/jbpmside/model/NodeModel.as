package org.jbpmside.model
/**
 * @author liuch 2009-6-1
 */
{
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	import org.jbpmside.event.CustomEvent;

	public class NodeModel extends CommonObject
	{
		private var _x:Number;
		private var _y:Number;

		private var _targetTransitions:ArrayCollection;
		private var _sourceTransitions:ArrayCollection;


		public function NodeModel()
		{
			_targetTransitions=new ArrayCollection();
			_sourceTransitions=new ArrayCollection();
			_sourceTransitions.addEventListener(CollectionEvent.COLLECTION_CHANGE, onNodeCollectionChange);
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(_x:Number):void
		{
			this._x=_x;
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(_y:Number):void
		{
			this._y=_y;
		}

		public function get targetTransitions():ArrayCollection
		{
			return _targetTransitions;
		}

		public function set targetTransitions(transitions:ArrayCollection):void
		{
			this._targetTransitions=transitions;
		}

		public function get sourceTransitions():ArrayCollection
		{
			return _sourceTransitions;
		}

		public function set sourceTransitions(transitions:ArrayCollection):void
		{
			this._sourceTransitions=transitions;
		}

		public function addTargetTransition(transition:ConnectionModel):void
		{
			_targetTransitions.addItem(transition);
		}

		public function removeTargetTransition(transition:ConnectionModel):void
		{
			_targetTransitions.removeItemAt(_targetTransitions.getItemIndex(transition));
		}

		public function addSourceTransition(transition:ConnectionModel):void
		{
			_sourceTransitions.addItem(transition);
		}

		public function removeSourceTransition(transition:ConnectionModel):void
		{
			_sourceTransitions.removeItemAt(_sourceTransitions.getItemIndex(transition));
		}

		private function onNodeCollectionChange(event:CollectionEvent):void
		{
			theModel.dispatchEvent(new CustomEvent(TheModel.NODE_COLLECTION_CHANGE_EVENT));
		}



	}
}