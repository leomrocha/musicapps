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
		
		public function PlayButton(w:uint=40, h:uint=30, r:uint=5 ,color1:uint=0x04618d, color2:uint=0x379EE0) 
		{
			super("", w, h, r, color1, color2);
		}
		
		override protected function setProperties():void
		{
			var triangle:Shape = new Shape();
			triangle.graphics.lineStyle(1, 0x000000, .9); //thickness, color, alpha
			triangle.graphics.beginFill(0xffff00,0.9)
			triangle.graphics.moveTo(_w * 0.4 , _h * 0.2 );
			triangle.graphics.lineTo(_w * 0.6 , _h * 0.5 );
			triangle.graphics.lineTo(_w * 0.4 , _h * 0.8 );
			triangle.graphics.lineTo(_w * 0.4 , _h * 0.2 );
			triangle.graphics.endFill();
			addChild(triangle);
		}
		
	}

}