package com.mrballistic.asleap
{
	import com.leapmotion.leap.LeapMotion;
	import com.leapmotion.leap.Frame;
	import com.leapmotion.leap.Hand;
	import com.leapmotion.leap.Finger;
	import com.leapmotion.leap.util.LeapMath;
	import com.leapmotion.leap.Vector3;
	import com.leapmotion.leap.events.LeapEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;

	
	public class ASLeapMain extends Sprite
	{
		
		private var leap:LeapMotion;
		
		
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
			
			leap = new LeapMotion();
			leap.controller.addEventListener( LeapEvent.LEAPMOTION_INIT, onInit );
			leap.controller.addEventListener( LeapEvent.LEAPMOTION_CONNECTED, onConnect );
			leap.controller.addEventListener( LeapEvent.LEAPMOTION_DISCONNECTED, onDisconnect );
			leap.controller.addEventListener( LeapEvent.LEAPMOTION_EXIT, onExit );
			leap.controller.addEventListener( LeapEvent.LEAPMOTION_FRAME, onFrame );
			
		}
		
		private function onInit(e:LeapEvent):void {
			
		}
		
		private function onConnect(e:LeapEvent):void {
			
		}
		
		private function onDisconnect(e:LeapEvent):void {	
			
		}
		
		private function onExit(e:LeapEvent):void {
			
		}
		
		private function onFrame(e:LeapEvent):void {
			
			// Get the most recent frame and report some basic information
			var frame:Frame = e.frame;
			trace( "Frame id: " + frame.id + ", timestamp: " + frame.timestamp + ", hands: " + frame.hands.length + ", fingers: " + frame.fingers.length + ", tools: " + frame.tools.length );
			
			if ( frame.hands.length > 0 )
			{
				// Get the first hand
				var hand:Hand = frame.hands[ 0 ];
				
				// Check if the hand has any fingers
				var fingers:Vector.<Finger> = hand.fingers;
				if ( fingers.length > 0 )
				{
					// Calculate the hand's average finger tip position
					var avgPos:Vector3 = Vector3.zero();
					for each ( var finger:Finger in fingers )
					avgPos = avgPos.plus( finger.tipPosition );
					
					avgPos = avgPos.divide( fingers.length );
					trace( "Hand has " + fingers.length + " fingers, average finger tip position: " + avgPos );
				}
				
				// Get the hand's sphere radius and palm position
				trace( "Hand sphere radius: " + hand.sphereRadius + " mm, palm position: " + hand.palmPosition );
				
				// Get the hand's normal vector and direction
				var normal:Vector3 = hand.palmNormal;
				var direction:Vector3 = hand.direction;
				
				// Calculate the hand's pitch, roll, and yaw angles
				trace( "Hand pitch: " + LeapMath.toDegrees( direction.pitch ) + " degrees, " + "roll: " + LeapMath.toDegrees( normal.roll ) + " degrees, " + "yaw: " + LeapMath.toDegrees( direction.yaw ) + " degrees\n" );
			}
		}

		private function destroy(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			trace('removing from stage');
		}
		
	}
}