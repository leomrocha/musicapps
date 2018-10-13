package 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	//import spark.components.*;
		
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class MainMenu extends GameStateSprite  
	{

		private var background:Shape;

		private var buttons:Dictionary;
				
		public function MainMenu()
		{
			//create buttons
			//if (stage) init(); //WARNING!!! This is necessary to be sure about dimensions
			//else addEventListener(Event.ADDED_TO_STAGE, init); //NOT necessqry,; done in pqrent clqss
		}
		
		protected override function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, this.init);
			trace("MainMenu added to stage");
			buttons = new Dictionary();
			//Screen  Dimensions
			x0 = 0;
			y0 = 0;
			widthScreen = stage.stageWidth;
			heightScreen = stage.stageHeight;
			//////////////////////////
			//add to screen relocate and redimension buttons
			// TODO this buttons are for this first prototype, later spark skinning should be used with a more complex thing
			var x0p:Number = widthScreen / 2;
			var y0p:Number = heightScreen / 2;
			var instrumentSelectionButton:GenericGameButton = new GenericGameButton("play", x0p, y0p);
			//playButton.buttonMode=true;
			instrumentSelectionButton.addEventListener(MouseEvent.CLICK,playPressed);
			addChild(instrumentSelectionButton);
			y0p += 50;
			var settingsButton:GenericGameButton = new GenericGameButton("settings", x0p, y0p);
			settingsButton.addEventListener(MouseEvent.CLICK,settingsPressed);
			addChild(settingsButton);
			buttons["instrumentSelectionButton"] = instrumentSelectionButton;
			buttons["settingsButton"] = settingsButton;
		}
		
		 public override function redimension(w:uint, h:uint):void
		{
			widthScreen = w;
			heightScreen = h;
			//TODO
			//removeChild(background);
			//background = new Shape();
			//background.graphics.beginFill(0xAAAAAA, 0.8); 
			//background.graphics.drawRect(0,0, w, h);
			//background.graphics.endFill();
			//addChild(background);
			//relocate and redimension buttons
		}
		
		private function playPressed(e:Event = null):void
		{
			trace("play button pressed");
			//var ed:GameStateEvents = new GameStateEvents()
			dispatchEvent(new GameEvent(GameEvent.CHANGE_GAME_STATE, GameEvent.INSTRUMENT_SELECTION_SCREEN));
		}
		private function settingsPressed(e:Event = null):void
		{
			trace("settings button pressed");
			//var ed:GameStateEvents = new GameStateEvents()
			dispatchEvent(new GameEvent(GameEvent.CHANGE_GAME_STATE, GameEvent.SETTINGS_MAIN_SCREEN));
		}
	}
	
}