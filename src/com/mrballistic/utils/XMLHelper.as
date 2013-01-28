package com.mrballistic.utils
{
	
	// XML Utilities
	public class XMLHelper
	{
		
		// Sort an XMLList -- pass "text" for CDATA or "@attr" 
		// for attribute, where "attr" is the attribute
		public static function sortList(unsorted_xmllist:XMLList, sort_str:String = "text", depth_num:int = 0):XMLList
		{

			// Used in iteration
			var i:int;
			var nodes_num:int;
			
			// Init the sort array
			var sort_array:Vector.<String> = new Vector.<String>();
			
			// Define the separator (a series of pipes which shouldn't occur in text)  
			var separator_str:String = "";
			while (separator_str.length < 33) separator_str += "|";
			
			// Iterate through all values in list and add attribute 
			// or text to the array, appending separator with index  
			nodes_num = unsorted_xmllist.length();
			for (i = 0; i < nodes_num; i++)
			{

				// Set traverse idnex
				var traverse_num:int = depth_num;
				
				// Get node and child index
				var node_xml:XML = unsorted_xmllist[i];
				var index_num:int = node_xml.childIndex();
				
				// Traverse towards root
				while (traverse_num > 0)
				{
					
					// Get node and child index
					node_xml = node_xml.parent()[0];
					index_num = node_xml.childIndex();
					
					// Decrease steps
					traverse_num--;
					
				}
				
				// Add value and index to vector
				sort_array.push(String(sort_str == "text" ? unsorted_xmllist[i].text() : unsorted_xmllist[i].@[sort_str.replace(/@/g, "")]) + separator_str + String(index_num));
				
			}
			
			// Sort the array
			sort_array.sort(function(a_str:String, b_str:String):Number
			{
				
				// Sort function -- 0 if equal, -1 if lower, 1 if higher
				return a_str == b_str ? 0 : a_str < b_str ? -1 : 1;
				
			});
			
			// Create a root node
			var root_xml:XML = new XML("<root />");
			
			// Iterate through the array and append nodes to root
			for (i = 0; i < nodes_num; i++) root_xml.appendChild(unsorted_xmllist[int(sort_array[i].split(separator_str)[1])]);
			
			// Return the sorted XML
			return root_xml.children();
			
		}
		
	}
	
}