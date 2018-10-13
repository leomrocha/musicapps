package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.Event;

	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class MeasurePoint extends Shape 
	{
		private var BACKGROUNDCOLOR:uint = 0xAA0000;
		private var MATCH_BACKGROUNDCOLOR:uint = 0xAA0000;

		private var radius:Number;
		
		private var instrument:String; // instrument to play when synthetizing sound
		
		private var _tick0:Number; //time at which was played
		private var _freq:Number; // frequency played
		private var currentTick:Number;
	
		private var midinote:uint;  //note representation
		private var note:String; //name ... stil to decide if A B C D E ... or Do Re Mi Fa Sol La Si
		private var octave:uint; 
		
		private var isHighlighted:Boolean; // changes in color 
		
		public function MeasurePoint( freq:Number, tick0:Number )
		{
			this._tick0 = tick0;
			this._freq = freq;
			//
		}
		
		public function highlight( hl:Boolean ):void
		{
			this.graphics.beginFill(MATCH_BACKGROUNDCOLOR, 0.5); 
			this.graphics.drawCircle(0, 0, radius+1);
			this.graphics.endFill();
		}
		
		public function redraw(xpos:Number, ypos:Number, radius:Number = 2):void
		{
			x = xpos;
			y = ypos;
			this.radius = radius;
			if (stage) privateRedraw();
			else addEventListener(Event.ADDED_TO_STAGE, privateRedraw);
		}
		
		private function privateRedraw(e:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, privateRedraw);
			this.graphics.beginFill(BACKGROUNDCOLOR, 0.8); 
			this.graphics.drawCircle(0, 0, radius);
			this.graphics.endFill();
		}
		
		public function get freq():Number 
		{
			return _freq;
		}
		
		public function get tick0():Number 
		{
			return _tick0;
		}
		
	}
	
}