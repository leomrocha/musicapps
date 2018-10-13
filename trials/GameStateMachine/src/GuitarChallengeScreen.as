package  
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class GuitarChallengeScreen extends ChallengeScreen
	{
		//protected var _guitarLevel:GuitarTabLevelSprite;
		
		public function GuitarChallengeScreen(instrument:String, level:GuitarTabLevelSprite) 
		{
				//_guitarLevel = level;
				super(instrument, level);
		}


		protected override function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, this.init);
			trace("GuitarChallengeScreen added to stage");
			buttons = new Dictionary();
			//Screen  Dimensions
			x0 = 0;
			y0 = 0;
			widthScreen = stage.stageWidth;
			heightScreen = stage.stageHeight;
			var x0p:Number = widthScreen - 50;
			var y0p:Number = heightScreen -10;
			var backButton:GenericGameButton = new GenericGameButton("Back", x0p, y0p);
			backButton.addEventListener(MouseEvent.CLICK,backButtonSelected);
			addChild(backButton);
			y0p -= 70;
			var stopButton:GenericGameButton = new GenericGameButton("Stop", x0p, y0p);
			stopButton.addEventListener(MouseEvent.CLICK,stopButtonSelected);
			addChild(stopButton);
			y0p -= 70;
			var playButton:GenericGameButton = new GenericGameButton("Start", x0p, y0p);
			playButton.addEventListener(MouseEvent.CLICK,playButtonSelected);
			addChild(playButton);
			//add statistics tracking text
			measuresTxt = new TextField();
			measuresTxt.x = widthScreen - 50;
			measuresTxt.y = 10;
			measuresTxt.maxChars = 6;
			measuresTxt.text = "None";
			addChild(measuresTxt);
			scoreTxt = new TextField();
			scoreTxt.x = widthScreen - 50;
			scoreTxt.y = 30;
			scoreTxt.maxChars = 6;
			scoreTxt.text = "None";
			addChild(scoreTxt);
			//current BPM
			bpmTxt = new TextField();
			bpmTxt.x = widthScreen * 0.92;
			bpmTxt.y = 150;
			bpmTxt.maxChars = 6;
			bpmTxt.text = "BPM";
			addChild(bpmTxt);
			//augment and diminish bpm
			
			var incrementBpmButton:GenericGameButton = new GenericGameButton("+5 BPM", widthScreen*0.92, 150);
			incrementBpmButton.addEventListener(MouseEvent.CLICK,incrementBpmButtonSelected);
			addChild(incrementBpmButton);
			var decrementBpmButton:GenericGameButton = new GenericGameButton("-5 BPM", widthScreen*0.92, 250);
			decrementBpmButton.addEventListener(MouseEvent.CLICK,decrementBpmButtonSelected);
			addChild(decrementBpmButton);
			//current Cents Accepted Error
			centsTxt = new TextField();
			centsTxt.x = widthScreen * 0.92;
			centsTxt.y = 300;
			centsTxt.maxChars = 6;
			centsTxt.text = "Cents";
			addChild(centsTxt);
			//modify it
			var incrementCentsButton:GenericGameButton = new GenericGameButton("+5 cents tolerance", widthScreen*0.92, 300);
			incrementCentsButton.addEventListener(MouseEvent.CLICK,incrementCentsButtonSelected);
			addChild(incrementCentsButton);
			//buttons["incrementCentsButton"] = incrementCentsButton;
			var decrementCentsButton:GenericGameButton = new GenericGameButton("-5 cents tolerance", widthScreen*0.92, 400);
			decrementCentsButton.addEventListener(MouseEvent.CLICK,decrementCentsButtonSelected);
			addChild(decrementCentsButton);			
			//add LevelSprite, but behind the TEXT and buttons!!! WARNING not to hide the other elements!!!
			//TODO change the way a level is loaded!!!
			addChildAt(_level, 5);
			_level.x = 0;
			_level.y = 0;
			_level.width = widthScreen * 0.9;
			_level.height = heightScreen * 0.5;
			//_guitarLevel.x = 0;
			//_guitarLevel.y = heightScreen * 0.61;
			//_guitarLevel.width = widthScreen * 0.9;
			//_guitarLevel.height = heightScreen * 0.49;
			//addChildAt(_guitarLevel, 6)
			//_level.addEventListener(LevelSprite.LEVEL_UPDATE_SCREEN_EVENT, update);
			_tickTime = _level.tickTime;
			tickTimer = new Timer(_tickTime * 1000);
			tickTimer.addEventListener(TimerEvent.TIMER, update);
			update();
		}

		
		protected override function decrementCentsButtonSelected(e:MouseEvent):void 
		{
			_level.centsTolerance = _level.centsTolerance - 5;
			//_guitarLevel.centsTolerance = _guitarLevel.centsTolerance - 5;
			//_guitarLevel.redraw();
			_level.redraw();
			update();
		}
		
		protected override function incrementCentsButtonSelected(e:MouseEvent):void 
		{
			_level.centsTolerance = _level.centsTolerance + 5;
			//_guitarLevel.centsTolerance = _guitarLevel.centsTolerance + 5;
			//_guitarLevel.redraw();
			_level.redraw();
			update();
		}
		
		protected override function decrementBpmButtonSelected(e:MouseEvent):void 
		{
			_level.bpm = _level.bpm - 5;
			//_guitarLevel.bpm = _guitarLevel.bpm - 5;
			_level.redraw();
			//_guitarLevel.redraw();
			update();
		}
		
		protected override function incrementBpmButtonSelected(e:MouseEvent):void 
		{
			_level.bpm = _level.bpm + 5;
			//_guitarLevel.bpm = _guitarLevel.bpm +5;
			_level.redraw();
			//_guitarLevel.redraw();
			update();
		}
		
		protected override function update(e:Event=null):void
		{
			trace("updating guitar screen challenge");
			//update frequency readings
			var f:Number = spect.freq;
			_level.update(f);
			//update time
			//update volume readings
			//update statistics
			measuresTxt.text = _level.measuresCount.toString();
			scoreTxt.text = _level.scoreCount.toString();
			bpmTxt.text = _level.bpm.toString();
			centsTxt.text = _level.centsTolerance.toString();
		}
		
		protected override function playButtonSelected(e:MouseEvent):void 
		{
			trace("Play!!");
			tickTimer.start();
			spect.start();
			_level.start();
			//_guitarLevel.start();
		}
		
		protected override function stopButtonSelected(e:MouseEvent):void 
		{
			trace("stop :(");
			tickTimer.stop();
			spect.stop();
			_level.stop();
			//_guitarLevel.stop();
			//stop
			
		}
		protected override function backButtonSelected(e:MouseEvent):void 
		{
			if (tickTimer.running)
			{
				tickTimer.stop();
				spect.stop();
				
			}
			_level.stop();
			//_guitarLevel.stop();
			dispatchEvent(new GameEvent(GameEvent.BACK_BUTTON_EVENT));
		}
	}

}