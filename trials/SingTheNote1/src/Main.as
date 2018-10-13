package 
{
	import com.leopanigo.audio_processing.SpectrumAnalyzer;
	import com.leopanigo.audio_processing.ToneSynthesis;
	import com.leopanigo.components.buttons.PlayButtonScreen;
	import com.leopanigo.components.events.RangeReadyEvent;
	import com.leopanigo.components.screens.CheckRangeScreen;
	import com.leopanigo.components.screens.GameScreen;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.PressAndTapGestureEvent;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	//different dimensions -> to test and see how it is seen on screen
	//[SWF(width='1200', height='800', frameRate='30', backgroundColor='0x050505')]
	//[SWF(width='800', height='600', frameRate='30', backgroundColor='0x050505')]
	//[SWF(width='960', height='640', frameRate='30', backgroundColor='0x050505')]
	//[SWF(width='640', height='480', frameRate='30', backgroundColor='0x050505')]
	[SWF(width='320', height='320', frameRate='30', backgroundColor='0x050505')]
	
	public class Main extends Sprite 
	{
		
		//private var spect:SpectrumAnalyzer;
		private var _w:Number, _h:Number;
		//Screens
		
		private var checkRangeScren:CheckRangeScreen; //-> this one is ToneSynthesis be thought about!!
		
		private var gameScreen:GameScreen;
		private var playButtonScreen:PlayButtonScreen; 
		
		private var checkRange:CheckRangeScreen;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_w = stage.stageWidth;
			_h = stage.stageHeight;
			
			//gameScreen = new GameScreen(_w, _h);
			//gameScreen.x = 0;
			//gameScreen.y = 0;
			//addChild(gameScreen);

			checkRange = new CheckRangeScreen(_w, _h);
			checkRange.addEventListener(RangeReadyEvent.RANGE_READY_EVENT, onRangeReady);
			addChild(checkRange);
			
			playButtonScreen = new PlayButtonScreen(_w, _h, 0x303030, 0x5f5f5f);
			addChild(playButtonScreen);
			playButtonScreen.addEventListener(MouseEvent.CLICK, onPlay);
		}
		

		private function onPlay(e:MouseEvent = null):void
		{
			playButtonScreen.removeEventListener(MouseEvent.CLICK, onPlay);
			//addEventListener(MouseEvent.CLICK, onPause);
			removeChild(playButtonScreen);
			//gameScreen.play();
			checkRange.play();
		}

		
		private function onRangeReady(e:RangeReadyEvent):void
		{
			removeChild(checkRange);
			checkRange = null;
			
			//should show a result screen to tell the people the range and what cathegory are they bass, baritone, tenor, ....
			
			gameScreen = new GameScreen(_w, _h);
			gameScreen.x = 0;
			gameScreen.y = 0;
			gameScreen.MIN_FREQ = e.minFreq;
			gameScreen.MAX_FREQ = e.maxFreq;
			addChild(gameScreen);
			gameScreen.play();
		}
		
	}
	
}