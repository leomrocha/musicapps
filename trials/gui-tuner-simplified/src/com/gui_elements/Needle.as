package com.gui_elements 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class Needle extends Sprite 
	{
		private var _length:Number;
		private var _maxErrorCents:Number;
		//private var _minAngle:Number;
		//private var _maxAngle:Number;
		//
		public function Needle(xpos:uint, ypos:uint, length:Number, maxErrorCents:Number = 50.0) 
		{
			//x = xpos;
			//y = ypos;
			_length = length;
			_maxErrorCents = maxErrorCents;
			//_minAngle = minAngle;
			//_maxAngle = maxAngle;
			
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
			var rectangle:Shape = new Shape; // initializing the variable named rectangle
			rectangle.graphics.lineStyle(2, 0xffff0f, 0.9);
			//rectangle.graphics.beginFill(0xFF00FF); // choosing the colour for the fill, here it is red
			rectangle.graphics.drawRect( -3, - _length, 3, _length * 0.75);// (x spacing, y spacing, width, height)
			//rectangle.graphics.endFill(); // not always needed but I like to put it in to end the fill
			addChild(rectangle); // adds the rectangle to the stage			
		}
		
		public function update(errorCents:Number):void
		{
			//map error in cents to angle in degrees -> warning, the math package calculates in radians
			//remember that the scale might be useful to be logaritmic
			//if the scale goes away, then set a max rotation
			//this.rotation = ( errorCents * 90.0 / _maxErrorCents );
			
			var a:Number = ( errorCents * 90.0 / _maxErrorCents );
			if (errorCents < - _maxErrorCents)
				a = -90;
			if (errorCents > _maxErrorCents)
				a = 90;
					
			TweenMax.to(this, 0.75, {rotation:a});

		}
		
	}

}