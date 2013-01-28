package com.mrballistic.utils
{
	
	// Imports:
	import flash.geom.Point;
	
	// Math utilities
	public class MathHelper
	{
		
		/***** CONSTANTS *****/
		
		// A more precise PI
		public static const PI:Number = 3.1415926535897932384626433832796;
		
		
		
		/***** CALCULATORS *****/

		// Return random number from within a range
		public static function RandRange(max_num:Number, min_num:Number = 0):Number 
		{
			return min_num + Math.random() * (max_num - min_num);
		}
		
		// Clamps function to value range
		public static function Clamp(__value:Number, __min:Number = 0, __max:Number = 1): Number {
			return __value < __min ? __min : __value > __max ? __max : __value;
		}
		
		// Maps values from one range to another; can be set to clamp value if needed
		public static function Map(__value:Number, __oldMin:Number, __oldMax:Number, __newMin:Number = 0, __newMax:Number = 1, __clamp:Boolean = false): Number {
			if (__oldMin == __oldMax) return __newMin;
			var p:Number = ((__value-__oldMin) / (__oldMax-__oldMin) * (__newMax-__newMin)) + __newMin;
			if (__clamp) p = __newMin < __newMax ? Clamp(p, __newMin, __newMax) : Clamp(p, __newMax, __newMin);
			return p;
		}
		
		public static function rangeMod(__value:Number, __min:Number, __pseudoMax:Number): Number {
			var range:Number = __pseudoMax - __min;
			__value = (__value - __min) % range;
			if (__value < 0) __value = range - (-__value % range);
			__value += __min;
			return __value;
		}
		
		// Return random number that is always an exact multiple of the base
		public static function RandBase(base_num:Number, max_num:Number = Number.NEGATIVE_INFINITY, min_num:Number = 0):Number 
		{
			var return_num:Number = max_num != Number.NEGATIVE_INFINITY ? min_num + Math.random() * (max_num - min_num) : Math.random();
			return Math.abs(base_num) >= 1 ? Math.round((1 / base_num) * return_num) * base_num : Math.round(return_num * base_num);
		}
		
		// Return number that is a random distance from a specified number  
		public static function Drunk(base_num:Number, max_num:Number = 1):Number 
		{
			return base_num + RandRange(-max_num, max_num);
		}
		
		// Calculate angle between two points
		public static function CalcAngle(x1_num:Number, y1_num:Number, x2_num:Number, y2_num:Number):Number 
		{
			var angle_num:Number = Math.atan2(y1_num - y2_num, x1_num - x2_num) * 180 / PI;
			return (angle_num < 0) ? angle_num + PI * 2 : angle_num;
			
		}
		
		// Calculate distance between two points
		public static function CalcDistance(x1_num:Number, y1_num:Number, x2_num:Number, y2_num:Number):Number 
		{
			return Math.round(Math.sqrt(Math.pow(x1_num - x2_num, 2) + Math.pow(y1_num - y2_num, 2)));
		}
		
		// Find a point 
		public static function CalcPointFromDistance(origin_pt:Point, angle_num:Number, distance_num:Number):Point
		{
			return new Point(origin_pt.x + distance_num * Math.cos(angle_num), origin_pt.y + distance_num * Math.sin(angle_num));
		}
		
		// Returns the value of a point along a logarithmic curve based on a percentage
		public static function CalcLogFromIndex(index_num:Number, length_num:Number, max_num:Number, min_num:Number = 0):Number {
			return index_num == length_num ? max_num : Math.abs(Math.log((length_num - index_num) / length_num) / Math.log(length_num)) * (max_num - min_num) + min_num;			
		}
		
		
		
		/***** CONVERTERS *****/
		
		
		// Degrees to radians
		public static function DegToRad(degrees_num:Number):Number
		{
			return degrees_num * PI / 180;	
		}
		
		// Radians to degrees
		public static function RadToDeg(radians_num:Number):Number
		{
			return radians_num * 180 / PI;	
		}
		
	}
	
}