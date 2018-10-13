package com.tools.SimpleMetronome.gui_components 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BmpButton extends Sprite 
	{
		protected var background:Bitmap;
		protected var _w:Number;
		protected var _h:Number;
		
		public function BmpButton(img:Bitmap, w:Number, h:Number) 
		{
			background = img;
			_w = w;
			_h = h;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			background.x = 0;
			background.y = 0;
			
			addChild(background);
			trace(" bmp button: ", background.width, background.height, this.width, this.height);
			background.width = _w;
			background.height = _h;
		}
		
	}

}