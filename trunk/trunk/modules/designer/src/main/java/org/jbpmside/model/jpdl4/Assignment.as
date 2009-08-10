package org.jbpmside.model.jpdl4
{
	public class Assignment
	{
		//####################################################
		//	data constants
		//####################################################	
		public static const ASSIGNEE:String="assignee";
		public static const CANDIDATE_USERS:String="candidate-users";
		public static const CANDIDATE_GROUPS:String="candidate-groups";
		public static const SWIMLANE:String="swimlane";
        
        private var type:String;
        private var expression:String;
        private var expressionLanguage:String;
        
        public function getType():String{
        	return type;
        }
        
        public function setType(type:String):void{
        	this.type=type;
        }
        
        public function getExpression():String{
        	return expression;
        }
        
        public function setExpression(expression:String):void{
        	this.expression=expression;
        }
        
        public function getExpressionLanguage():String{
        	return expressionLanguage;
        }
        
        public function setExpressionLanguage(expressionLanguage:String):void{
        	this.expressionLanguage=type;
        }
	}
}