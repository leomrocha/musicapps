package com.tools.SimpleTunerGui.gui_elements
{

	import com.tools.SimpleTunerGui.music_concepts.Note;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class  GradientCircle extends Sprite
	{
		//colors
		protected var _color1:uint ;
		protected var _color2:uint ;
		
		protected var _redColor1:uint  = 0xff0000;
		protected var _redColor2:uint = 0xAf0000;
		protected var _greenColor1:uint = 0x00ff00;
		protected var _greenColor2:uint = 0x00Af00;
		protected var _yellowColor1:uint = 0x555500;
		protected var _yellowColor2:uint = 0x050500;
		
		protected var DEFAULT_COLOR1:uint = 0x111111;
		protected var DEFAULT_COLOR2:uint = 0x050505;
		//dimensions
		protected var _r:uint;
		//text
		
		protected var colors:Object;
		
		public function GradientCircle( r:uint=15)
		{
			_color1 = DEFAULT_COLOR1;
			_color2 = DEFAULT_COLOR2;
			
			_r = r;
			colors = { left:_color1, right:_color2 };
			

			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		//init for use after added to stage
		protected function init(e:Event = null):void
		{

			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//this.buttonMode = true;
			
			drawGradient();

			//this.addEventListener(MouseEvent.MOUSE_OVER, startAnimatingGradient);
			//this.addEventListener(MouseEvent.MOUSE_OUT, resetAnimatingGradient);
			
		}
		
		public function drawGradient():void 
		{
			var m:Matrix = new Matrix();
			m.createGradientBox(_r, _r, 0, 0, 0);
			this.graphics.beginGradientFill(GradientType.RADIAL, [colors.left, colors.right], 
												[1, 1], [0x00, 0xFF], m, SpreadMethod.REFLECT);
			//this.graphics.drawRoundRect(0,0,_w,_h, _r);
			this.graphics.drawCircle(0, 0, _r);
		}
		

		public function paintDefault():void
		{
			_color1 = DEFAULT_COLOR1;
			_color2 = DEFAULT_COLOR2;
			drawGradient();
		}
		
		public function paintRed():void
		{
			_color1 = _redColor1;
			_color2 = _redColor2;
			drawGradient();
		}
		public function paintGreen():void
		{
			_color1 = _greenColor1;
			_color2 = _greenColor2;
			drawGradient();
		}
		
	}
	
}