package com.leopanigo.components.screens 
{
	import com.leopanigo.components.buttons.PlayButton;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PlayButtonScreen extends Sprite 
	{
		private var _w:Number, _h:Number;
		private var playButton:PlayButton;
		private var background:Shape;
		private var _colour1:uint, _colour2:uint, _fillColour:uint;
		
		public function PlayButtonScreen(w:Number, h:Number,colour1:uint=0x04618d, colour2:uint=0x379EE0, fillColour:uint=0xffff00) 
		{
			_w = w;
			_h = h;
			_colour1 = colour1;
			_colour2 = colour2;
			_fillColour = fillColour;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			this.buttonMode = true;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//background
			background = new Shape();
			background.graphics.beginFill(0x000000); 
			background.graphics.drawRect(0, 0, _w, _h); // (x spacing, y spacing, width, height)
			background.graphics.endFill(); // not always needed but I like to put it in to end the fill
			background.alpha = 0.75;
			addChild(background);
			//button
			playButton = new PlayButton( _w / 2.0, _h / 10.0, 45, _colour1, _colour2,"RIGHT", _fillColour);
			playButton.x = _w / 4.0;
			playButton.y = _h / 2.0 - _h / 10.0;
			addChild(playButton);
			
		}
		
	}

}