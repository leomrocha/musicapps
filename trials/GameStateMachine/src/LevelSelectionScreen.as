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
	public class LevelSelectionScreen extends GameStateSprite 
	{
		private var _instrument:String = "voice";
		private var buttons:Dictionary;

		public function LevelSelectionScreen() 
		{
			
		}

		//TODO the buttons here are only a pre-alfa version to see the possible results!!
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
			var doScale:GenericGameButton = new GenericGameButton("Play DO scale", x0p, y0p);
			doScale.addEventListener(MouseEvent.CLICK,doSelected);
			addChild(doScale);
			//voice
			x0p += 100;
			//y0p += 50;
			var chromaticScale:GenericGameButton = new GenericGameButton("Chromatic Scale", x0p, y0p);
			chromaticScale.addEventListener(MouseEvent.CLICK,chromaticSelected);
			addChild(chromaticScale);
			//bass
			x0p += 100;
			//y0p += 50;
			var solScale:GenericGameButton = new GenericGameButton("Sol Scale", x0p, y0p);
			solScale.addEventListener(MouseEvent.CLICK,solSelected);
			addChild(solScale);
			x0p -= 300;
			y0p += 50;
			var practice:GenericGameButton = new GenericGameButton("Free Practice", x0p, y0p);
			practice.addEventListener(MouseEvent.CLICK,practiceSelected);
			addChild(practice);
			////voice
			//x0p += 100;
			//y0p += 50;
			//var miScale:GenericGameButton = new GenericGameButton("Play MI Scale", x0p, y0p);
			//miScale.addEventListener(MouseEvent.CLICK,voiceSelected);
			//addChild(miScale);
			////bass
			//x0p += 100;
			//y0p += 50;
			//var faScale:GenericGameButton = new GenericGameButton("Play FA Scale", x0p, y0p);
			//faScale.addEventListener(MouseEvent.CLICK,bassSelected);
			//addChild(faScale);
			
			buttons["doScale"] = doScale;
			buttons["chromaticScale"] = chromaticScale;
			buttons["solScale"] = solScale;
			buttons["practice"] = practice;
			//buttons["miScale"] = miScale;
			//buttons["faScale"] = faScale;
			buttons["backButton"] = backButton;
			
		}
		
		private function practiceSelected(e:MouseEvent):void 
		{
			dispatchEvent(new LevelSelectedEvent(LevelSelectedEvent.LEVEL_SELECTED_EVENT,"practice", _instrument));
		}
		
		private function backButtonSelected(e:MouseEvent):void 
		{
			dispatchEvent(new GameEvent(GameEvent.BACK_BUTTON_EVENT));
		}
		
		public function set instrument(value:String):void 
		{
			trace("set instrument", value);
			//erase previous things
			//check databases and all that crap
			_instrument = value;
			//reload levels and all that ... blablabla For the moment load a couple of simple levels with a button
		}
		
		private function doSelected(e:MouseEvent = null):void
		{
			dispatchEvent(new LevelSelectedEvent(LevelSelectedEvent.LEVEL_SELECTED_EVENT,"do scale", _instrument));
		}
		private function solSelected(e:MouseEvent = null):void
		{
			dispatchEvent(new LevelSelectedEvent(LevelSelectedEvent.LEVEL_SELECTED_EVENT,"sol scale", _instrument));
		}
		private function chromaticSelected(e:MouseEvent = null):void
		{
			dispatchEvent(new LevelSelectedEvent(LevelSelectedEvent.LEVEL_SELECTED_EVENT,"chromatic scale", _instrument));
		}
		
		
	}

}