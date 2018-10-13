package com.tools.SimpleMetronome.gui_components 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CircleBullet extends Sprite 
	{
		private var _radius:Number;
		private static const BACKGROUNDCOLOR_OFF:Number = 0x070707;
		private static const BACKGROUNDCOLOR_ON:Number = 0x00ff00;
		private var _xpos:Number;
		private var _ypos:Number;
		
		private var isOn:Boolean;
		public function CircleBullet(radius:Number, xpos:Number = 0, ypos:Number = 0) 
		{
			_radius = radius;
			_xpos = xpos;
			_ypos = ypos;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			off();
			isOn = false;
		}
		public function on():void
		{
			this.graphics.beginFill(BACKGROUNDCOLOR_ON, 0.8); 
			this.graphics.lineStyle(1, 0x888080);
			this.graphics.drawCircle(_xpos,_ypos,_radius);
			this.graphics.endFill();
			isOn = true;
			
		}
		
		public function off():void
		{
			this.graphics.beginFill(BACKGROUNDCOLOR_OFF, 0.8); 
			this.graphics.lineStyle(1, 0x888080);
			this.graphics.drawCircle(0,0,_radius);
			this.graphics.endFill();
			isOn = false;
		}
	}

}