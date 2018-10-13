package com.tools.SimpleTunerGui.gui_elements 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PlayButtonScreen extends Sprite 
	{
		private var playButton:GradientButton;
		private var background:Shape;
		
		public function PlayButtonScreen() 
		{
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
			background.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight); // (x spacing, y spacing, width, height)
			background.graphics.endFill(); // not always needed but I like to put it in to end the fill
			background.alpha = 0.75;
			addChild(background);
			//button
			playButton = new GradientButton("TUNE", stage.stageWidth / 3.0, stage.stageHeight / 2.0, 25);
			playButton.x = stage.stageWidth / 3.0;
			playButton.y = stage.stageHeight / 4.0;
			addChild(playButton);
			
		}
		
	}

}