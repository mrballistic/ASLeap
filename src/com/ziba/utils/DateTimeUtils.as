package com.ziba.utils
{
	
	// Date/time utilities
	public class DateTimeUtils
	{
	
		// Get number of days in month
		public static function daysInMonth(month:int, year:int = -1):uint {
			
			// Set year to current if none specified
			if (year == -1) year = new Date().fullYear;
			
			// Return numbers of days
			return month == 11 ? new Date(year, 0, 0).date : new Date(year, month + 1, 0).date;

		}
		
		public static function subtraction(__date1:Date, __date2:Date): Date {
			var dateResult:Date = new Date();
			dateResult.time = __date1.time - __date2.time;
			return dateResult;
		}
		
		public static function addition(__date1:Date, __date2:Date): Date {
			var dateResult:Date = new Date();
			dateResult.time = __date1.time + __date2.time;
			return dateResult;
		}
		
		public static function stringSecondsToSeconds(__time:String): Number {
			// Returns number of seconds based on a string
			// Examples:
			// 01:30 -> returns 90
			// 30 -> returns 30
			// 90 -> returns 90
			
			var num:Number = 0;
			var cs:Array = __time.split(":");
			for (var i:int = 0; i < cs.length; i++) {
				num += parseFloat(cs[i]) * Math.pow(60, cs.length - i - 1);
			}
			
			return num;
		}
		
		public static function simpleDateToDate(__date:String): Date {
			// Converts 2010-01-01 to a date
			var tt:Date = new Date();
			tt.fullYearUTC = parseInt(__date.substr(0, 4), 10);
			tt.monthUTC = parseInt(__date.substr(5, 2), 10) - 1;
			tt.dateUTC = parseInt(__date.substr(8, 2), 10);
			tt.hoursUTC = 0;
			tt.secondsUTC = 0;
			tt.millisecondsUTC = 0;
			return tt;
		}
		
		// Generate a date/time stamp (YYYYMMDDhhmmss)
		public static function getDateTimeStamp():String
		{
			
			// Get the date
			var date:Date = new Date();
			
			// Return formatted date/time
			return date.fullYear.toString() + 
				   twoDigit((date.month + 1).toString()) + 
				   twoDigit(date.date.toString()) + 
				   twoDigit(date.hours.toString()) + 
				   twoDigit(date.minutes.toString()) + 
				   twoDigit(date.seconds.toString());
				
		}
		
		public static function verboseDifference(__date:Date): String {
			// Returns a friendly description of a time difference ("2 hours", "1 day", "10 seconds", "1 year" etc)
			
			var now:Date = new Date();
			now.getTime();
			var newDate:Date = subtraction(now, __date);
			__date = newDate;
			
			// Full data
			var seconds:Number = __date.time / 1000;
			var minutes:Number = seconds / 60;
			var hours:Number = minutes / 60;
			var days:Number = hours / 24;
			var weeks:Number = days / 7;
			var months:Number = days / (365.25 / 12);
			var years:Number = days / 365.25;
			
			seconds = Math.floor(seconds);
			minutes = Math.floor(minutes);
			hours = Math.floor(hours);
			days = Math.floor(days);
			weeks = Math.floor(weeks);
			months = Math.floor(months); 
			years = Math.floor(years);
			
			if (years > 1)		return years + " years";
			if (years == 1)		return years + " year";
			if (months > 1)		return months + " months";
			if (months == 1)	return months + " month";
			//if (weeks > 1)		return weeks + " weeks";
			//if (weeks == 1)		return weeks + " week";
			if (days > 1)		return days + " days";
			if (days == 1)		return days + " day";
			if (hours > 1)		return hours + " hours";
			if (hours == 1)		return hours + " hour";
			if (minutes > 1)	return minutes + " minutes";
			if (minutes == 1)	return minutes + " minute";
			if (seconds > 1)	return seconds + " seconds";
			if (seconds == 1)	return seconds + " second";
			
			return "";
		}
		
		// Add leading zero to single number
		protected static function twoDigit(in_str:String):String
		{
			
			// DO IT!
			return in_str.length == 1 ? "0" + in_str : in_str;
			
		}
		
	}
	
}