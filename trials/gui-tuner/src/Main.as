package 
{
	import com.music_concepts.Note;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import com.audio_processing.*;
	import com.gui_elements.*;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	//[SWF(width = "320", height = "480")]
	[SWF(width='320', height='480', frameRate='30', backgroundColor='0xeeeeee')]
	public class Main extends Sprite 
	{
		private const  MIN_FREQ:Number = 28.0;
		private const  MAX_FREQ:Number = 1000.0;
		private var spect:SpectrumAnalyzer;
		private var noteMapper:NoteMapper;
		private var m_timer:Timer;
		private var playButton:PlayButtonScreen;
		private var pauseButton:GradientButton;
		private var bottomButtonContainer:BottomButtonContainer;
		private var gradientButtonScroller:GradientButtonScroller;
		private var needle:Needle;
		private var errorCents:TextField;
		private var errorTxt:TextField;
		private var errorHz:TextField;
		private var currF0:TextField;
		private const UPDATE_PERIOD:int = 100; //milliseconds
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//stage properties
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE; //so it does not scale automatically :)
			///////Processing  
			spect = new SpectrumAnalyzer();
			noteMapper = new NoteMapper();
			/////////GUI
			//Bottom buttons
			bottomButtonContainer = new BottomButtonContainer();
			addChild(bottomButtonContainer);
			//b.height = 30;
			//b.width = stage.stageWidth;
			//b.scaleX = 1;
			//b.scaleY = 1;
			//b.scaleZ = 1;
			bottomButtonContainer.x = 0;
			bottomButtonContainer.y = stage.stageHeight * 0.75;
			//top buttons
			gradientButtonScroller = new GradientButtonScroller();
			addChild(gradientButtonScroller);
			gradientButtonScroller.x = 0;
			gradientButtonScroller.y = 2;
			//pause button (or surface ...)
			pauseButton = new GradientButton("Pause", 50, 30, 15 , 0x505050, 0xaaaaaa);
			addChild(pauseButton);
			pauseButton.x = stage.stageWidth * 0.1;
			pauseButton.y = stage.stageHeight * 0.67;
			pauseButton.addEventListener(MouseEvent.CLICK, onPause);
			//Text ->frequency and error information
			currF0 = new TextField();
			currF0.x = stage.stageWidth * 0.45;
			currF0.y = stage.stageHeight * 0.15;
			//currF0.maxChars = 5;
			currF0.text = "0000 Hz";
			addChild(currF0);
			
			errorTxt = new TextField();
			errorTxt.x = stage.stageWidth * 0.75;
			errorTxt.y = stage.stageHeight * 0.25;
			//errorHz.maxChars = 10;
			errorTxt.text = "Error:";
			addChild(errorTxt);
			
			errorHz = new TextField();
			errorHz.x = stage.stageWidth * 0.75;
			errorHz.y = stage.stageHeight * 0.30;
			//errorHz.maxChars = 10;
			errorHz.text = "000 Hz";
			addChild(errorHz);
			
			errorCents = new TextField();
			errorCents.x = stage.stageWidth * 0.75;
			errorCents.y = stage.stageHeight * 0.35;
			//errorCents.maxChars = 7;
			errorCents.text = "000 Cents";
			addChild(errorCents);
				
			//Needle
			needle = new Needle( stage.stageWidth / 2, stage.stageHeight * 0.65, stage.stageHeight * 0.65 - stage.stageHeight * 0.2);
			needle.x = stage.stageWidth / 2;
			needle.y =  stage.stageHeight * 0.65;
			addChild(needle);
			// Not active screen -> WARNING this screen HAS TO BE ADDED ON TOP!!!
			playButton = new PlayButtonScreen();
			addChild(playButton);
			playButton.addEventListener(MouseEvent.CLICK, onPlay);

			//timers
			m_timer = new Timer(UPDATE_PERIOD);
            m_timer.addEventListener(TimerEvent.TIMER, update);
			//set as button (for pause ...)
			//buttonMode = true;
			
		}
		
		private function update(e:Event):void
		{	
			trace("detected frequency: ", spect.freq, MIN_FREQ, MAX_FREQ);
			//if ( spect.freq > MIN_FREQ && spect.freq < MAX_FREQ)
			{
				trace("frequency in range ", MIN_FREQ, MAX_FREQ);
				noteMapper.updateFreq(spect.freq);
				var n:Note = noteMapper.getNote();
				gradientButtonScroller.update(n, noteMapper.currErrorCents);
				bottomButtonContainer.update(n, noteMapper.currErrorCents);
				needle.update(noteMapper.currErrorCents);
				currF0.text = n.freq.toString().substr(0,6) + " Hz";
				errorCents.text = noteMapper.currErrorCents.toString().substr(0,3) + " Hz";
				errorHz.text = noteMapper.currErrorHz.toString().substr(0, 4) + " Cents";
			}
		}
		
		private function onPlay(e:MouseEvent = null):void
		{
			playButton.removeEventListener(MouseEvent.CLICK, onPlay);
			//addEventListener(MouseEvent.CLICK, onPause);
			removeChild(playButton);
            m_timer.start();
			spect.start();
		}

		private function onPause(e:MouseEvent = null):void
		{
			addChild(playButton);
			playButton.addEventListener(MouseEvent.CLICK, onPlay);
			removeEventListener(MouseEvent.CLICK, onPause);
			spect.stop();
			m_timer.stop();
		}
		
	}
	
}