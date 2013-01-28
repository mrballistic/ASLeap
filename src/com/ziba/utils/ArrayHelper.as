package com.ziba.utils
{
	public class ArrayHelper
	{
		public static function swap( vect:Object, a:uint, b:uint ):void {
			var temp:Object = vect[a];
			vect[a] = vect[b];
			vect[b] = temp;
		}

		// implementation of a Fisher–Yates shuffle 
		public static function sort( vect:Object ):Object {
			var totalItems : uint = vect.length;
			for (var i : uint = 0; i < totalItems; i++)
				swap( vect, i, i + uint( Math.random() * (totalItems - i) ) );
			
			return vect;
		}
	}
}