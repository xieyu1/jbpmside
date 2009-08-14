package org.jbpmside.view.component.gef
/**
 * @author liuch 2009-6-1
 */
{
	public interface IGraphicalEditor
	{
		
		function get graphicViewer():GraphicViewer;
		
		function get editPartFactory():EditPartFactory;
		
		function set editPartFactory(_editPartFactory:EditPartFactory):void;

	}
}