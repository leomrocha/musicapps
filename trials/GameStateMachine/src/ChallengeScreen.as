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
	public class ChallengeScreen extends GameStateSprite 
	{
		protected var spect:SpectrumAnalyzer;
		protected var tickTimer:Timer;
		protected var _tickTime:Number; // time in milliseconds of one tick = 0.3125*denominator/bpm = 1/((bpm/60)/(NoteSymbol.SEMI_FUSA/denominator))
		
		protected var buttons:Dictionary;
		protected var _instrument:String;
		//protected var _level:Vector.<NoteRect>;
		
		protected var _level:LevelSprite;
		
		//////////////////////////////////////////////////////
		/// Current game status
		//////////////////////////////////////////////////////
		protected var scorePercentual:Number; //  (scoreHits / pointsCount)/100.0 
		//protected var scoreHits:uint; //current number of points that actually hit the correct element
		//protected var pointsCount:uint;//current count of measures (points)
		protected var measures:uint = 0 ; // total number of frequency measures
		protected var measuresTxt:TextField; 
		protected var score:uint = 0; // total number of measures that touch a ToneRect;
		protected var scoreTxt:TextField; 
		
		protected var bpmTxt:TextField;
		protected var centsTxt:TextField;
		
		protected var bpm:uint = 60; // TODO add somewhere this to be able to change it
		
		protected var playing:Boolean = false;
		protected var paused:Boolean = false;
		protected var stopped:Boolean = true;
		protected var currentTime:Number = 0.0;
		//protected var ticks:uint; //number of times the update process took place
		
		////////////////////////////////////// 
		
		public function ChallengeScreen(instrument:String, level:LevelSprite)
		{
			_instrument = instrument;
			_level = level;
			spect = new SpectrumAnalyzer();
			trace("CHALLENGE!", instrument, level);
			
		}

		protected override function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, this.init);
			trace("ChallengeScreen added to stage");
			buttons = new Dictionary();
			//Screen  Dimensions
			x0 = 0;
			y0 = 0;
			widthScreen = stage.stageWidth;
			heightScreen = stage.stageHeight;
			var x0p:Number = widthScreen - 100;
			var y0p:Number = heightScreen -10;
			var backButton:GenericGameButton = new GenericGameButton("Back", x0p, y0p);
			backButton.addEventListener(MouseEvent.CLICK,backButtonSelected);
			addChild(backButton);
			x0p -= 150;
			var stopButton:GenericGameButton = new GenericGameButton("Stop", x0p, y0p);
			stopButton.addEventListener(MouseEvent.CLICK,stopButtonSelected);
			addChild(stopButton);
			x0p -= 150;
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
			_level.width = widthScreen * 0.9;
			_level.height = heightScreen * 0.9;
			//_level.addEventListener(LevelSprite.LEVEL_UPDATE_SCREEN_EVENT, update);
			_tickTime = _level.tickTime;
			tickTimer = new Timer(_tickTime * 1000);
			tickTimer.addEventListener(TimerEvent.TIMER, update);
			update();
			
		}
		
		protected function decrementCentsButtonSelected(e:MouseEvent):void 
		{
			_level.centsTolerance = _level.centsTolerance - 5;
			_level.redraw();
			update();
		}
		
		protected function incrementCentsButtonSelected(e:MouseEvent):void 
		{
			_level.centsTolerance = _level.centsTolerance + 5;
			_level.redraw();
			update();
		}
		
		protected function decrementBpmButtonSelected(e:MouseEvent):void 
		{
			_level.bpm = _level.bpm - 5;
			_level.redraw();
			update();
		}
		
		protected function incrementBpmButtonSelected(e:MouseEvent):void 
		{
			_level.bpm = _level.bpm + 5;
			_level.redraw();
			update();
		}
		
		protected function update(e:Event=null):void
		{
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
		
		protected function playButtonSelected(e:MouseEvent):void 
		{
			trace("Play!!");
			tickTimer.start();
			spect.start();
			_level.start();
			//reconfigure level to start
			//start sound recognition system
			//start playing
		}
		
		protected function stopButtonSelected(e:MouseEvent):void 
		{
			trace("stop :(");
			tickTimer.stop();
			spect.stop();
			_level.stop();
			//stop
			
		}
		protected function backButtonSelected(e:MouseEvent):void 
		{
			if (tickTimer.running)
			{
				tickTimer.stop();
				spect.stop();
				
			}
			_level.stop();
			dispatchEvent(new GameEvent(GameEvent.BACK_BUTTON_EVENT));
		}
		
		public function get instrument():String 
		{
			return _instrument;
		}
		
		public function set instrument(value:String):void 
		{
			_instrument = value;
		}
		
		public function get level():LevelSprite
		{
			return _level;
		}
		
		public function set level(value:LevelSprite):void 
		{
			_level = value;
		}
		
		
	}

}