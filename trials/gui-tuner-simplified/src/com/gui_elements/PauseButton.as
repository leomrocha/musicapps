package com.gui_elements 
{
	import flash.display.Shape;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PauseButton extends GradientButton 
	{
		
		public function PauseButton(w:uint=40, h:uint=30, r:uint=5 ,color1:uint=0x04618d, color2:uint=0x379EE0) 
		{
			super("", w, h, r, color1, color2);
		}

		override protected function setProperties():void
		{
			var rectangle1:Shape = new Shape; // initializing the variable named rectangle
			rectangle1.graphics.lineStyle(1, 0x000000, 0.9);
			rectangle1.graphics.beginFill(0xFFFF00, 0.7); // choosing the colour for the fill
			rectangle1.graphics.drawRect( _w * 0.25 , _h * 0.2, _w *0.2, _h*0.6);// (x spacing, y spacing, width, height)
			rectangle1.graphics.endFill(); // not always needed but I like to put it in to end the fill
			addChild(rectangle1); // adds the rectangle to the stage	
			
			var rectangle2:Shape = new Shape; // initializing the variable named rectangle
			rectangle2.graphics.lineStyle(1, 0x000000, 0.9);
			rectangle2.graphics.beginFill(0xFFFF00, 0.7); // choosing the colour for the fill
			rectangle2.graphics.drawRect( _w * 0.55 , _h * 0.2, _w *0.2, _h*0.6);// (x spacing, y spacing, width, height)
			rectangle2.graphics.endFill(); // not always needed but I like to put it in to end the fill
			addChild(rectangle2); // adds the rectangle to the stage	
		}
		
	}

}