package com.mrballistic.utils
{
	
	// String utilities
	public class StringHelper
	{
		
		public static const VALIDATION_EMAIL:RegExp = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
		
		protected static var uniqueSerialNumber:int = 0;
		
		
		// Simple non-RegEx replace
		public static function replace(in_str:String, find_str:String, replace_str:String):String 
		{
			
			// Split to array on find string and join on replace string
			return in_str.split(find_str).join(replace_str);
			
		}
		
		// Trim
		public static function trim(in_str:String):String {
			
			// Perform left and right trims
			return trimLeft(trimRight(in_str));
			
		}
		
		// Trim left space
		public static function trimLeft(in_str:String):String {
			
			try {
			
				// Clear leading space
				while (in_str.slice(0, 1) == " ") in_str = in_str.substr(1);
			
			} catch (e:*) {
				
				// Catch if string is empty
				
			} finally {
				
				// Return the string
				return in_str;
				
			}
			
		}
		
		// Trim right space
		public static function trimRight(in_str:String):String {
			
			try {
				
				// Clear trailing space
				while (in_str.slice(in_str.length - 1, 1) == " ") in_str = in_str.substr(0, in_str.length - 1);
				
			} catch (e:*) {
				
				// Catch if string is empty
				
			} finally {
				
				// Return the string
				return in_str;
				
			}
			
		}
		
		public static function stripDoubleCRLF(__text:String): String {
			if (__text == null) return null;
			return __text.split("\r\n").join("\n");
		}
		
		public static function wrapSpanStyle(__text:String, __style:String = null): String {
			return (Boolean(__style) ? "<span class='" + __style + "'>" : "<span>")  + __text + "</span>";
		}
		
		public static function URLEncode(__text:String): String {
			__text = escape(__text);
			__text = __text.split("@").join("%40");
			__text = __text.split("+").join("%2B");
			__text = __text.split("/").join("%2F");
			return __text;
		}
		
		public static function validate(__text:String, __expression:RegExp):Boolean {
			return __expression.test(__text);
		}
		
		public static function getUniqueSerialNumber(): int {
			return uniqueSerialNumber++;
		}
		
		public static function generateGUID(): String {
			// http://en.wikipedia.org/wiki/Globally_unique_identifier
			// This one is actually more unorthodox
			var i:int;
			
			var nums:Vector.<int> = new Vector.<int>();
			nums.push(getUniqueSerialNumber());
			nums.push(getUniqueSerialNumber());
			for (i = 0; i < 10; i++) {
				nums.push(Math.round(Math.random() * 255));
			}
			
			var strs:Vector.<String> = new Vector.<String>();
			for (i = 0; i < nums.length; i++) {
				strs.push(("00" + nums[i].toString(16)).substr(-2,2));
			}
			var now:Date = new Date();
			
			var secs:String = ("0000" + now.getMilliseconds().toString(16)).substr(-4, 4);
			
			// 4-2-2-6
			return strs[0]+strs[1]+strs[2]+strs[3]+"-"+secs+"-"+strs[4]+strs[5]+"-"+strs[6]+strs[7]+strs[8]+strs[9]+strs[10]+strs[11];
		}
		
		// finds bare html links and actually links them as proper html
		public static function replaceHTMLLinks(__text:String, __target:String = "_blank", __twitterSearchTemplate:String = "http://twitter.com/search?q=[[string]]", __twitterUserTemplate:String = "http://twitter.com/[[user]]"): String {
			
			// Create links for urls, hashtags and whatnot on the text
			var regexSearch:RegExp;
			var regexResult:Object;
			var str:String;
			
			var linkStart:Vector.<int> = new Vector.<int>();
			var linkLength:Vector.<int> = new Vector.<int>();
			var linkURL:Vector.<String> = new Vector.<String>();
			
			var i:int;
			
			// Links for hashtags
			//regexSearch = /\s#+\w*(\s|,|!|\.|\n)*?/gi;
			regexSearch = /\B#+\w*(\s|,|!|\.|\n)*?/gi;
			regexResult = regexSearch.exec(__text);
			while (regexResult != null) {
				str = regexResult[0];
				linkURL.push(__twitterSearchTemplate.split("[[string]]").join(escape(str)));
				linkStart.push(regexResult["index"]);
				linkLength.push(str.length);
				regexResult = regexSearch.exec(__text);
			}
			
			// Links for user names
			regexSearch = /@+\w*(\s|,|!|\.|\n)*?/gi;
			regexResult = regexSearch.exec(__text);
			while (regexResult != null) {
				str = regexResult[0];
				// Inserts in a sorted manner otherwise it won't work when looping
				for (i = 0; i <= linkStart.length; i++) {
					if (i == linkStart.length || regexResult["index"] < linkStart[i]) {
						linkURL.splice(i, 0, __twitterUserTemplate.split("[[user]]").join(str.substr(1)));
						linkStart.splice(i, 0, regexResult["index"]);
						linkLength.splice(i, 0, str.length);
						break;
					}
				}
				regexResult = regexSearch.exec(__text);
			}
			
			// Links for URLs
			regexSearch = /(http:\/\/+[\S]*)/gi;
			regexResult = regexSearch.exec(__text);
			while (regexResult != null) {
				str = regexResult[0];
				// Inserts in a sorted manner otherwise it won't work when looping
				for (i = 0; i <= linkStart.length; i++) {
					if (i == linkStart.length || regexResult["index"] < linkStart[i]) {
						linkURL.splice(i, 0, str);
						linkStart.splice(i, 0, regexResult["index"]);
						linkLength.splice(i, 0, str.length);
						break;
					}
				}
				//				linkURL.push(str);
				//				linkStart.push(regexResult["index"]);
				//				linkLength.push(str.length);
				regexResult = regexSearch.exec(__text);
				//trace ("URL --> [" + str + "]");
			}
			
			// Finally, add the links as HTML links
			var newText:String = "";
			var lastPos:int = 0;
			i = 0;
			while (i < linkStart.length) {
				newText += __text.substr(lastPos, linkStart[i] - lastPos);
				newText += "<a href=\"" + linkURL[i] + "\" target=\""+__target+"\">";
				newText += __text.substr(linkStart[i], linkLength[i]);
				newText += "</a>";
				
				lastPos = linkStart[i] + linkLength[i];
				
				i++;
			}
			
			
			newText += __text.substr(lastPos);
			//trace ("--> " + newDescription);
			
			return newText;
		}
		
		
		
		// returns the query string as a string
		public static function getQuerystringParameterValue(__url:String, __parameterName:String): String {
			// Finds the value of a parameter given a querystring/url and the parameter name
			var qsRegex:RegExp = new RegExp("[?&]" + __parameterName + "(?:=([^&]*))?","i");
			var match:Object = qsRegex.exec(__url);
			
			if (Boolean(match)) return match[1];
			return null;
		}
		
		
		// changes out bb code to html as needed
		public static function parseBBCodeToHTML(__text:String): String {
			
			var rx:RegExp; // For when /gi does not work
			
			// \r\n
			__text = __text.replace(/\r\n/gi, "\n");
			
			// [size="n"]...[/size]
			// <font size="n">...</font>
			rx = /\[size=\u0022([0-9]*?)\u0022\]((.|\n|\r)*?)\[\/size\]?/i;
			while (rx.test(__text)) __text = __text.replace(rx, "<font size=\"$1\">$2</font>");
			
			// [color="c"]...[/color]
			// <font color="c">...</font>
			rx = /\[color=\u0022(#[0-9a-f]*?)\u0022\]((.|\n|\r)*?)\[\/color\]?/i;
			while (rx.test(__text)) __text = __text.replace(rx, "<font color=\"$1\">$2</font>");
			
			// [url="u"]...[/url]
			// <a href="u">...</a>
			rx = /\[url=\u0022(.*?)\u0022\]((.|\n|\r)*?)\[\/url\]?/i;
			while (rx.test(__text)) __text = __text.replace(rx, "<a href=\"$1\">$2</a>");
			
			// [b]...[/b]
			// <b>...</b>
			rx = /\[b\]((.|\n|\r)*?)\[\/b\]?/i;
			while (rx.test(__text)) __text = __text.replace(rx, "<b>$1</b>");
			
			// [i]...[/i]
			// <i>...</i>
			rx = /\[i\]((.|\n|\r)*?)\[\/i\]?/i;
			while (rx.test(__text)) __text = __text.replace(rx, "<i>$1</i>");
			
			return (__text);
		}
		
		// put cdata around strings
		public static function wrapCDATA(__text:String):String {
			return "<![CDATA[" + __text + "]]>";
		}
		
		
		// Format text for XML
		public static function formatForXML(in_str:String, attribute_bln:Boolean = false, plain_text_bln:Boolean = false):String
		{
		
			// Convert ampersands for attributes
			if (attribute_bln) in_str = in_str.replace(/&/g, "&amp;");

			// // Run multiple regex replaces to convert to plain HTML
			in_str = in_str.replace(/“|”|‟|ˮ/g, "\"").replace(/‘|’|ʼ|`/g, "'").replace(/‒|–|—/g, "--").replace(/·|∙/g, "&middot;").replace(/\n|\r|\n\r|<br>|<br\/>/g, "<br/>");
			
			// Convert quotes for attributes
			if (attribute_bln) in_str = in_str.replace(/\"/g, "&quot;");
			
			// Convert to plain text
			if (plain_text_bln) in_str = in_str.replace(/<br\/>/g, "\n").replace(/&quot;/g, "\"").replace(/&middot;/g, "-").replace(/&amp;/g, "&");
			
			// Return the string
			return in_str;
				
		}
		
	}
	
}