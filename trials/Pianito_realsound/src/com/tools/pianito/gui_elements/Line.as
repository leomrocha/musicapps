package com.tools.pianito.gui_elements 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class Line extends Sprite 
	{
		//private var _length:Number;
		private var _alpha:Number;
		private var _xend:Number;
		private var _yend:Number;
		
		public function Line(xend:Number, yend:Number, alpha:Number = 0) 
		{
			//_length = length;
			_xend = xend;
			_yend = yend;
			_alpha = alpha;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//init for use after added to stage
		protected function init(e:Event = null):void
		{
			trace("init line");
			//TODO at 0,0 add a nice center of rotation ... maybe a circle with degrade
			this.graphics.lineStyle(1, 0x000000, .9); //thickness, color, alpha
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(_xend, _yend);
			
		}
		
	}

}