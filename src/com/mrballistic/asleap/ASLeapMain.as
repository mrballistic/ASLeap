package com.mrballistic.asleap
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	public class ASLeapMain extends Sprite
	{
		public function ASLeapMain()
		{
			
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void {
				removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
				init();		
			});
			
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function init():void {
			trace('initializing leap app');
			
		}
		
		private function destroy(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			trace('removing from stage');
		}
		
	}
}