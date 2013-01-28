package com.mrballistic.easing
{
	public class CustomEasing
	{
		// a more mellow version of Elastic.easeOut
		public static function mildElastic(t:Number, b:Number, c:Number, d:Number, p_params:Object = null):Number
		{
			var ts:Number=(t/=d)*t;
			var tc:Number=ts*t;
			return b+c*(13.5*tc*ts + -47*ts*ts + 62*tc + -38*ts + 10.5*t);
		}

	}
}