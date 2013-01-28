package com.mrballistic.utils {
	
	// Imports:
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLRequest;
	
	// Loads a SWF from specified path.
	public class SWFLoad extends Sprite {

		// Private & Protected Properties:
		public var swf_loader:Loader;		// The loader
		
		public var loaded:int = 0;
		
		// Initialization:
		public function SWFLoad(path_str:String) {

			// Create the loader
			swf_loader = new Loader();
			
			swf_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function(e:ProgressEvent):void 
			{
				
				// Update the loaded var
				loaded = Math.round(100*(e.bytesLoaded / e.bytesTotal));
				
			});
			
			
			// Add success listener
			swf_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void 
			{

				// Add the SWF
				addChild(swf_loader.content);

				try {
				
					// Dispatch the loaded event
					dispatchEvent(new SWFLoadEvent(SWFLoadEvent.COMPLETE));

				} catch (e:*) {}

			}
			);

			try {
				
				// Load it
				swf_loader.load(new URLRequest(path_str));
				
			} catch (e:*) {

				try {
					
					// Dispatch the loaded event
					dispatchEvent(new SWFLoadEvent(SWFLoadEvent.ERROR));
					
				} catch (e:*) {}
				
			}
			
		}

	}
	
}