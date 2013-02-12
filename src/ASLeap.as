package
{

	import com.mrballistic.asleap.ASLeapMain;
	import com.mrballistic.asleap.views.MainView;
	import com.mrballistic.asleap.vars.Constants;
	import com.mrballistic.utils.AppUtils;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	
	public class ASLeap extends Sprite
	{
		
		private var bg:Sprite;
		private var frame:Sprite;
		private var mainApp:ASLeapMain;
		private var mainHolder:Sprite;
		private var timer:Timer;
		
		public function ASLeap()
		{
			// put a nice black background behind the whole thing
			bg = new Sprite();
			bg.graphics.beginFill(0x000000, 1.0);
			bg.graphics.drawRect(-1200, -1200, 12000, 12000);
			bg.graphics.endFill();
			addChild(bg);
			
			// our content wrapper sprite
			mainHolder = new Sprite();
			addChild(mainHolder);
			
			// add a frame around the whole thing
			frame = new Sprite();
			frame.graphics.lineStyle(1.0,0x333333,1.0, true);
			frame.graphics.drawRect(0,0,Constants.WIDTH-1,Constants.HEIGHT-1);
			frame.graphics.endFill();
			addChild(frame);
			
			// give air a chance to catch up
			timer = new Timer(1500);
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
			stage.frameRate = 60;
	
			stage.nativeWindow.activate();
			stage.fullScreenSourceRect = new Rectangle(0,0,Constants.WIDTH,Constants.HEIGHT); 
			onStage();
			
		}
		
		private function onStage():void {

			mainHolder.removeChildren();			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);

			AppUtils.init(stage, this);
			
			// put our app on the stage
			mainApp = new ASLeapMain();
			mainApp.x = 0;
			mainApp.y = 0;
			mainHolder.addChild(mainApp);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);			
		}

		
		private function handleKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode){
				
				case 82: // 'r' -- resets the app					
					onStage();
					break;
				
				case 70: // 'f' -- switches from fullscreen to standard small screen  
					if((stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE)||(stage.displayState == StageDisplayState.FULL_SCREEN)){
						stage.displayState = StageDisplayState.NORMAL;
					} else {
						try{
							stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
						} catch (e:Error) {
							trace('fullscreen interactive failure... falling back to non-interactive');
							stage.displayState = StageDisplayState.FULL_SCREEN;
						}
					}
					break;
				
				case 27: // esc
					NativeApplication.nativeApplication.exit();
					break;
				
				default:
					trace('ERROR: invalid keyCode: ' + e.keyCode + ', ignored.');
			}
			
		}
		
	}	
		
}
