package com.ziba.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class Soundtrack extends Sprite
	{
		
		private var theSound:String = '';
		private var s:Sound;
		private var soundC:SoundChannel = new SoundChannel;
		private var state:Boolean = false;

		
		public function Soundtrack(_theSound:String)
		{
			theSound = _theSound;
			var req:URLRequest = new URLRequest(theSound);
			s = new Sound(req);
		}
		
		public function get playState():Boolean {
			return(state);
		} 

		public function playIt():void {
			soundC = s.play(0, int.MAX_VALUE);
			state=true;
		}
		
		public function muteIt():void {
			soundC.stop();	
			state=false;
		}
	}
}