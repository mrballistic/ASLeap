package com.mrballistic.utils {
	
	// Imports:
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	
	import com.mrballistic.ui.Polygon;
	
	import flash.system.Capabilities;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.geom.Matrix;
	
	// Loads an image from specified path and displays it
	public class BitmapLoad extends Sprite {

		// Public Properties:
		public var bitmap:Bitmap;						// Image bitmap
		public var bitmap_loader:Loader;				// The loader
		
		// Private & Protected Properties:
		protected var loader_context:LoaderContext;		// Loader context
		protected var preloader_mc:Sprite;				// Preloader
		
		// Initialization:
		public function BitmapLoad(path_str:String, width_num:Number = 0, height_num:Number = 0, preloader_color_num:uint = 0xCCCCCC) {
			
			// Enable color tweens
			ColorShortcuts.init();
			
			// Create and add the preloader
			addChild(preloader_mc = new Polygon([new Point(0, 0), new Point(width_num, 0), new Point(width_num, height_num), new Point(0, height_num)], preloader_color_num, 1));
			preloader_mc.width = 1;

			// Create the loader
			bitmap_loader = new Loader();
			
			// Preloader
			bitmap_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function(e:ProgressEvent):void 
			{

				// Resize the preloader
				preloader_mc.width = e.bytesLoaded / e.bytesTotal * width_num;

			}
			);
			
			// Add success listener
			bitmap_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
			{

				// Create the bitmap object
				addChildAt(bitmap = Bitmap(bitmap_loader.content), 0);
				bitmap.smoothing = true;
				bitmap.cacheAsBitmap = true;
				
				if(Capabilities.playerType == 'desktop'){ // can only do this in air				
					bitmap.cacheAsBitmapMatrix = new Matrix();
				}

				try {
				
					// Dispatch the loaded event
					dispatchEvent(new BitmapLoadEvent(BitmapLoadEvent.COMPLETE));
					
				} 
				catch (e:*) 
				{
				} 
				finally 
				{
					
					// Clean up					
					loader_context = null;
					
				}
				
				// Turn white
				Tweener.addTween(preloader_mc, { "_color": 0xFFFFFF, time: 0.15, transition: "linear", onComplete:function():void
				{
				
					// Fade out and remove the preloader
					Tweener.addTween(preloader_mc, { alpha: 0, time: 0.6, transition:"linear", onComplete:function():void
					{
	
						// Remove the preloader
						removeChild(preloader_mc);
						preloader_mc = null;
	
					}
					}
					);
					
				}
				}
				);						

			}
			);

			// Listen for IO Error
			bitmap_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void
			{

				// Dispatch the error event
				dispatchEvent(new BitmapLoadEvent(BitmapLoadEvent.ERROR));

			}
			);

			try {

				// Set up loader context
				loader_context = new LoaderContext();
				loader_context.applicationDomain = new ApplicationDomain();
				loader_context.checkPolicyFile = true;
				
				// Load it
				bitmap_loader.load(new URLRequest(path_str), loader_context);
				
			} catch (e:*) {

				try {
					
					// Dispatch the error event
					dispatchEvent(new BitmapLoadEvent(BitmapLoadEvent.ERROR));
					
				} catch (e:*) {}
				
			}
			
		}

	}
	
}