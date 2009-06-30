package org.jbpmside.util
{
	public class IdGenerator
	{
		public static const COMPONENT_PREFIX:String="component_";
		
		public static function generateComponentId():String
		{
			var randomNum:Number=Math.round(Math.random()*1000000);
			return COMPONENT_PREFIX+randomNum; 
		}

	}
}