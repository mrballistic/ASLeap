package com.ziba.utils
{
	public class Debug
	{
		public static function traceObject(o:Object, indent:int = 0):void{
			var initTab:String = "";
			if(indent){
				for(var i:int = 0; i<indent; i++){
					initTab += "\t";
				}
			}
			
			for(var val:* in o){
				if(typeof(o[val]) == "object"){
					initTab = initTab.substr(0,initTab.length - 2);
					trace(initTab +'   [Object]', val  );
					traceObject(o[val], (indent + 1));
				} else {
					
					
					trace(initTab + '   [' + typeof(o[val]) + '] ' + val + ' => ' + o[val]);
				}
			}
		}
	}
}