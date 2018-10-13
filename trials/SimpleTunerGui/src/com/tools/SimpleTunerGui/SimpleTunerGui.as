package com.tools.SimpleTunerGui 
{
	import adobe.utils.CustomActions;
	import com.tools.SimpleTunerGui.audio_processing.NoteMapper;
	import com.tools.SimpleTunerGui.audio_processing.SpectrumAnalyzer;
	import com.tools.SimpleTunerGui.audio_processing.SpectrumEvent;
	import com.tools.SimpleTunerGui.gui_elements.GradientButton;
	import com.tools.SimpleTunerGui.gui_elements.GradientCircle;
	import com.tools.SimpleTunerGui.gui_elements.GradientTriangle;
	import com.tools.SimpleTunerGui.gui_elements.Letter;
	import com.tools.SimpleTunerGui.music_concepts.Note;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class SimpleTunerGui extends Sprite 
	{
		private var _minFreq:Number;
		private var _maxFreq:Number;
		
		private var noteMapper:NoteMapper;
		private var spect:SpectrumAnalyzer;
		private var maxCentsError:Number = 5.0;
		
		private var noteNames:Vector.<String> = new < String > ["C", "Db", "D", "Eb", "E", "F",
																"Gb", "G", "Ab", "A", "Bb", "B"];
		
		private var notesLetters:Vector.<Letter>;
		private var octaveLetter:Letter;
		
		//
		private var pauseButton:GradientButton;
		//
		private var okLight:GradientCircle;
		private var tooLowLight:GradientTriangle;
		private var tooHighLight:GradientTriangle;
		
		//
		private var _w:Number;
		private var _h:Number;
		
		public function SimpleTunerGui( w:Number, h:Number, minFreq:Number = 28, maxFreq:Number = 1000) 
		{
			_w = w;
			_h = h;
			_minFreq = minFreq;
			_maxFreq = maxFreq;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{	
			trace("init tuner gui");
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			spect = new SpectrumAnalyzer();
			noteMapper = new NoteMapper();
			
			var w:Number = _w * 0.07;
			var h:Number = _h * 0.45;
			var xpos:Number = _w * 0.9;
			var ypos:Number = _h * 0.05;
			
			notesLetters = new Vector.<Letter>;
			trace("w,h,x,y", w, h, xpos, ypos);5
			octaveLetter = new Letter("0", w, h);
			octaveLetter.x = xpos;
			octaveLetter.y = ypos;
			
			addChild (octaveLetter);
			
			var step:Number = (_w * 0.8) / noteNames.length;
			xpos = 0.05;
			trace("step: ", step);
			for each(var s:String in noteNames)
			{
				trace("note: ", s);
				var l:Letter = new Letter(s, w, h);
				l.x = xpos;
				l.y = ypos;
				notesLetters.push(l);
				addChild(l);
				xpos += step;
				trace("letter was pushed");
			}
			//pause
			w = _w * 0.10;
			h = _h * 0.40;
			xpos = _w * 0.85;
			ypos = _h * 0.55;
			
			pauseButton = new GradientButton("Pause", w, h, 10);
			pauseButton.x = xpos;
			pauseButton.y = ypos;
			addChild(pauseButton);
			
			//light signals
			w = _w * 0.06;
			xpos = _w * 0.38;
			var r:Number = Math.min(w, h) * 0.5;
			okLight = new GradientCircle(r);
			okLight.x = xpos;
			okLight.y = ypos + r;
			addChild(okLight);
			
			//too low
			tooLowLight = new GradientTriangle(w, h);
			tooLowLight.x = _w * 0.25;
			tooLowLight.y = ypos;
			addChild(tooLowLight);
			//too High
			tooHighLight = new GradientTriangle(w, h, false);
			tooHighLight.x = _w * 0.45;
			tooHighLight.y = ypos;
			addChild(tooHighLight);
			
			spect.addEventListener(SpectrumEvent.SPECTRUM_UPDATED_EVENT, update);
			this.buttonMode = false;
		}
		
		private function update(e:SpectrumEvent = null):void
		{	
			trace("detected frequency: ", e.freq, _minFreq, _maxFreq);
			noteMapper.updateFreq(e.freq);
			var n:Note = noteMapper.getNote();
			//if (n.freq < 0)
			//{}
			//else
			if ( n.freq > _minFreq && n.freq < _maxFreq)
			{
				trace("frequency in range ", _minFreq, _maxFreq);
				
				octaveLetter.letter = n.octave.toString();
				//update letter
				updateLetter( n.name, noteMapper.currErrorCents);
				//update light signals | > o < |
				updateLights(noteMapper.currErrorCents);
			}
		}
		
		private function updateLights(error:Number):void
		{
			if (error <= Math.abs( maxCentsError) )
			{
				okLight.paintGreen();
				tooHighLight.paintDefault();
				tooLowLight.paintDefault();
			}
			else
			{
				okLight.paintRed();
				if (error < 0)
				{
					tooHighLight.paintDefault();
					tooLowLight.paintRed();
				}else if (error > 0)
				{
					tooHighLight.paintRed();
					tooLowLight.paintDefault();
				}
			}
		}
		
		private function updateLetter(noteName:String, error:Number):void
		{
			for each( var l:Letter in notesLetters)
			{
				if ( l.letter == noteName)
				{
					if (error <= Math.abs( maxCentsError) ) l.greenLight();
					else l.redLight();
					
				}
				else
				{
					l.steadyState();
				}
			}
			
		}
		
		public function start(e:Event = null):void
		{
			trace("start processing");
			spect.start();
			//connect signals and other stuff
		}
		
		public function stop(e:Event = null):void
		{
			trace("stop processing");
			spect.stop();
			//disconnect signals and other stuff
		}
		
	}

}