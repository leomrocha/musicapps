package com.gui_elements 
{
	import flash.display.Shape;
	import flash.geom.Point;
	import com.gui_elements.GradientButton;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PlayButton extends GradientButton 
	{
		public static const BUTTON_DIRECTION_UP:String = "UP";
		public static const BUTTON_DIRECTION_DOWN:String = "DOWN";
		public static const BUTTON_DIRECTION_LEFT:String = "LEFT";
		public static const BUTTON_DIRECTION_RIGHT:String = "RIGHT";
		
		private var _dir:String; //1 right, 2 left, 3 up, 4 down direction of the arrow
		private var _markColour:uint;
		
		public function PlayButton(w:uint=40, h:uint=30, r:uint=5 ,color1:uint=0x04618d, color2:uint=0x379EE0, dir:String="RIGHT", markColour:uint = 0xFFFF00) 
		{
			
			_dir = dir;
			_markColour = markColour;
			
			super("", w, h, r, color1, color2);
		}
		
		override protected function setProperties():void
		{
			var triangle:Shape = new Shape();
			triangle.graphics.lineStyle(1, 0x000000, .9); //thickness, color, alpha
			triangle.graphics.beginFill(_markColour, 0.9)
			if (_dir == PlayButton.BUTTON_DIRECTION_RIGHT)
			{
				triangle.graphics.moveTo(_w * 0.4 , _h * 0.2 );
				triangle.graphics.lineTo(_w * 0.6 , _h * 0.5 );
				triangle.graphics.lineTo(_w * 0.4 , _h * 0.8 );
				triangle.graphics.lineTo(_w * 0.4 , _h * 0.2 );
			}else if (_dir == PlayButton.BUTTON_DIRECTION_LEFT)
			{
				triangle.graphics.moveTo(_w * 0.6 , _h * 0.2 );
				triangle.graphics.lineTo(_w * 0.4 , _h * 0.5 );
				triangle.graphics.lineTo(_w * 0.6 , _h * 0.8 );
				triangle.graphics.lineTo(_w * 0.6 , _h * 0.2 );
			}else if (_dir == PlayButton.BUTTON_DIRECTION_DOWN)
			{
				triangle.graphics.moveTo(_w * 0.2 , _h * 0.4 );
				triangle.graphics.lineTo(_w * 0.5 , _h * 0.6 );
				triangle.graphics.lineTo(_w * 0.8 , _h * 0.4 );
				triangle.graphics.lineTo(_w * 0.2 , _h * 0.4 );
			}else if (_dir == PlayButton.BUTTON_DIRECTION_UP)
			{
				triangle.graphics.moveTo(_w * 0.2 , _h * 0.6 );
				triangle.graphics.lineTo(_w * 0.5 , _h * 0.4 );
				triangle.graphics.lineTo(_w * 0.8 , _h * 0.6 );
				triangle.graphics.lineTo(_w * 0.2 , _h * 0.6 );
			}
			triangle.graphics.endFill();
			addChild(triangle);
		}
		
	}

}