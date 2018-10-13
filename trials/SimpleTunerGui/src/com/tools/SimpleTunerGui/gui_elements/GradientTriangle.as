package com.tools.SimpleTunerGui.gui_elements
{

	import adobe.utils.CustomActions;
	import com.tools.SimpleTunerGui.music_concepts.Note;
	import flash.display.GradientType;
	import flash.display.Shape;
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
	public class  GradientTriangle extends Sprite
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
		protected var _w:uint;
		protected var _h:uint;
		protected var _pointRight:Boolean;
		
		protected var colors:Object;
		
		protected var triangleShape:Shape;
		
		public function GradientTriangle( w:Number, h:Number, pointRight:Boolean = true )
		{
			_color1 = DEFAULT_COLOR1;
			_color2 = DEFAULT_COLOR2;
			_pointRight = pointRight;
			
			_w = w;
			_h = h;
			
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
		}
		
		public function drawGradient():void 
		{
			var m:Matrix = new Matrix();
			if (triangleShape!= null && triangleShape.parent)
			{
				removeChild(triangleShape);
			}
			triangleShape = new Shape();
			
			m.createGradientBox(_w, _h, 0, 0, 0);
			//triangleShape.graphics.beginGradientFill(GradientType.LINEAR, [colors.left, colors.right], 
			//									[1, 1], [0x00, 0xFF], m, SpreadMethod.REFLECT);
			if (_pointRight)
			{
				triangleShape.graphics.lineStyle(1)
				triangleShape.graphics.beginFill(_color1);
				triangleShape.graphics.moveTo(0, 0);
				triangleShape.graphics.lineTo(_w,_h/2);
				triangleShape.graphics.lineTo(0, _h);
				triangleShape.graphics.lineTo(0, 0);
			}
			else
			{
				triangleShape.graphics.lineStyle(1)
				triangleShape.graphics.beginFill(_color1);
				triangleShape.graphics.moveTo(_w, 0);
				triangleShape.graphics.lineTo(_w,_h);
				triangleShape.graphics.lineTo(0, _h/2);
				triangleShape.graphics.lineTo(_w, 0);
			}

			addChild(triangleShape);
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