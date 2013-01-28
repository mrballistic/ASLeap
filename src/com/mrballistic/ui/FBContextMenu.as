// Custom context menu
package com.mrballistic.ui {

	// Imports:
	import flash.events.ContextMenuEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	// The class
	public class FBContextMenu {

		public var context_menu:ContextMenu;			// The context menu
		
		// Constructor
		public function FBContextMenu(copyright_str:String, credit_str:String, link_str:String) {
			
			// Create context menu object
			context_menu = new ContextMenu();
						
			// Create copyright line
			var copyright_cmi:ContextMenuItem = new ContextMenuItem(copyright_str);
			
			// Create site credit line
			var site_cmi:ContextMenuItem = new ContextMenuItem(credit_str);
			site_cmi.separatorBefore = true;
			
			// Link site credit line
			site_cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function(e:ContextMenuEvent):void { navigateToURL(new URLRequest(link_str), "_blank"); });
			
			// Add items to the menu
			context_menu.customItems.push(copyright_cmi, site_cmi);
			
			// Disable other menu items
			context_menu.hideBuiltInItems();

		}

	}

}