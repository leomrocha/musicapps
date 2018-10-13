package com.gui_elements 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class IconButton extends GradientButton 
	{
		private var _icon:Sprite;
		
		public function IconButton(icon:Sprite, w:uint = 40, h:uint = 30, r:uint = 5 ,
									color1:uint=0x04618d, color2:uint=0x379EE0) 
		{			
			_icon = icon;
			
			super("", w, h, r, color1, color2);
		}
		
		override protected function setProperties():void
		{
			_icon.x = _w * 0.1;
			_icon.y = _h * 0.1;
			addChild(_icon);
		}
		
	}

}