package com.mrballistic.utils {
	
	// Imports:
	import flash.events.Event;
	
	// Custom event class for FormPost
	public class FormPostEvent extends Event {
		
		// Constants:
		public static const COMPLETE:String = "complete";		// "complete" event string
		public static const ERROR:String = "error";				// "error" event string
		
		// Public Properties:
		protected var text_str:String;							// Message
		
		// Initialization:
		public function FormPostEvent(type:String, text_str:String = "", bubbles:Boolean = false, cancelable:Boolean = false)
		{
			
			// Call superclass
			super(type, bubbles, cancelable);
			
			// Define text
			this.text_str = text_str;
			
		}
		
		// Override clone()
		public override function clone():Event
		{
			
			return new FormPostEvent(type, text, bubbles, cancelable);
			
		}
		
		// Override toString()
		public override function toString():String
		{
			
			return formatToString("FormPostEvent", "type", "bubbles", "cancelable", "eventPhase", "text");
			
		}
		
		// Gets event message
		public function get text():String 
		{
		
			// Return event text
			return text_str;
		
		}
		
	}
	
}