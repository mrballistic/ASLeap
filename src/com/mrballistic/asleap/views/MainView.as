package com.mrballistic.asleap.views
{
	
	import com.mrballistic.asleap.ASLeapMain;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import base.Base;
	
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.core.Camera3D;
	import flare.core.Pivot3D;
	
	public class MainView extends Base
	{
		
		private var scene:Scene3D;
		private var car:Pivot3D;
		private var axis:Pivot3D;
		private var floor:Pivot3D;
		
		private var main:ASLeapMain;
		
		private var isRotating:int;

		public function MainView(_p:ASLeapMain)
		{
			
			super (" scale test ");
			
			main = _p;
			
			scene = new Viewer3D(this);
			scene.antialias = 2;
			
			scene.addEventListener(Scene3D.PROGRESS_EVENT, progressEvent);
			scene.addEventListener(Scene3D.COMPLETE_EVENT, completeEvent);
			scene.addEventListener(IOErrorEvent.IO_ERROR, errorEvent);
			
			scene.camera = new Camera3D( "myOwnCamera" );
			scene.camera.setPosition( 0, 10, -20 );
			scene.camera.lookAt( 0, 0, 0 );
			
			car = scene.addChildFromFile("./models/car.f3d");
			//axis = scene.addChildFromFile("./models/axis.f3d");			
			floor = scene.addChildFromFile( "./models/plane.f3d" );
			
			scene.pause();
			
		}
		
		public function resetScene(stage:Stage):void {
			
			
			
		}
		
		
		public function rotateModel(shouldRotate:int):void {
			if((shouldRotate > 1)||(shouldRotate < -1)){
				isRotating = shouldRotate;
			} else {
				isRotating = 0;
			}
			
			
		}
		
		private function errorEvent(e:IOErrorEvent):void {
			trace(e);
		}
		
		private function progressEvent(e:Event):void {
			
			trace( 'loading :', scene.loadProgress );
			
		}
		
		private function completeEvent(e:Event):void {
			
			trace('complete!');
			
			scene.resume();
			
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		private function updateEvent(e:Event):void 
		{
			// simply rotate the model on 'y/up' axis every frame.
			car.rotateY(isRotating);
						
			
		}
		
		
	}
}