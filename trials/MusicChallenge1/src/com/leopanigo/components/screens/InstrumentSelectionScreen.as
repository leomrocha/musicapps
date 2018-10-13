package com.leopanigo.components.screens 
{
	import adobe.utils.CustomActions;
	import com.leopanigo.components.buttons.GradientButton;
	import com.leopanigo.components.events.InstrumentSelectedEvent;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class InstrumentSelectionScreen extends Sprite 
	{

		private var _w:Number, _h:Number;
		//private var iconButtons:Vector.<IconButton>;//TODO future add more instruments, now only voice and guitar
		private var guitarButton:GradientButton;
		private var voiceButton:GradientButton;
		
		private var background:Shape;
		private var _bgc:uint;
		private var _buttonC1:uint, _buttonC2:uint;
		
		public function InstrumentSelectionScreen(w:Number, h:Number, 
													backgroundColour:uint = 0x000000,
													buttonColour1:uint = 0x303030,
													buttonColour2:uint = 0x5f5f5f) 
		{
			_w = w;
			_h = h;
			_bgc = backgroundColour;
			_buttonC1 = buttonColour1;
			_buttonC2 = buttonColour2;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			background = new Shape();
			background.graphics.beginFill(_bgc); 
			background.graphics.drawRect(0, 0, _w, _h); // (x spacing, y spacing, width, height)
			background.graphics.endFill(); // not always needed but I like to put it in to end the fill
			background.alpha = 0.75;
			addChild(background);
			
			//TODO for when I make more buttons for more instruments
			//var w:Number = 0.2 * _w;
			//var h:Number = 0.35 * _h;
			
			var w:Number = 0.3 * _w;
			var h:Number = 0.3 * _h;
			
			//TODO make a more efficient method with dynamic ammount of buttons!!
			//TODO change to IconButtons with the corresponding icon
			guitarButton = new GradientButton("guitar", w, h, 15, _buttonC1, _buttonC2);
			guitarButton.x = 0.1 * _w;
			guitarButton.y = 0.35 * _h;
			guitarButton.addEventListener(MouseEvent.CLICK, onGuitarClick);
			addChild(guitarButton);
			
			voiceButton = new GradientButton("voice", w, h, 15, _buttonC1, _buttonC2);
			voiceButton.x = 0.6 * _w;
			voiceButton.y = 0.35 * _h;
			voiceButton.addEventListener(MouseEvent.CLICK, onVoiceClick);
			addChild(voiceButton);
			
		}
		
		private function onGuitarClick(e:MouseEvent):void
		{
			dispatchEvent(new InstrumentSelectedEvent(InstrumentSelectedEvent.INSTRUMENT_GUITAR_SELECTED));
		}

		private function onVoiceClick(e:MouseEvent):void
		{
			dispatchEvent(new InstrumentSelectedEvent(InstrumentSelectedEvent.INSTRUMENT_VOICE_SELECTED));
		}
		
	}

}