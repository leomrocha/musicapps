package com.tools.SimpleTunerGui
{
	import com.tools.SimpleTunerGui.gui_elements.PlayButtonScreen;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	//[SWF(width = "320", height = "480")]
	[SWF(width='400', height='70', frameRate='30', backgroundColor='0xffffff')]
	public class Main extends Sprite 
	{
		private const  MIN_FREQ:Number = 28.0;
		private const  MAX_FREQ:Number = 1000.0;
		private var simpleTuner:SimpleTunerGui;
		private var startScreen:PlayButtonScreen;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		
			//stage.align = StageAlign.TOP_LEFT;
			//stage.scaleMode = StageScaleMode.NO_SCALE; //so it does not scale automatically :)
			
			simpleTuner = new SimpleTunerGui(stage.stageWidth, stage.stageHeight, MIN_FREQ, MAX_FREQ);
			simpleTuner.addEventListener(MouseEvent.CLICK, onPause);
			addChild(simpleTuner);
			
			startScreen = new PlayButtonScreen();
			startScreen.addEventListener(MouseEvent.CLICK, onPlay);
			addChild(startScreen);
		}
		
		private function onPlay(e:MouseEvent = null):void
		{
			if (startScreen.parent)
				removeChild(startScreen)
			simpleTuner.start();
		}
		
		private function onPause(e:MouseEvent = null):void
		{
			simpleTuner.stop();5
			//if (! startScreen.parent)
			addChild(startScreen)
		}
		
	}
	
}