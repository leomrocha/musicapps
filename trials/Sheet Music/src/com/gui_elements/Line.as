package com.gui_elements 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class Line extends Sprite 
	{
		protected var _length:Number;
		public function Line(length:Number) 
		{
			_length = length;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		//init for use after added to stage
		protected function init(e:Event = null):void
		{
			trace("init line");
			//TODO at 0,0 add a nice center of rotation ... maybe a circle with degrade
			this.graphics.lineStyle(1, 0x000000, .8); //thickness, color, alpha
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo( _length, 0);
			
		}
		
	}

}