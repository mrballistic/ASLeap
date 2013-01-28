package com.ziba.utils {

	// Imports:
	import flash.events.Event;

	// Custom event class for BitmapLoad
	public class BitmapLoadEvent extends Event {

		// Constants:
		public static const COMPLETE:String = "complete";		// "complete" event string
		public static const ERROR:String = "error";				// "error" event string

		// Initialization:
		public function BitmapLoadEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {

			// Call superclass
			super(type, bubbles, cancelable);

		}

		// Override clone()
		public override function clone():Event {

			return new BitmapLoadEvent(type, bubbles, cancelable);

		}

		// Override toString()
		public override function toString():String {

			return formatToString("BitmapLoadEvent", "type", "bubbles", "cancelable", "eventPhase");

		}

	}
	
}