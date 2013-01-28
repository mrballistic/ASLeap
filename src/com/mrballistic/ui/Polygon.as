// Draws a polygon
package com.mrballistic.ui {

	// Imports:
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	
	// The class
	public dynamic class Polygon extends Sprite {

		// Initialization:
		public function Polygon(point_array:Array, 									// Array of points
								rgb_num:uint = 0xFFFFFF, 							// Fill color
								alpha_num:Number = 1, 								// Fill alpha
								line_thickness_num:Number = 0, 						// Line thickness
								line_rgb_num:uint = 0xFFFFFF, 						// Line color
								line_alpha_num:Number = 0, 							// Line alpha
								line_scale_mode_str:String = "normal"				// Line scale mode
							   ) {
			

			// Define fill and line style
			graphics.beginFill(rgb_num, alpha_num);
			if (line_thickness_num > 0) graphics.lineStyle(line_thickness_num, line_rgb_num, line_alpha_num, true, line_scale_mode_str);
			
			// Connect the dots
			graphics.moveTo(point_array[0].x, point_array[0].y);
			var points_num:Number = point_array.length;
			for (var i:Number = 1; i < points_num; i++) graphics.lineTo(point_array[i].x, point_array[i].y);
			
			// Close the fill
			graphics.endFill();

		}

	}

}