package com.leopanigo.components.screens 
{
	import com.leopanigo.audio_processing.NoteMapper;
	import com.leopanigo.audio_processing.parameter_configuration.SpectAnalyzerParametrization;
	import com.leopanigo.audio_processing.SpectrumAnalyzer;
	import com.leopanigo.audio_processing.SpectrumEvent;
	import com.leopanigo.components.screens.sub_components.PracticeOptions;
	import com.leopanigo.components.screens.sub_components.PracticePlayMenu;
	import com.leopanigo.components.screens.sub_components.PracticeSelectSource;
	import com.leopanigo.components.screens.sub_components.PracticeVisualization;
	import com.leopanigo.components.screens.sub_components.TestLevel;
	import com.leopanigo.music_concepts.Note;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PracticeScreen extends Sprite 
	{
		private var _w:Number, _h:Number;
		
		private var  MIN_FREQ:Number;// = 65.0;
		private var  MAX_FREQ:Number; // = 1000.0;
		
		private var playMenu:PracticePlayMenu;
		private var optionsMenu:PracticeOptions;
		private var selectSource:PracticeSelectSource;
		private var visualization:PracticeVisualization;
		
		private var spect:SpectrumAnalyzer;
		private var noteMapper:NoteMapper;
		
		private var level:Vector.<Note>;
		private var testLevel:TestLevel;
		
		public function PracticeScreen(w:Number, h:Number)
		{
			_w = w;
			_h = h;
			
			spect = new SpectrumAnalyzer();
			
			playMenu = new PracticePlayMenu(_w * 0.15, _h * 0.3);
			playMenu.x = 0;
			playMenu.y = 0;
			addChild(playMenu);
			
			optionsMenu = new PracticeOptions( _w * 0.03, _h * 0.3);
			optionsMenu.x = _w * 0.16;
			optionsMenu.y = 0;
			addChild(optionsMenu);
			
			selectSource = new PracticeSelectSource(_w * 0.3, _h * 0.3);
			selectSource.x = _w * 0.2;
			selectSource.y =0;
			addChild(selectSource);
			
			MIN_FREQ = 60;
			MAX_FREQ = spect.MAXIMUM_DETECTABLE_FREQ;
			
			visualization = new PracticeVisualization(_w * 0.9, _h * 0.6, MIN_FREQ, MAX_FREQ );
			visualization.x = _w * 0.1;
			visualization.y = _h * 0.4;
			addChild(visualization);
			
			testLevel = new TestLevel();
			level = testLevel.getLevel();
			
			
			noteMapper = new NoteMapper();
			
			//spect.addEventListener(SpectrumEvent.SPECTRUM_UPDATED_EVENT, update);
			
			playMenu.playButton.addEventListener(MouseEvent.CLICK, play);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function update(e:SpectrumEvent):void
		{
			noteMapper.updateFreq(e.freq);
			var n:Note = noteMapper.getNote();
			n.initTime = e.time;
			n.endTime = e.time +0.033;
			visualization.update(n);
		}
		
		public function play(e:MouseEvent = null):void
		{
			playMenu.playButton.removeEventListener(MouseEvent.CLICK, play);
			
			//show 
			visualization.setLevel(level);
			spect.start(); //WARNING!!! should be done better than this!!
			spect.addEventListener(SpectrumEvent.SPECTRUM_UPDATED_EVENT, update);
			playMenu.onPlay();//WARNING!!! should be done better than this!!
			playMenu.pauseButton.addEventListener(MouseEvent.CLICK, pause);//WARNING!!! should be done better than this!!
		}
		
		public function pause(e:MouseEvent = null):void
		{
			playMenu.pauseButton.removeEventListener(MouseEvent.CLICK, pause);
			spect.stop();
			spect.removeEventListener(SpectrumEvent.SPECTRUM_UPDATED_EVENT, update);
			playMenu.onPause();//WARNING!!! should be done better than this!!
			playMenu.playButton.addEventListener(MouseEvent.CLICK, play);//WARNING!!! should be done better than this!!
		}
		
		
		
		public function reconfigureParams(params:SpectAnalyzerParametrization):void
		{
			try {
				spect.stop();//just in case
			}catch(e:Error){}
			
			spect = new SpectrumAnalyzer();

		}
		
	}

}