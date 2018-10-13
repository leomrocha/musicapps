package com.tools
{
	import com.tools.SimpleMetronome.MetronomeGui;
	import com.tools.SimpleMetronome.SimpleMetronome;
	import com.tools.SimpleMetronome.SimpleMetronomeGui;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	[SWF(width='400', height='100', frameRate='30', backgroundColor='0xeeeeee')]
	public class Main extends Sprite 
	{
		private var guiMetronome:SimpleMetronomeGui;
		//private var guiMetronome:MetronomeGui;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			guiMetronome = new SimpleMetronomeGui(stage.stageWidth, stage.stageHeight);
			//guiMetronome = new MetronomeGui(stage.stageWidth, stage.stageHeight);			
			addChild(guiMetronome);
		}
		
	}
	
}