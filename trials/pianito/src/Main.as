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
	[SWF(width='1024', height='200', frameRate='30', backgroundColor='0xeeeeee')]
	public class Main extends Sprite 
	{
		private var keyboard:OctaveKeyboard;
		
		private var spect:SpectrumAnalyzer;
		private var noteMapper:NoteMapper;
		private var m_timer:Timer;
		private var playButton:PlayButtonScreen;
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
			//spect = new SpectrumAnalyzer();
			//noteMapper = new NoteMapper();
			/////////GUI
			keyboard = new OctaveKeyboard(3, 3, stage.stageWidth, stage.stageHeight);
			addChild(keyboard);
			keyboard.x = 0;
			keyboard.y = 0;
			// Not active screen -> WARNING this screen HAS TO BE ADDED ON TOP!!!
			//playButton = new PlayButtonScreen();
			//addChild(playButton);
			//playButton.addEventListener(MouseEvent.CLICK, onPlay);

			//timers
			m_timer = new Timer(UPDATE_PERIOD);
            m_timer.addEventListener(TimerEvent.TIMER, update);
			//set as button (for pause ...)
			//buttonMode = true;
			
		}
		
		private function update(e:Event):void
		{	
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