package com.main_components 
{
	import com.music_concepts.Note;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import com.audio_processing.*;
	import com.gui_elements.*;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class SimpleTuner extends Sprite 
	{
		private var _w:Number, _h:Number;
		private var  MIN_FREQ:Number = 28.0;
		private var  MAX_FREQ:Number; // = 1000.0;
		private var spect:SpectrumAnalyzer;
		private var noteMapper:NoteMapper;
		//private var m_timer:Timer;
		private var playButton:PlayButtonScreen;
		private var pauseButton:PauseButton;
		//private var gradientButtonScroller:GradientButtonScroller;
		private var needle:Needle;
		private var errorCents:TextField;
		private var errorTxt:TextField;
		private var errorHz:TextField;
		private var currF0:TextField;
		private var currNote:TextField;
		
		private var okLight:CircleLight;
		
		private const UPDATE_PERIOD:int = 100; //milliseconds
		
		private var marksVector:Vector.<ErrorMark>;
		private const marks:Array = new Array(-50, -30, -20, -10, -5, 0, 5, 10, 20, 30, 50);
		
		
		public function SimpleTuner(w:Number, h:Number)
		{
			_w = w;
			_h = h;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			///////Processing  
			spect = new SpectrumAnalyzer();
			MAX_FREQ = spect.MAXIMUM_DETECTABLE_FREQ;
			noteMapper = new NoteMapper();
			marksVector = new Vector.<ErrorMark>;
			/////////GUI
			//top buttons
			//gradientButtonScroller = new GradientButtonScroller();
			//addChild(gradientButtonScroller);
			//gradientButtonScroller.x = 0;
			//gradientButtonScroller.y = 2;
			
			//Text ->frequency and error information
			currNote = new TextField();
			currNote.x = _w * 0.20;
			currNote.y = _h * 0.1;
			var format:TextFormat = new TextFormat();
			format.size = 35;
			//format.textColor = 0xffffff;
			//format.
			currNote.defaultTextFormat = format;
			currNote.textColor = 0xffffff;
			//currNote.maxChars = 4;
			currNote.text = "A0";
			addChild(currNote);
			
			currF0 = new TextField();
			currF0.x = _w * 0.55;
			currF0.y = _h * 0.15;
			currF0.textColor = 0xffffff;
			//currF0.maxChars = 5;
			currF0.text = "0000 Hz";
			addChild(currF0);
			
			//errorTxt = new TextField();
			//errorTxt.x = _w * 0.15; //_w * 0.75;
			//errorTxt.y = _h * 0.75; //_h * 0.25;
			//errorTxt.textColor = 0xffffff;
			//errorHz.maxChars = 10;
			//errorTxt.text = "Error:";
			//addChild(errorTxt);
			
			errorHz = new TextField();
			errorHz.x = _w * 0.35; //_w * 0.75;
			errorHz.y = _h * 0.75; // _h * 0.30;
			errorHz.textColor = 0xffffff;
			//errorHz.maxChars = 10;
			errorHz.text = "000 Hz";
			addChild(errorHz);
			
			errorCents = new TextField();
			errorCents.x = _w * 0.55; // _w * 0.75;
			errorCents.y = _h * 0.75; //_h * 0.35;
			errorCents.textColor = 0xffffff;
			//errorCents.maxChars = 7;
			errorCents.text = "000 Cents";
			addChild(errorCents);
				
			//Needle
			var needleLenght:Number = (_w / 2) - 5;
			var needleY:Number = needleLenght + currF0.y + 31 ;
			var needleX:Number = _w / 2;
			
			//the background marks
			for each (var tt:Number in marks)
			{ 
				var err:ErrorMark = new ErrorMark(needleX, needleY, needleLenght, tt, 0xFFFFFF, 2, 0.9, false );
				marksVector.push(err);
				err.x = needleX;
				err.y = needleY;
				addChild(err);
			}
			for (var t:int = -50; t <= 50; t++)
			{ 
				var c:Number = 0xFF0000, proxim:Number;
				//if (Math.abs(t) <= 5)
				//{
					//c = 0x00FF00;
				//}
				{
					if (Math.abs(t) < 5)
					{
						proxim = Math.log( 1 + ( (50.0 - Math.abs(t) ) / 50.0 ) )/ Math.log(2);
					}
					else
					{
						proxim = Math.log( 1 + ( (50.0 - Math.abs(t) ) / 50.0 ) );
					}
					
					
					c = ( uint(0xff * (1 - proxim) ) << 16 ) + ( uint(0xff * (proxim) ) << 8); // RR and GG components
				}
				
				
				var err2:ErrorMark = new ErrorMark(needleX, needleY, needleLenght - 10 , t, c, 2, 0.9);
				marksVector.push(err2);
				err2.x = needleX;
				err2.y = needleY;
				addChild(err2);
			}

			//
			needle = new Needle( needleX, needleY, needleLenght );
			needle.x = needleX;
			needle.y =  needleY;
			addChild(needle);
			
			okLight = new CircleLight(_w / 25);
			okLight.x = needleX;
			okLight.y = needleY;
			addChild(okLight);
			
			//pause button (or surface ...)
			pauseButton = new PauseButton(_w / 6.0 , 30, 15 , 0x303030, 0x5f5f5f);
			addChild(pauseButton);
			pauseButton.x = _w * 0.5 - _w / 12;
			pauseButton.y = _h * 0.85;
			pauseButton.addEventListener(MouseEvent.CLICK, onPause);
			
			// Not active screen -> WARNING this screen HAS TO BE ADDED ON TOP!!!
			playButton = new PlayButtonScreen(_w, _h, 0x303030, 0x5f5f5f);
			addChild(playButton);
			playButton.addEventListener(MouseEvent.CLICK, onPlay);

			//timers
			//m_timer = new Timer(UPDATE_PERIOD);
            //m_timer.addEventListener(TimerEvent.TIMER, update);
			//set as button (for pause ...)
			//buttonMode = true;
			spect.addEventListener(SpectrumEvent.SPECTRUM_UPDATED_EVENT, update);
			
		}
		
		private function update(e:SpectrumEvent):void
		{	
			//trace("detected frequency: ", e.freq, MIN_FREQ, MAX_FREQ);
			//if ( spect.freq > MIN_FREQ )//&& spect.freq < MAX_FREQ)
			{
				//trace("frequency in range ", MIN_FREQ, MAX_FREQ);
				noteMapper.updateFreq(e.freq);
				var n:Note = noteMapper.getNote();
				//gradientButtonScroller.update(n, noteMapper.currErrorCents);
				needle.update(noteMapper.currErrorCents);
				okLight.update(noteMapper.currErrorCents);
				currNote.text = noteMapper.currNote + " " +noteMapper.octave;
				currF0.text = n.freq.toString().substr(0,6) + " Hz";
				errorCents.text = noteMapper.currErrorCents.toString().substr(0,3) + " Cents";
				errorHz.text = noteMapper.currErrorHz.toString().substr(0, 4) + " Hz";
			}
		}
		
		private function onPlay(e:MouseEvent = null):void
		{
			playButton.removeEventListener(MouseEvent.CLICK, onPlay);
			//addEventListener(MouseEvent.CLICK, onPause);
			removeChild(playButton);
            //m_timer.start();
			spect.start();
		}

		private function onPause(e:MouseEvent = null):void
		{
			addChild(playButton);
			playButton.addEventListener(MouseEvent.CLICK, onPlay);
			removeEventListener(MouseEvent.CLICK, onPause);
			spect.stop();
			//m_timer.stop();
		}
		
	}

}