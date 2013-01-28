package
{

	import com.mrballistic.asleap.*;

	import com.mrballistic.utils.AppUtils;
	import com.mrballistic.utils.ArrayHelper;
	import com.mrballistic.utils.DataLoader;
	import com.mrballistic.utils.Debug;
	import com.ziba.sxm.hdmi.uat.views.Main;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageOrientation;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
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
			
		}
	}
}