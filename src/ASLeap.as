package
{

	import com.mrballistic.asleap.ASLeapMain;
	
	import com.mrballistic.asleap.vars.Constants;
	
	import com.mrballistic.utils.AppUtils;
	import com.mrballistic.utils.Debug;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageOrientation;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	
	public class ASLeap extends Sprite
	{
		
		private var bg:Sprite;
		private var mainApp:com.mrballistic.asleap.ASLeapMain;
		private var mainHolder:Sprite;
		private var timer:Timer;
		
		private var init:Boolean = false;
		
		
		public function ASLeap()
		{
			
			// put a nice black background behind the whole thing
			bg = new Sprite();
			bg.graphics.beginFill(0x000000, 1.0);
			bg.graphics.drawRect(-1200, -1200, 12000, 12000);
			bg.graphics.endFill();
			addChild(bg);
			
			mainHolder = new Sprite();
			addChild(mainHolder);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			
			// give air a chance to catch up
			timer = new Timer(2000);
			timer.addEventListener(TimerEvent.TIMER, function(t:TimerEvent):void{ 
				timer.removeEventListener(TimerEvent.TIMER, arguments.callee);
				initApp();
			});
			timer.start();
			
			
		}
		
		
		private function initApp():void {
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageWidth = Constants.WIDTH;
			stage.stageHeight = Constants.HEIGHT;
			stage.frameRate = 30;
			stage.fullScreenSourceRect = new Rectangle(0,0,Constants.WIDTH,Constants.HEIGHT); 
			
			var dpi:int = Capabilities.screenDPI;
			var screenX:int = Capabilities.screenResolutionX;
			var screenY:int = Capabilities.screenResolutionY;
			var diag:Number = Math.sqrt((screenX * screenY) + (screenY*screenX))/dpi;
			
			if(stage.stageHeight == Constants.HEIGHT){
				onStage();
			} else {
				trace('ERROR - incorrect stage size; this demo was originally built for a 720p screen.');
				trace('screenX:',screenX, '   screenY:',screenY, '   diag:', diag, '   dpi:',dpi);
				
				onStage();
			}
		}
		
		private function onStage():void {
			if(init) return; // yo dawg, don't reinit after init'ing
			
			mainHolder.removeChildren();
			
			init = true;
			
			NativeApplication.nativeApplication.activate();
			
			
			AppUtils.init(stage, this);
			
			// put our app on the stage
			mainApp = new ASLeapMain();
			mainApp.x = 0;
			mainApp.y = 0;
			
			mainHolder.addChild(mainApp);
			
			// Enter Fullscreen Interactive State
			//stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
		}

		
		private function handleKeyDown(e:KeyboardEvent):void
		{
			
			switch(e.keyCode){
				
				
				case 27: // esc
					NativeApplication.nativeApplication.exit();
					break;
				
				default:
					trace('ERROR: invalid keyCode: ' + e.keyCode + ', ignored.');
			}
			
		}
		
	}	
		
}
