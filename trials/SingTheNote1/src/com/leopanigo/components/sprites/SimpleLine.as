package com.leopanigo.components.sprites 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class SimpleLine extends Sprite 
	{
	
		public static const LINE_DIRECTION_UP:String = "UP";
		public static const LINE_DIRECTION_DOWN:String = "DOWN";
		public static const LINE_DIRECTION_LEFT:String = "LEFT";
		public static const LINE_DIRECTION_RIGHT:String = "RIGHT";
		
		private var _dir:String; //1 right, 2 left, 3 up, 4 down direction of the arrow
		private var _colour:uint;
		private var _lenght:Number;
		private var _w:Number;
		
		public function SimpleLine(length:Number, width:Number = 1, colour:uint = 0xa0a040, direction:String = SimpleLine.LINE_DIRECTION_DOWN) 
		{
			_lenght = length;
			_dir = direction;
			_colour = colour;
			_w = width;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			
			var line:Shape = new Shape();
			line.graphics.lineStyle( _w, _colour, 0.7 );
			
			if (_dir == SimpleLine.LINE_DIRECTION_RIGHT)
			{
				line.graphics.moveTo(0, 0);
				line.graphics.lineTo(_lenght , 0);
				
			}else if (_dir == SimpleLine.LINE_DIRECTION_LEFT)
			{
				line.graphics.moveTo(0, 0);
				line.graphics.lineTo(-_lenght , 0);
			}else if (_dir == SimpleLine.LINE_DIRECTION_DOWN)
			{
				line.graphics.moveTo(0, 0);
				line.graphics.lineTo(0 , _lenght);
			}else if (_dir == SimpleLine.LINE_DIRECTION_UP)
			{
				line.graphics.moveTo(0, 0);
				line.graphics.lineTo(0 , -_lenght);
			}
			addChild(line);


		}
		
	}

}