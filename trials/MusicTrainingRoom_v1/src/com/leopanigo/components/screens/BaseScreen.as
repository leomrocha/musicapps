package com.leopanigo.components.screens 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class BaseScreen extends Sprite
	{
		protected var _w:Number, _h:Number;
		
		public function BaseScreen(w:Number , h:Number) 
		{
			_w = w;
			_h = h;
		}
		
	}

}