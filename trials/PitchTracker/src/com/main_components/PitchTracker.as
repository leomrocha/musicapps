package com.main_components 
{
	import com.components.CentsErrorDisplay;
	import com.components.FrequencyAutoIntervalDisplay;
	import com.audio_processing.NoteMapper;
	import com.audio_processing.SpectrumAnalyzer;
	import com.audio_processing.SpectrumEvent;
	import com.components.NoteDisplay;
	import com.gui_elements.PauseButton;
	import com.gui_elements.PlayButton;
	import com.gui_elements.PlayButtonScreen;
	import com.gui_elements.ScrollBar;
	import com.gui_elements.ScrollBarEvent;
	import com.gui_elements.StopButton;
	import com.music_concepts.Note;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PitchTracker extends Sprite 
	{
		private var _w:Number, _h:Number;
		private var  MIN_FREQ:Number = 65.0;
		private var  MAX_FREQ:Number; // = 1000.0;
		private var spect:SpectrumAnalyzer;
		private var noteMapper:NoteMapper;
		
		private var freqDisplay:FrequencyAutoIntervalDisplay;
		private var centsErrorDisplay:CentsErrorDisplay;
		private var noteDisplay:NoteDisplay;
		private var scrollBar:ScrollBar;
		
		
		private var playButton:PlayButtonScreen;
		private var smallPlayButton:PlayButton;
		private var pauseButton:PauseButton;
		private var stopButton:StopButton;
		
		//history
		private var _notesVect:Vector.<Note>; //keeps track of the notes since the start of the playing // history
		private var _samplesCount:uint; //counting the number of samples at notes vect
		private var _maxSamplesHistory:uint = 1 << 15 // 10000;// should be enough for about (2^15 / ( 1000 / SAMPLES_SECONDS  ) ) seconds, at the moment is around: 54 minutes
		
		//for knowing the samples to show on screen
		private var _currentSamplesShown:uint;
		private var _currentInitSample:uint;
		private var _currentEndSample:uint;
		private var _currentInitTime:Number;
		private var _currentEndTime:Number;
		
		//maximum acceptable error in cents
		private var _maxErrorCents:Number = 30;
		
		
		//private var errorCents:TextField;
		//private var errorTxt:TextField;
		//private var errorHz:TextField;
		//private var currF0:TextField;
		//private var currNote:TextField;
		
		//private var okLight:CircleLight;
		
		//private const UPDATE_PERIOD:int = 100; //milliseconds
		
		//private var marksVector:Vector.<ErrorMark>;
		
		
		public function PitchTracker(w:Number, h:Number)
		{
			_w = w;
			_h = h;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			_notesVect = new Vector.<Note>();//history
			
			spect = new SpectrumAnalyzer();
			MAX_FREQ = spect.MAXIMUM_DETECTABLE_FREQ;
			noteMapper = new NoteMapper();
			
			freqDisplay = new FrequencyAutoIntervalDisplay(_w - 50, _h*0.6, _maxErrorCents);
			freqDisplay.MIN_FREQ = MIN_FREQ;
			freqDisplay.MAX_FREQ = MAX_FREQ;
			freqDisplay.x = 50;
			freqDisplay.y = 0;
			addChild(freqDisplay);
			
			noteDisplay = new NoteDisplay(_w - 50, _h * 0.15)
			noteDisplay.MIN_FREQ = MIN_FREQ;
			noteDisplay.MAX_FREQ = MAX_FREQ;
			noteDisplay.x = 50;
			noteDisplay.y = _h * 0.64;
			addChild(noteDisplay);
			
			centsErrorDisplay = new CentsErrorDisplay(_w - 50, _h * 0.15, _maxErrorCents);
			centsErrorDisplay.MIN_FREQ = MIN_FREQ;
			centsErrorDisplay.MAX_FREQ = MAX_FREQ;
			centsErrorDisplay.x = 50;
			centsErrorDisplay.y = _h*0.8;
			addChild(centsErrorDisplay);
			
			scrollBar = new ScrollBar(_w - 50, 20);
			scrollBar.x = 50;
			scrollBar.y = _h * 0.605;
			addChild(scrollBar);
			
			//pause button (or surface ...)
			pauseButton = new PauseButton(40 , 30, 15 , 0x303030, 0x5f5f5f);
			addChild(pauseButton);
			pauseButton.x = 5; // _w * 0. - _w / 12;
			pauseButton.y = _h * 0.75;
			pauseButton.addEventListener(MouseEvent.CLICK, onPause);
			
			//pause button (or surface ...)
			smallPlayButton = new PlayButton(40 , 30, 15 , 0x303030, 0x5f5f5f);
			smallPlayButton.x = 5; // _w * 0. - _w / 12;
			smallPlayButton.y = _h * 0.75;
			//smallPlayButton.addEventListener(MouseEvent.CLICK, onPause);
			
			
			//pause button (or surface ...)
			stopButton = new StopButton(40 , 30, 15 , 0x303030, 0x5f5f5f);
			addChild(stopButton);
			stopButton.x = 5;// _w * 0.5 - _w / 12;
			stopButton.y = _h * 0.85;
			stopButton.addEventListener(MouseEvent.CLICK, onStop);
			
			// Not active screen -> WARNING this screen HAS TO BE ADDED ON TOP!!!
			playButton = new PlayButtonScreen(_w, _h, 0x303030, 0x5f5f5f);
			addChild(playButton);
			playButton.addEventListener(MouseEvent.CLICK, onPlay);

			//buttonMode = true;
			spect.addEventListener(SpectrumEvent.SPECTRUM_UPDATED_EVENT, update);
			
			
			
			_currentSamplesShown = 100;
		}
		
		private function scrollUpdated(e:ScrollBarEvent = null):void
		{
			trace("scroll Update");
			vectorUpdateDisplays(e.scrollPos);
		}
		
		private function vectorUpdateDisplays(perc:Number):void
		{
			
			//var perc:Number = e.scrollPos;
			var  beginSample:uint = perc * _notesVect.length / 100;
			trace("scroll Update, sample: ", beginSample);
			//_currentSamplesShown = beginSample; //later make this better!!
			
			if (beginSample + _currentSamplesShown > _notesVect.length)
			{
				beginSample = _notesVect.length - _currentSamplesShown;
			}if (beginSample < 0)
			{
				beginSample = 0;
			}
			
			_currentInitSample = beginSample;
			_currentEndSample = beginSample + _currentSamplesShown;
			
			var samplesToShow:Vector.<Note> = new Vector.<Note>(_currentSamplesShown);
			//TODO check if there is some slicing option for vectors in actionscript 3
			for ( var i:uint = 0; i < _currentSamplesShown; i++)
			{
				try
				{
					samplesToShow[i] = _notesVect[i + _currentInitSample];
					trace("copying noteVect[ ", i,"].freq = ", _notesVect[i].freq, samplesToShow[i].freq);
				}catch (e:Error)
				{//out of bounds; complete with null
					trace("notes vect or samples shown not large enough");
					samplesToShow[i] = new Note(Number.MAX_VALUE,"C",Number.MAX_VALUE, Number.MAX_VALUE);
				}
				
			}
			trace("gets here");
			freqDisplay.showVector(samplesToShow);
			centsErrorDisplay.showVector(samplesToShow);
			noteDisplay.showVector(samplesToShow);
			trace("and here");
			//_currentInitTime:Number;
			//_currentEndTime:Number;
		}
		
		private function update(e:SpectrumEvent):void
		{	
			//trace("detected frequency: ", e.freq, MIN_FREQ, MAX_FREQ);
			//if ( spect.freq > MIN_FREQ )//&& spect.freq < MAX_FREQ)
			{
				//trace("frequency in range ", MIN_FREQ, MAX_FREQ);
				noteMapper.updateFreq(e.freq);
				var n:Note = noteMapper.getNote();
				//history tracking
				if (_notesVect.length > _maxSamplesHistory)
				{
					_notesVect.shift();
					_samplesCount--;
				}
				_notesVect.push(n);
				trace("samples count: ", _samplesCount, _notesVect.length)
				_samplesCount++;
				//TODO time interval
				//n.time = 
				//update screen
				freqDisplay.update(n);
				centsErrorDisplay.update(n);
				noteDisplay.update(n);
			}
		}
		
		private function onPlay(e:MouseEvent = null):void
		{
			trace("onPlay");
			if (playButton.parent)
			{
				trace("onPlay screen button");
				playButton.removeEventListener(MouseEvent.CLICK, onPlay);
				//addEventListener(MouseEvent.CLICK, onPause);
				removeChild(playButton);
            }
			if (smallPlayButton.parent)
			{
				trace("onPlay small button");
				smallPlayButton.removeEventListener(MouseEvent.CLICK, onPlay);
				pauseButton.addEventListener(MouseEvent.CLICK, onPause);
				removeChild(smallPlayButton);
				addChild(pauseButton);
				//scrollBar.setScrollPercentagePosition(100.0);
				vectorUpdateDisplays(100.0);
				scrollBar.removeEventListener(ScrollBarEvent.SCROLL_UPDATED, scrollUpdated);
			}
			trace("scroll bar is active: ", scrollBar.active)
			if (scrollBar.active)
			{
				scrollBar.deactivate();
			}
			
			//m_timer.start();
			spect.start();
		}

		//private function onSmallPlay(e:MouseEvent = null):void
		//{
			//trace("onPlay small button");
			//if (smallPlayButton.parent)
			//{
				//trace("onPlay small button");
				//smallPlayButton.removeEventListener(MouseEvent.CLICK, onSmallPlay);
				//pauseButton.addEventListener(MouseEvent.CLICK, onPause);
				//removeChild(smallPlayButton);
				//addChild(pauseButton);
			//}
			//if (scrollBar.active)
			//{
				//scrollBar.deactivate();
			//}
			//
			//m_timer.start();
			//spect.start();
		//}
		
		private function onPause(e:MouseEvent = null):void
		{
			addChild(smallPlayButton);
			
			smallPlayButton.addEventListener(MouseEvent.CLICK, onPlay);
			scrollBar.addEventListener(ScrollBarEvent.SCROLL_UPDATED, scrollUpdated);
			pauseButton.removeEventListener(MouseEvent.CLICK, onPause);
			
			removeChild(pauseButton);
			spect.stop();
			
			if (!scrollBar.active)
			{
				scrollBar.activate();
			}
			//m_timer.stop();
		}
		
		private function onStop(e:MouseEvent = null):void
		{
			addChild(playButton);
			playButton.addEventListener(MouseEvent.CLICK, onPlay);
			removeEventListener(MouseEvent.CLICK, onPause);
			spect.stop();

			//clear displays:
			noteDisplay.clear();
			centsErrorDisplay.clear();
			freqDisplay.clear();
			
			//m_timer.stop();
		}

	}

}