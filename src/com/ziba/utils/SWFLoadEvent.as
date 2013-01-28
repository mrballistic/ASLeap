package com.ziba.utils {

	// Imports:
	import flash.events.Event;

	// Custom event class for SWFLoad
	public class SWFLoadEvent extends Event {

		// Constants:
		public static const COMPLETE:String = "complete";		// "complete" event string
		public static const ERROR:String = "error";				// "error" event string

		// Initialization:
		public function SWFLoadEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {

			// Super
			super(type, bubbles, cancelable);

		}

		// Override clone()
		public override function clone():Event {

			// Return Event
			return new SWFLoadEvent(type, bubbles, cancelable);

		}

		// Override toString()
		public override function toString():String {

			// Return string 
			return formatToString("SWFLoadEvent", "type", "bubbles", "cancelable", "eventPhase");

		}

	}
	
}