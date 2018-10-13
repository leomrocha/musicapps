package 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PlayScreen extends GameStateSprite 
	{
		private var background:Shape;

		private var buttons:Dictionary;
		public function PlayScreen()
		{
			
		}

		protected override function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, this.init);
			trace("PlayScreen added to stage");
			buttons = new Dictionary();
			//Screen  Dimensions
			x0 = 0;
			y0 = 0;
			widthScreen = stage.stageWidth;
			heightScreen = stage.stageHeight;
			var x0p:Number = widthScreen - 150;
			var y0p:Number = heightScreen -50;
			var backButton:GenericGameButton = new GenericGameButton("Back", x0p, y0p);
			backButton.addEventListener(MouseEvent.CLICK,backButtonSelected);
			addChild(backButton);
			//////////////////////////
			//add to screen relocate and redimension buttons
			// TODO this buttons are for this first prototype, later spark skinning should be used with a more complex thing
			x0p = widthScreen / 2;
			y0p = heightScreen / 2;
			x0p -= 100;
			y0p -= 50;
			//guitar
			var guitarButton:GenericGameButton = new GenericGameButton("guitar", x0p, y0p);
			guitarButton.addEventListener(MouseEvent.CLICK,guitarSelected);
			addChild(guitarButton);
			//voice
			x0p += 100;
			y0p += 50;
			var voiceButton:GenericGameButton = new GenericGameButton("voice", x0p, y0p);
			voiceButton.addEventListener(MouseEvent.CLICK,voiceSelected);
			addChild(voiceButton);
			//bass
			x0p += 100;
			y0p += 50;
			var bassButton:GenericGameButton = new GenericGameButton("bass", x0p, y0p);
			bassButton.addEventListener(MouseEvent.CLICK,bassSelected);
			addChild(bassButton);
			//ukulele
			//violin
			//piano
			//
			buttons["guitarButton"] = guitarButton;
			buttons["voiceButton"] = voiceButton;
			buttons["bassButton"] = bassButton;
			buttons["backButton"] = backButton;
		}

		private function backButtonSelected(e:MouseEvent):void 
		{
			dispatchEvent(new GameEvent(GameEvent.BACK_BUTTON_EVENT));
		}
		
		private function guitarSelected(e:MouseEvent = null):void
		{
			dispatchEvent(new InstrumentSelectedEvent(InstrumentSelectedEvent.INSTRUMENT_SELECTED_EVENT,"guitar"));
		}
		private function bassSelected(e:MouseEvent = null):void
		{
			dispatchEvent(new InstrumentSelectedEvent(InstrumentSelectedEvent.INSTRUMENT_SELECTED_EVENT,"bass"));
		}
		private function voiceSelected(e:MouseEvent = null):void
		{
			dispatchEvent(new InstrumentSelectedEvent(InstrumentSelectedEvent.INSTRUMENT_SELECTED_EVENT,"voice"));
		}
		
	}
	
}