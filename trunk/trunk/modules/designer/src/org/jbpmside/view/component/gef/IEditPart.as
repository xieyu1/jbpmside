package org.jbpmside.view.component.gef
/**
 * @author liuch 2009-6-1
 */
{
	import mx.collections.ArrayCollection;

	public interface IEditPart
	{
		function get model():Object;

		function set model(_model:Object):void;

		function getModelChildren():ArrayCollection;

		function getModelSourceConnections():ArrayCollection;

		function getModelTargetConnections():ArrayCollection;

	}
}