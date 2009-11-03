package org.jbpmside.util
{
	
	import mx.collections.ArrayCollection;
	import mx.utils.UIDUtil;
	import mx.utils.URLUtil;
	
	public class CommonUtil
	{
		public function CommonUtil(){}
		//字符串转为null
	    public static function convertToNull(value:String):String {
	        if ("null" == value || null == value || "" == value)
	            return null;
	        else
	            return value;
	    }
	    public static function subTimeStamp(value:String):String{
	    	if(FrameworkUtil.convertToNull(value)!=null){
	        	var index:int = value.lastIndexOf(".");
	        	var result:String = value.substr(0,index);
	        	return result;
	    	}	
	    	return null;
	    }
	    
	    public static function convertObjectToString(obj:Object):String{
	    	var result:String="";
	    	for(var key:String in obj){
	    		result+=key+":"+obj[key]+";";
	    	}
	    	return result;
	    }
	    public static function convertStringToObject(value:String):Object{
	    	return null;
	    }
	    //uuid
	    public static function uuid():String{
	    	var guid:String = UIDUtil.createUID();
	    	var array:Array = guid.split("-");
	    	var result:String = array.join("");
	    	return result;
	    } 
	    //冒泡排序
	    public static function bubble(array:ArrayCollection):void{
			var temp:Object;
			for(var i:int=0; i < array.length ; ++i){
				for(var j:int=0; j <array.length - i - 1; ++j){
		        	if(array[j].sequenceNo > array[j + 1].sequenceNo){
		            	temp = array[j];
		                array[j] = array[j + 1];
		                array[j + 1] = temp;
		            }
		        }	    	
	    	}
	    }
	    //将url参数解析Object
	    public static function parseUrlToObject(urlString:String):Object{
	    	var param:Object = new Object();
	    	if(convertToNull(urlString)!=null){
	    		var re:RegExp = /.*\?/;
				var urlStr:String = (urlString).replace(re, "");
				param = URLUtil.stringToObject(urlStr, "&");
	    	}
	    	return param;
	    }
	    	      		
	}
}