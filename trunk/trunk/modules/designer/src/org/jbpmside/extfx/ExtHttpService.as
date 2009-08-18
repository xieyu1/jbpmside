package org.jbpmside.extfx
{
	
	import com.adobe.serialization.json.JSON;
	import org.jbpmside.extfx.AlertTip;
	import org.jbpmside.extfx.ExtAlert;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.UIDUtil;
	
	public class ExtHttpService{
		public function ExtHttpService(){}

		public static function reqObject(param:Object):void{//
			//参数合法性校验：url不能为空；result函数是否为空可以不用约束
			if(param == null || param.result == null || param.url == null){
				//隐藏有效的明细信息
				ExtAlert.show("系统错误，请与支持人员联系","错误提示");
				return;
			}
			var service:HTTPService = new HTTPService();
			service.url = param.url;
			if(param.method!=null){
	   			service.method = param.method;
	   		}
			if(param.request!=null){
				service.request = obj2pair(param.request);
			}else{
				var request:Object = new Object();
				request.uuid = UIDUtil.createUID();
				service.request = request;
			}
			trace("-----url : "+service.url);
			service.addEventListener(ResultEvent.RESULT,function(event:ResultEvent):void{
				try{
					var rs:Object = Object(JSON.decode(event.result.toString().replace(/\r\n/g,"")));
					if(rs!=null && rs.stat=="success"){
						param.result(rs);
						if(param.hasOwnProperty("successMsg")){
							AlertTip.pop(param.successMsg);
						}
					}else{
						//隐藏有效的明细信息
						//增加trace输出
						ExtAlert.show("服务器端错误，如刷新后无效，请与支持人员联系","错误提示",JSON.encode(param));
					}
				}catch(error:Error){
					//增加trace输出
					ExtAlert.show("程序处理错误，如刷新后无效，请与支持人员联系","数据处理错误",error.message.toString());
					//Alert.show(error.message,);
				}
			});
			//如果没有错误捕捉才会采用
			if(param.fault==null){
				//将来扩展支持，自定义错误提示及title
				service.addEventListener(FaultEvent.FAULT,function(e:FaultEvent):void{
					//Alert.show(e.fault.message.toString(),"数据请求错误"); 
					ExtAlert.show("与服务器通讯错误，如刷新后无效，请与支持人员联系","数据请求错误",e.fault.message.toString());
				});
			}else{
				service.addEventListener(FaultEvent.FAULT,param.fault);
			}
			service.send();
		}
		/**
		 * 将数据调整为可以传递的值对
		 * 
		 * */
		public static function obj2pair(value:Object,pref:String=""):Object{
			var ret:Object = new Object();//需要返回的
			for(var key:String in value){
				if(value[key] is String || value[key] is Number || value[key] is int || value[key] is uint){
					ret[pref+key] = value[key];
				}else if(value[key] is Array){
					var temp_array:Array = value[key] as Array;
					ret[pref+key+".length"] = temp_array.length;//记录长度
					for(var i:int=0,len:int=temp_array.length;i<len;i++){
						var arrayobj:Object = obj2pair(temp_array[i],pref+key+"["+i+"].");
						for(var i2:String in arrayobj){
							ret[i2] = arrayobj[i2];
						}
					}
				}else if(value[key] is ArrayCollection){
					var temp_ac:ArrayCollection = value[key] as ArrayCollection;
					for(var i3:int=0,llen:int=temp_ac.length;i3<llen;i3++){
						var acobj:Object = obj2pair(temp_ac.getItemAt(i3),pref+key+".");
						for(var i4:String in acobj){
							ret[i4] = acobj[i4];
						}
					}
				}else if(value[key] is Object){
					//递归
					var temp:Object = obj2pair(value[key],pref+key+".");
					//处理值对
					for(var i5:String in temp){
						ret[pref+i5] = temp[i5];
					}
				}else{
					ret[pref+key] = value[key];
				}
			}
			ret.uuid = UIDUtil.createUID();//附加一个UUID防止相同的请求tomcat不再响应
			return ret;
		}
		
		
		
		/**

        * 当请求的应答是xml格式时采用的方式

        * 	1.把xml格式的应答字符串直接丢给用户使用

        * */
       public static function req2XMLObject(param:Object):void{
       	
       		//参数合法性校验：url不能为空；result函数是否为空可以不用约束，可能有些调用是发射后不管的
			if(param == null || param.result == null || param.url == null){
				//隐藏有效的明细信息
				ExtAlert.show("程序错误，请与支持人员联系","错误提示");
				return;
			}
			var service:HTTPService = new HTTPService();
			service.url = param.url;
			service.resultFormat = "e4x";
			if(param.method!=null){
	   			service.method = param.method;
	   		}
			if(param.request!=null){
				service.request = obj2pair(param.request);//转化为值对
			}else{
				var request:Object = new Object();
				request.uuid = UIDUtil.createUID();//附加一个UUID防止相同的请求tomcat不再响应
				service.request = request;
			}
			service.addEventListener(ResultEvent.RESULT,function(event:ResultEvent):void{
				try{
					var processXML:Object=new XML(event.result)
				}catch(error:Error){
					ExtAlert.show("服务器端错误，如刷新后无效，请与支持人员联系","错误提示",JSON.encode(param));
				}
				try{
					param.result(processXML);
				}catch(error:Error){
					ExtAlert.show("程序处理错误，如刷新后无效，请与支持人员联系","数据处理错误",error.message.toString());
				}
			});
			//如果没有错误捕捉才会采用
			if(param.fault==null){
				//将来扩展支持，自定义错误提示及title
				service.addEventListener(FaultEvent.FAULT,function(e:FaultEvent):void{
					//Alert.show(e.fault.message.toString(),"数据请求错误"); 
					ExtAlert.show("与服务器通讯错误，如刷新后无效，请与支持人员联系","数据请求错误",e.fault.message.toString());
				});
			}else{
				service.addEventListener(FaultEvent.FAULT,param.fault);
			}
			service.send();
       }
	}
}