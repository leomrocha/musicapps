package com.leopanigo.components.displays.text_displays 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class TimeDisplay extends Sprite 
	{
		private var _w:Number, _h:Number;

		//TODO
		
		public function TimeDisplay(w:Number, h:Number, fontSize:Number, colour:uint) 
		{
			_w = w;
			_h = h;
		}
		
		public function updateWithSeconds(timeInSeconds:Number):void
		{
			//TODO
		}
		public function update(hh:uint, mm:uint, ss:Number):void
		{
			//TODO
		}
	}

}