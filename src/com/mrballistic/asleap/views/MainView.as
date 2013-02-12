package com.mrballistic.asleap.views
{
	
	import com.mrballistic.asleap.ASLeapMain;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import base.Base;
	import flare.basic.*;
	import flare.core.*;
	import flare.loaders.*;
	import flare.system.*;
	import flash.display.*;
	import flash.events.*;
	
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.core.Pivot3D;
	
	public class MainView extends Base
	{
		
		private var scene:Scene3D;
		private var car:Pivot3D;
		private var axis:Pivot3D;
		
		private var main:ASLeapMain;

		public function MainView(_p:ASLeapMain)
		{
			
			super( "Basics 1 - Drag to look around." );
			
			main = _p;
			
			scene = new Viewer3D(this);
			scene.antialias = 2;
			
			scene.addEventListener(Scene3D.PROGRESS_EVENT, progressEvent);
			scene.addEventListener(Scene3D.COMPLETE_EVENT, completeEvent);
			scene.addEventListener(IOErrorEvent.IO_ERROR, errorEvent);
			
//			scene.camera = new Camera3D( "myOwnCamera" );
//			scene.camera.setPosition( 0, 10, -20 );
//			scene.camera.lookAt( 0, 0, 0 );
			
			car = scene.addChildFromFile("./models/car.f3d");
			axis = scene.addChildFromFile("./models/axis.f3d");
			
			scene.pause();
			
		}
		
		
		private function errorEvent(e:IOErrorEvent):void {
			trace(e);
		}
		
		private function progressEvent(e:Event):void {
			
			trace( 'loading :', scene.loadProgress );
			
		}
		
		private function completeEvent(e:Event):void {
			
			trace('complete!');

			axis.setScale( 0.5, 0.5, 0.5 );
			
			scene.resume();
			
		}
		
		
	}
}