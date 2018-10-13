package com.main_components 
{
	import com.components.CentsErrorDisplay;
	import com.components.FrequencyAutoIntervalDisplay;
	import com.audio_processing.NoteMapper;
	import com.audio_processing.SpectrumAnalyzer;
	import com.audio_processing.SpectrumEvent;
	import com.components.metronome_comp.MetronomeEvent;
	import com.components.NoteDisplay;
	import com.components.PseudoSheetMusicDisplay;
	//import com.components.Scoring;
	import com.gui_elements.GradientButton;
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
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
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
		private var sheetDisplay:PseudoSheetMusicDisplay;
		private var metronome:Metronome; //TODO solve BUG with tempo, the timer event does not work magically always with the same exact period
		private var metronomeWasOn:Boolean = false;
		//private var scoring:Scoring;
		
		private var playButton:PlayButtonScreen;
		private var smallPlayButton:PlayButton;
		private var pauseButton:PauseButton;
		private var stopButton:StopButton;
		
		private var changeDisplayButtonPrevious:GradientButton;
		private var changeDisplayButtonNext:GradientButton;
		
		private var sharpSelectButton:GradientButton;
		private var flatSelectButton:GradientButton;
		
		//history
		private var _notesVect:Vector.<Note>; //keeps track of the notes since the start of the playing // history
		private var _ticksVect:Vector.<MetronomeEvent>; //keeps track of the notes since the start of the playing // history
		private var _ticksBooleanVect:Vector.<Boolean>;
		private var _samplesCount:uint; //counting the number of samples at notes vect
		private var _maxSamplesHistory:uint = 1 << 15 // 10000;// should be enough for about (2^15 / ( 1000 / SAMPLES_SECONDS  ) ) seconds, at the moment is around: 54 minutes
		
		private var _tick:Boolean = false;//metronome tick, to indicate a tick until is consumed
		private var _tickInCompass:uint = 0;//metronome tick, to indicate a tick until is consumed
		
		//for knowing the samples to show on screen
		private var _currentSamplesShown:uint;
		private var _currentInitSample:uint;
		private var _currentEndSample:uint;
		private var _currentInitTime:Number;
		private var _currentEndTime:Number;
		
		//maximum acceptable error in cents
		private var _maxErrorCents:Number = 30;
		
		private var _showSharpNotes:Boolean = true;
		private var _showFlatNotes:Boolean = false;
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
			_ticksVect = new Vector.<MetronomeEvent>();//metronome history 
			_ticksBooleanVect = new Vector.<Boolean>();
			
			spect = new SpectrumAnalyzer();
			MAX_FREQ = spect.MAXIMUM_DETECTABLE_FREQ;
			noteMapper = new NoteMapper();
			
			freqDisplay = new FrequencyAutoIntervalDisplay(_w - 50, _h*0.6, _maxErrorCents);
			freqDisplay.MIN_FREQ = MIN_FREQ;
			freqDisplay.MAX_FREQ = MAX_FREQ;
			freqDisplay.x = 50;
			freqDisplay.y = _h *0.04; // 0;
			//addChild(freqDisplay);
			
			sheetDisplay = new PseudoSheetMusicDisplay(_w - 50, _h * 0.75, _maxErrorCents);
			sheetDisplay.MIN_FREQ = MIN_FREQ;
			sheetDisplay.MAX_FREQ = MAX_FREQ;
			sheetDisplay.x = 50;
			sheetDisplay.y = _h *0.04; // 0;
			addChild(sheetDisplay);
			
			noteDisplay = new NoteDisplay(_w - 50, _h * 0.15)
			noteDisplay.MIN_FREQ = MIN_FREQ;
			noteDisplay.MAX_FREQ = MAX_FREQ;
			noteDisplay.x = 50;
			noteDisplay.y = _h * 0.645; // 0; _h * 0.605;// _h * 0.64;
			//addChild(noteDisplay);
			
			centsErrorDisplay = new CentsErrorDisplay(_w - 50, _h * 0.15, _maxErrorCents);
			centsErrorDisplay.MIN_FREQ = MIN_FREQ;
			centsErrorDisplay.MAX_FREQ = MAX_FREQ;
			centsErrorDisplay.x = 50;
			centsErrorDisplay.y = _h*0.84;// _h*0.8;
			addChild(centsErrorDisplay);
			
			//Is TOO ugly and not clear at all for understanding!!
			//scoring = new Scoring(40, 40);
			//scoring.x = 0.05;
			//scoring.y = _h * 0.85;
			//addChild(scoring);
			
			scrollBar = new ScrollBar(_w - 50, 20);
			scrollBar.x = 50;
			scrollBar.y = _h * 0.8;// 10+_h * 0.76;//_h * 0.76;// _h * 0.605;
			addChild(scrollBar);
			
			//changeDisplayButtonPrevious = new GradientButton("<", 10, 50, 5, 0x303030, 0x5f5f5f);
			changeDisplayButtonPrevious = new PlayButton( 15, 50, 5, 0x303030, 0x5f5f5f, PlayButton.BUTTON_DIRECTION_LEFT);
			changeDisplayButtonPrevious.x = 50; // _w * 0. - _w / 12;
			changeDisplayButtonPrevious.y = _h *0.08;
			changeDisplayButtonPrevious.addEventListener(MouseEvent.CLICK, onChangeDisplay);
			addChild(changeDisplayButtonPrevious);
			
			//changeDisplayButtonNext = new GradientButton(">", 10, 50, 5, 0x303030, 0x5f5f5f);
			changeDisplayButtonNext = new PlayButton( 15, 50, 5, 0x303030, 0x5f5f5f);
			changeDisplayButtonNext.x = _w-15; // _w * 0. - _w / 12;
			changeDisplayButtonNext.y = _h *0.08;
			changeDisplayButtonNext.addEventListener(MouseEvent.CLICK, onChangeDisplay);
			addChild(changeDisplayButtonNext);
			
			sharpSelectButton = new GradientButton("#", 15, 20 , 5, 0x202020, 0x303030);
			sharpSelectButton.x = 70; // _w * 0. - _w / 12;
			sharpSelectButton.y = _h *0.13;
			sharpSelectButton.addEventListener(MouseEvent.CLICK, onChangeSharpFlat);
			//addChild(sharpSelectButton);
			
			flatSelectButton = new GradientButton("b", 15, 20 , 5, 0x202020, 0x303030);
			flatSelectButton.x = 70; // _w * 0. - _w / 12;
			flatSelectButton.y = _h *0.13;
			flatSelectButton.addEventListener(MouseEvent.CLICK, onChangeSharpFlat);
			addChild(flatSelectButton);
			
			//pause button (or surface ...)
			pauseButton = new PauseButton(40 , 30, 15 , 0x303030, 0x5f5f5f);
			addChild(pauseButton);
			pauseButton.x = 5; // _w * 0. - _w / 12;
			pauseButton.y = _h * 0.5;
			pauseButton.addEventListener(MouseEvent.CLICK, onPause);
			
			//pause button (or surface ...)
			smallPlayButton = new PlayButton(40 , 30, 15 , 0x303030, 0x5f5f5f);
			smallPlayButton.x = 5; // _w * 0. - _w / 12;
			smallPlayButton.y = _h * 0.5;
			//smallPlayButton.addEventListener(MouseEvent.CLICK, onPause);
			
			
			//pause button (or surface ...)
			stopButton = new StopButton(40 , 30, 15 , 0x303030, 0x5f5f5f);
			addChild(stopButton);
			stopButton.x = 5;// _w * 0.5 - _w / 12;
			stopButton.y = _h * 0.55;
			stopButton.addEventListener(MouseEvent.CLICK, onStop);
			
			// Not active screen -> WARNING this screen HAS TO BE ADDED ON TOP!!!
			playButton = new PlayButtonScreen(_w, _h, 0x303030, 0x5f5f5f);
			addChild(playButton);
			playButton.addEventListener(MouseEvent.CLICK, onPlay);

			//buttonMode = true;
			spect.addEventListener(SpectrumEvent.SPECTRUM_UPDATED_EVENT, update);
			
			//TODO fix bug with metronome timer sound!!!!!! this is mandatory!!
			metronome = new Metronome( 40, 100);
			metronome.x = 5;
			metronome.y = 100;
			addChild(metronome);
			
			metronome.simpleMetronome.addEventListener(MetronomeEvent.METRONOME_TICK, metronomeTick);//TODO see this and WTF is happening that I have to break encapsulation to actually be able to trap the event!!!
			
			_currentSamplesShown = 200;
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
			var marksToShow:Vector.<Boolean> = new Vector.<Boolean>(_currentSamplesShown);
			
			//TODO check if there is some slicing option for vectors in actionscript 3
			for ( var i:uint = 0; i < _currentSamplesShown; i++)
			{
				try //DONE : take in account if sharp or flat to change the history according to that
				{
					samplesToShow[i] = _notesVect[i + _currentInitSample];
					marksToShow[i] = _ticksBooleanVect[i + _currentInitSample];
					
					if (_showSharpNotes)
					{
						samplesToShow[i].name = samplesToShow[i].nameSharp;
					}else if (_showFlatNotes)
					{
						samplesToShow[i].name = samplesToShow[i].nameFlat;
					}//else nothing
					trace("copying noteVect[ ", i,"].freq = ", _notesVect[i].freq, samplesToShow[i].freq);
				}catch (e:Error)
				{//out of bounds; complete with null
					trace("notes vect or samples shown not large enough");
					samplesToShow[i] = new Note(Number.MAX_VALUE,"C",Number.MAX_VALUE, Number.MAX_VALUE);
				}
				
			}
			trace("gets here");
			freqDisplay.showVector(samplesToShow, marksToShow);
			centsErrorDisplay.showVector(samplesToShow, marksToShow);
			noteDisplay.showVector(samplesToShow, marksToShow);
			sheetDisplay.showVector(samplesToShow, marksToShow);
			trace("and here");
			//_currentInitTime:Number;
			//_currentEndTime:Number;
		}
		
		private function metronomeTick(e:MetronomeEvent = null):void
		{
			//TODO
			trace("metronome tick");
			_tick = true;
			_tickInCompass = e.tickInCompass;
			_ticksVect.push(e);
			if (_ticksVect.length > _maxSamplesHistory)
				{
					_ticksVect.shift();
				}
		}
		
		private function update(e:SpectrumEvent):void
		{	
			//trace("tick at update = ", tick);
			var tick:Boolean = _tick;
			_tick = false;
			//trace("detected frequency: ", e.freq, MIN_FREQ, MAX_FREQ);
			//if ( spect.freq > MIN_FREQ )//&& spect.freq < MAX_FREQ)
			{
				//trace("frequency in range ", MIN_FREQ, MAX_FREQ);
				noteMapper.updateFreq(e.freq);
				var n:Note = noteMapper.getNote();
				if (_showSharpNotes)
				{
					n.name = n.nameSharp;
				}else if (_showFlatNotes)
				{
					n.name = n.nameFlat;
				}//else nothing
				//history tracking
				if (_notesVect.length > _maxSamplesHistory)
				{
					_ticksBooleanVect.shift();
					_notesVect.shift();
					_samplesCount--;
				}
				_ticksBooleanVect.push(tick);
				_notesVect.push(n);
				trace("samples count: ", _samplesCount, _notesVect.length)
				_samplesCount++;
				//TODO time interval
				//n.time = 
				//update screen
				//freqDisplay.update(n);
				freqDisplay.update(n, tick);
				//noteDisplay.update(n);
				noteDisplay.update(n, tick);
				sheetDisplay.update(n, tick, _tickInCompass);
				//centsErrorDisplay.update(n);
				centsErrorDisplay.update(n, tick);

				//if(n.freq >= MIN_FREQ && n.freq <= MAX_FREQ)
				//{
					//scoring.update(n);
				//}
				
			}
		}
		
		private function onChangeSharpFlat(e:MouseEvent):void
		{
			if (_showSharpNotes)
			{
				_showSharpNotes = false;
				_showFlatNotes = true;
				addChild(sharpSelectButton);
			}else {
				_showSharpNotes = true;
				_showFlatNotes = false;
				addChild(flatSelectButton);
			}
		}
		
		private function onChangeDisplay(e:MouseEvent):void
		{
			if (sheetDisplay.parent)
			{
				freqDisplay.alpha = 0;
				noteDisplay.alpha = 0;
				addChild(freqDisplay);
				addChild(noteDisplay);
				TweenMax.allTo([freqDisplay, noteDisplay], 0.9, { alpha:1} );
				removeChild(sheetDisplay);
				//move scrollBar and other buttons to top
				removeChild(scrollBar);
				addChild(scrollBar);
				removeChild(changeDisplayButtonNext);
				addChild(changeDisplayButtonNext);
				removeChild(changeDisplayButtonPrevious);
				addChild(changeDisplayButtonPrevious);
				if (_showSharpNotes)
				{
					removeChild(flatSelectButton);
					addChild(flatSelectButton);
				}else {
					removeChild(sharpSelectButton);
					addChild(sharpSelectButton);
				}
				
			}else //(!sheetDisplay.parent)
			{
				sheetDisplay.alpha = 0;
				addChild(sheetDisplay);
				
				TweenMax.to(sheetDisplay, 0.9, { alpha:1 } );
				
				removeChild(freqDisplay);
				removeChild(noteDisplay);
				//move scrollBar to top
				removeChild(scrollBar);
				addChild(scrollBar);
				removeChild(changeDisplayButtonNext);
				addChild(changeDisplayButtonNext);
				removeChild(changeDisplayButtonPrevious);
				addChild(changeDisplayButtonPrevious);
				if (_showSharpNotes)
				{
					removeChild(flatSelectButton);
					addChild(flatSelectButton);
				}else {
					removeChild(sharpSelectButton);
					addChild(sharpSelectButton);
				}
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
				if (metronomeWasOn)
				{
					metronome.start();
				}
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
			if (metronome.running)
			{
				metronomeWasOn = true;
			}else {
				metronomeWasOn = false;
			}
			metronome.stop();
			
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
			metronome.stop();
			//clear displays:
			noteDisplay.clear();
			centsErrorDisplay.clear();
			freqDisplay.clear();
			sheetDisplay.clear();
			//m_timer.stop();
		}

	}

}