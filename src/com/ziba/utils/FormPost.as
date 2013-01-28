package com.ziba.utils
{
	
	// Imports:
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	// Posts an object to a form
	public class FormPost extends EventDispatcher
	{
		
		// Public Properties:
		public var data:*;							// Result
		
		// Private & Protected Properties:
		protected var form_loader:URLLoader;		// Form loader
		
		// Initialization:
		public function FormPost(url_str:String, vars:* = null, method_str:String = "POST")
		{
			
			// Create the request and loader
			form_loader = new URLLoader();
			var form_request:URLRequest = new URLRequest(url_str);
			form_request.method = method_str;
			
			// Incoming object is XML
			if (vars is XML)
			{
				
				// Set data as XML
				form_request.contentType = "text/xml";
				form_request.data = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n" + vars.toXMLString();
				
			} 
			else if (vars is Object)
			{
			
				// Copy variables from generic object
				var forms_vars:URLVariables = new URLVariables();
				for (var i:String in vars) forms_vars[i] = vars[i];
				
				// Set form data
				form_request.data = forms_vars;
				
			}
			
			// Add event listeners to URL loader
			form_loader.addEventListener(Event.COMPLETE, successHandler);
			form_loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			form_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			
			try {
				
				// Load the request
				form_loader.load(form_request);
				
			} catch (e:*) {
				
				// Dispatch error
				errorHandler();
				
			}
			
		}
		
		// Handles success
		protected function successHandler(e:Event):void 
		{
			
			// Populate data
			data = form_loader.data;
			
			// Dispatch complete event
			dispatchEvent(new FormPostEvent(FormPostEvent.COMPLETE));
			
			// Clean up
			removeEventListeners();
			
		}
		
		// Handles errors
		protected function errorHandler(e:* = null):void 
		{
		
			// Dispatch error event
			dispatchEvent(new FormPostEvent(FormPostEvent.ERROR, e["text"]));
			
			// Clean up
			removeEventListeners();
			
		}
		
		// Removes event listeners from URL loader
		protected function removeEventListeners():void 
		{
		
			// DO IT!
			form_loader.removeEventListener(Event.COMPLETE, successHandler);
			form_loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			form_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
		
		}
		
	}
	
}