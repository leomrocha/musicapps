package com.leopanigo.components.screens.sub_components 
{
	import com.leopanigo.components.buttons.GradientButton;
	import com.leopanigo.components.buttons.PauseButton;
	import com.leopanigo.components.buttons.PlayButton;
	import com.leopanigo.components.displays.text_displays.TimeDisplay;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PracticePlayMenu extends Sprite 
	{
		private var _w:Number, _h:Number;
		
		//awfull!!
		public var playButton:PlayButton; 
		public var pauseButton:PauseButton; 
		
		private var currentTime:TimeDisplay;
		private var totalTime:TimeDisplay;
		
		private var increaseX:PlayButton;
		private var decreaseX:PlayButton;
		
		private var displayX:TextField;
		
		public function PracticePlayMenu(w:Number, h:Number) 
		{
			_w = w;
			_h = h;
			
			playButton = new PlayButton(_w * 0.5, _h * 0.32, 10, 0x303030, 0x5f5f5f);
			playButton.x = 0.25 * _w;
			playButton.y = 0.04 * _h;
			addChild(playButton);
			
			pauseButton = new PauseButton(_w * 0.5, _h * 0.32, 10, 0x303030, 0x5f5f5f);
			pauseButton.x = 0.25 * _w;
			pauseButton.y = 0.04 * _h;
			
			currentTime = new TimeDisplay(0.5 * _w, 0.20 * _h, 15, 0xffff66);
			currentTime.x = 0.25 * _w;
			currentTime.y = 0.4 * _h;
			addChild(currentTime);
			
			totalTime = new TimeDisplay(0.25 * _w, 0.10 * _h, 10, 0xaaaa44);
			totalTime.x = 0.25 * _w;
			totalTime.y = 0.65 * _h;
			addChild(totalTime);
			
			increaseX = new PlayButton(20, 30, 5, 0x303030, 0x5f5f5f);
			increaseX.x = 0.75 * _w -20;
			increaseX.y = 0.8 * _h;
			addChild(increaseX)
			
			displayX = new TextField();
			displayX.x = 0.40 * _w;
			displayX.y = 0.8 * _h;
			//displayX.width = 0;
			//displayX.height = 15;
			displayX.text = "1.0x";
			displayX.textColor = 0xEEEE55;
			
			
			
			addChild(displayX);
			
			decreaseX = new PlayButton(20, 30, 5, 0x303030, 0x5f5f5f, PlayButton.BUTTON_DIRECTION_LEFT);
			decreaseX.x = 0.25 * _w;
			decreaseX.y = 0.8 * _h;
			addChild(decreaseX);
			
			//playButton.addEventListener(MouseEvent.CLICK, onPlay);
			
			increaseX.addEventListener(MouseEvent.CLICK, onIncrease);
			decreaseX.addEventListener(MouseEvent.CLICK, onDecrease);
		}
		
		public function onPlay(e:MouseEvent = null):void
		{
			//playButton.removeEventListener(MouseEvent.CLICK, onPlay);
			//parent.play(); //WARNING!!! should be done better than this!!
			addChild(pauseButton);
			removeChild(playButton);
			//pauseButton.addEventListener(MouseEvent.CLICK, onPause);
		}
		
		public function onPause(e:MouseEvent = null):void
		{
			//pauseButton.removeEventListener(MouseEvent.CLICK, onPause);
			//parent.pause();//WARNING!!! should be done better than this!!
			addChild(playButton);
			removeChild(pauseButton);
			//playButton.addEventListener(MouseEvent.CLICK, onPlay);
		}
		
		private function onIncrease(e:MouseEvent = null):void
		{
			//TODO
		}
		private function onDecrease(e:MouseEvent = null):void
		{
			//TODO
		}
	}

}