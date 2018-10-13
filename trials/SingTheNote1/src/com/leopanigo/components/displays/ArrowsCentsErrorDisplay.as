package com.leopanigo.components.displays 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class ArrowsCentsErrorDisplay extends Sprite 
	{
		private var _w:Number, _h:Number;
		
		public function ArrowsCentsErrorDisplay(w:uint, h:uint, maxErrorCents:Number = 20) 
		{
			_w = w;
			_h = h;
			_maxErrorCents = maxErrorCents;
		}
		
	}

}