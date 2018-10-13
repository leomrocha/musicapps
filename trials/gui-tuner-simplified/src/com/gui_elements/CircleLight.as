package com.gui_elements 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class CircleLight extends Sprite 
	{
		private var _r:Number;
		private var _circle:Shape;
		
		public function CircleLight(r:Number) 
		{
			_r = r;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		//init for use after added to stage
		protected function init(e:Event = null):void
		{
			//if (e)
			//{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			//}
			trace("init needle");
			//TODO at 0,0 add a nice center of rotation ... maybe a circle with degrade
			//this.graphics.lineStyle(3, 0x000000, .9); //thickness, color, alpha
			//this.graphics.moveTo(0, 0);
			//this.graphics.lineTo(0, - _length);
			_circle = new Shape(); // initializing the variable named rectangle
			_circle.graphics.lineStyle(1, 0xffffff, 0.7);
			_circle.graphics.beginFill(0xFF0000); // choosing the colour for the fill, here it is red
			_circle.graphics.drawCircle(0, 0, _r);
			_circle.graphics.endFill(); // not always needed but I like to put it in to end the fill
			addChild(_circle); // adds the rectangle to the stage			
		}
		
		public function update(errorCents:Number):void
		{
			var color:uint = 0XFF0000;
			if (Math.abs(errorCents) <= 5 ) color = 0x00FF00;
			
			if(_circle.parent) removeChild(_circle);
			_circle = new Shape(); // initializing the variable named rectangle
			_circle.graphics.lineStyle(1, 0xffffff, 0.7);
			_circle.graphics.beginFill(color); // choosing the colour for the fill, here it is red
			_circle.graphics.drawCircle(0, 0, _r);
			_circle.graphics.endFill(); // not always needed but I like to put it in to end the fill
			addChild(_circle); // adds the rectangle to the stage	
			
		}
	}

}