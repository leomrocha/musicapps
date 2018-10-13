package com.leopanigo.components.screens 
{
	import com.leopanigo.components.tuner.SimpleTuner;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class TunerScreen extends Sprite 
	{
		private var _w:Number, _h:Number;
		
		private var simpleTuner:SimpleTuner;
		private var background:Shape;
		private var _bgc:uint;
		
		//TODO add instrument selection ->to make the best selection for tuning for that instrument
		//TODO add tune selection -> to be able to see the different posibilities of tuning for a certain instrument
		
		public function TunerScreen(w:Number, h:Number, backgroundColour:uint = 0x000000) 
		{
			_w = w;
			_h = h;
			_bgc = backgroundColour;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//

			background = new Shape();
			background.graphics.beginFill(_bgc); 
			background.graphics.drawRect(0, 0, _w, _h); // (x spacing, y spacing, width, height)
			background.graphics.endFill(); // not always needed but I like to put it in to end the fill
			background.alpha = 0.75;
			addChild(background);
			
			var w:Number = 0.3 * _w;
			var h:Number = 0.8 * _h;
			
			simpleTuner = new SimpleTuner(w, h);
			simpleTuner.x = 0.05 * _w;
			simpleTuner.y = 0.1 * _h;
			//simpleTuner.start();
			addChild(simpleTuner);
		}
		
	}

}