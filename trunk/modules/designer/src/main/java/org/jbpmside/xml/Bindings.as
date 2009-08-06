package org.jbpmside.xml
{
	import mx.collections.ArrayCollection;
	
	import org.jbpmside.xml.binding.StartBinding;
	
	public class Bindings
	{
		private var activityBindings:ArrayCollection;
		private var eventListenerBindings:ArrayCollection;
		
		public function getBinding(elementXml:XML,category:String):Binding{
			var bindings:ArrayCollection;
			if(category==Parser.CATEGORY_ACTIVITY){
				bindings=activityBindings;
			}else if(category==Parser.CATEGORY_ACTIVITY){
				bindings=eventListenerBindings;
			}
			for each(var binding:Binding in bindings){
				if(binding.matches(elementXml.name)){
					return binding;
				}
			}
			return null;
		}
		
		//####################################################
		//	singleton
		//####################################################	
		
		public function Bindings(){
			initActivityBindings();
			initEventListenerBindings();
		}
		
		private function initActivityBindings():void{
			this.activityBindings=new ArrayCollection();
			addActivityBinding(new StartBinding());
		}
		
		private function addActivityBinding(binding:Binding):void{
			binding.setCategory(Parser.CATEGORY_ACTIVITY);
			this.activityBindings.addItem(binding);
		}
		
		private function initEventListenerBindings():void{
			this.eventListenerBindings=new ArrayCollection();
		}
		
		private static var _instance:Bindings
		
		public static function getInstance():Bindings{
			if( !_instance ){
				_instance = new Bindings();
			}
			return _instance;
		}

	}
}