package com.components 
{
	import adobe.utils.CustomActions;
	import com.audio_processing.NoteMapper;
	import com.gui_elements.helpers.CenteredRectData;
	import com.gui_elements.VerticalScale;
	import com.gui_elements.VisualMetronomeMarks;
	import com.music_concepts.Note;
	import flash.display.Shape;
	import flash.display.Sprite;
	import com.gui_elements.bmp_graphs.BMPAmplitudGraph;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	
	public class FrequencyAutoIntervalDisplay extends Sprite 
	{
		private var _w:uint;
		private var _h:uint;
		private var _label:String;
		
		private var _currentSamplesShown:uint;
		
		private var _currentNotesVect:Vector.<Note>; //current notes being displayed
		
		//private var _nextVectorToShow:Vector.<Note>; //is an easy hack to implement the vector showing with a complete input vector
		
		private var metronomeDisplay:VisualMetronomeMarks;
		
		private var _valsVect:Vector.<Number>; //current values to show, normalized to 1
		private var _coloursVect:Vector.<uint>; //colours to show, for each element in the previousvector: MUST have the same amount of elements
		
		//Limits in frequency, set by owner of the class
		private var _MIN_FREQ:Number = -1;
		private var _MAX_FREQ:Number = -1;
		
		//Aditional display information
		private var currF0:TextField;
		private var currNote:TextField;
		
		private var _showFreq:Boolean;
		private var _showNote:Boolean;
		
		//maximum acceptable error in cents
		private var _maxErrorCents:Number;
		
		//value tracking, for frequency interval calculations and normalizations
		// xxxAge values are for tracking position of the value and avoid the problem when they go out of range
		private var _prevMax:Number = Number.MIN_VALUE;
		private var _prevMaxAge:uint = 0;
		private var _currMax:Number = Number.MIN_VALUE;
		private var _currMaxAge:uint = 0;
		//private var _nextMax:Number = 1.0;
		//private var _nextMaxAge:uint = 0;
		
		private var _prevMin:Number = Number.MAX_VALUE;
		private var _prevMinAge:uint = 0;
		private var _currMin:Number = Number.MAX_VALUE;
		private var _currMinAge:uint = 0;
		//private var _nextMin:Number = 0.0;
		//private var _nextMinAge:uint = 0;
		
		private var _prevFreqInterval:Number = Number.MIN_VALUE;
		private var _currFreqInterval:Number = Number.MIN_VALUE;
		private var _nextFreqInterval:Number = Number.MIN_VALUE;
		
		//for accepted error interval calculations for the gui
		private var standardNotesVector:Vector.<Note>;
		
		//colouring
		private var _okColour:uint, _errColour:uint;
		
		//actual display of the data
		private var _display:BMPAmplitudGraph;
		private var _freqBar:VerticalScale;
		//names and marks for the notes
		private var _namesVector:Vector.<TextField>;
		private var _linesVector:Vector.<Shape>;
		
		protected var _txtObject:TextField;
		
		protected var _updateMax:Boolean;
		/**
		 * Display for the volueme (maybe later will make it more generic)
		 * 
		 * @param	w = width
		 * @param	h = height
		 * @param	
		 */
		public function FrequencyAutoIntervalDisplay(w:uint = 640 , h:uint = 480,
													maxErrorCents:Number = 20,  //is big cause is for singing, is not an instrument tuned
													label:String = "Frequency (Hz)",
													pointWidth:Number = 2, pointHeight:Number = 4,
													okColour:uint = 0x00FF00, errorColour:uint = 0xFF0000,
													backgroundColour:uint = 0x050505,
													showFreq:Boolean = true, showNote:Boolean =true)
		{
			_w = w;
			_h = h;
			_label = label;
			_maxErrorCents = maxErrorCents;
			
			_okColour = okColour;
			_errColour = errorColour;
			
			_showFreq = showFreq;
			_showNote = showNote;
			
			_display = new BMPAmplitudGraph(_w - 30,_h);
			_display.x = 25;
			_display.y = 0;
			_display.alpha = 0.8;
			//addChild(_display);
			//scales
			_freqBar = new VerticalScale(24, _h);
			_freqBar.x = 5;
			_freqBar.y = 0;
			//addChild(_freqBar);
			//naming the frequency display
			//_txtObject = new TextField();
			//_txtObject.x = 5;
			//_txtObject.y = 1;
			//_txtObject.text = _label;
			//_txtObject.textColor = 0xFFFFFF;
			//_txtObject.selectable = false;
			//addChild(_txtObject);
			
			//Aditional information
			
			//Text ->frequency and error information
			if (_showNote)
			{
				currNote = new TextField();
				currNote.x = _w * 0.12;
				currNote.y = 20;
				var format:TextFormat = new TextFormat();
				format.size = 35;
				//format.textColor = 0xffffff;
				//format.
				currNote.defaultTextFormat = format;
				currNote.textColor = 0xFFFF44;
				//currNote.maxChars = 4;
				currNote.text = "A0";
				//addChild(currNote);
			}
			if(_showFreq)
			{
				currF0 = new TextField();
				currF0.x = _w * 0.12;
				currF0.y = 5;
				currF0.textColor = 0xFFAA55;
				//currF0.maxChars = 5;
				currF0.text = "0000 Hz";
				//addChild(currF0);
			}
			//initializing displays vectors and other things...
			//calculate current 
			_currentSamplesShown = 200;// _w - 30; //WARNING, TODO: this is fixed like this only for the moment, then should be calculated dinamically!!!
			_currentNotesVect = new Vector.<Note>(_currentSamplesShown); 
			_valsVect = new Vector.<Number>(_currentSamplesShown); 
			_coloursVect = new Vector.<uint>(_currentSamplesShown); 
			
			_linesVector = new Vector.<Shape>;
			_namesVector = new Vector.<TextField>;
			
			
			metronomeDisplay = new VisualMetronomeMarks(_w - 30, _h, _currentSamplesShown);
			metronomeDisplay.x = 25;
			metronomeDisplay.y = 0;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//amplitud display
			//_display = new BMPAmplitudGraph(_w - 30,_h);
			//_display.x = 25;
			//_display.y = 0;
			addChild(_display);
			//scales
			//_freqBar = new VerticalScale(24, _h);
			//_freqBar.x = 5;
			//_freqBar.y = 0;
			addChild(metronomeDisplay);
			
			addChild(_freqBar);
			//naming the frequency display
			//_txtObject = new TextField();
			//_txtObject.x = 5;
			//_txtObject.y = 1;
			//_txtObject.text = _label;
			//_txtObject.textColor = 0xFFFFFF;
			//_txtObject.selectable = false;
			//addChild(_txtObject);
			
			//Aditional information
			//Text ->frequency and error information
			if (_showNote)
			{
				//currNote = new TextField();
				//currNote.x = _w * 0.12;
				//currNote.y = 20;
				//var format:TextFormat = new TextFormat();
				//format.size = 35;
				//format.textColor = 0xffffff;
				//format.
				//currNote.defaultTextFormat = format;
				//currNote.textColor = 0xFFFF44;
				//currNote.maxChars = 4;
				//currNote.text = "A0";
				addChild(currNote);
			}
			if(_showFreq)
			{
				//currF0 = new TextField();
				//currF0.x = _w * 0.12;
				//currF0.y = 5;
				//currF0.textColor = 0xFFAA55;
				//currF0.maxChars = 5;
				//currF0.text = "0000 Hz";
				addChild(currF0);
			}
			//initializing displays vectors and other things...
			//calculate current 
			//_currentSamplesShown = 100;// _w - 30; //WARNING, TODO: this is fixed like this only for the moment, then should be calculated dinamically!!!
			//_currentNotesVect = new Vector.<Note>(_currentSamplesShown); 
			//_valsVect = new Vector.<Number>(_currentSamplesShown); 
			//_coloursVect = new Vector.<uint>(_currentSamplesShown); 
			//
			//_linesVector = new Vector.<Shape>;
			//_namesVector = new Vector.<TextField>;
		
		}
		
		
		//public function setPercentageViewInterval(initPercentage:uint, endPercentage:uint):void
		//{
			// //TODO
		//}
		
		//public function setViewSamplesInterval(initSampleNumber:uint, endSampleNumber:uint):void
		//{
			// //TODO
		//}
		//
		//public function setViewTimeInterval(initTime:uint, endTime:uint):void
		//{
			// //TODO
		//}
		public function clear():void
		{
			_currentNotesVect = new Vector.<Note>(_currentSamplesShown);
			_valsVect = new Vector.<Number>(_currentSamplesShown); 
			_coloursVect = new Vector.<uint>(_currentSamplesShown);
			metronomeDisplay.clear();
			//_linesVector = new Vector.<Shape>;
			//_namesVector = new Vector.<TextField>;
			update(null);
		}
		
		
		public function showVector( notes:Vector.<Note>, marks:Vector.<Boolean>=null):void
		{
			trace("showVector Freq visualizer");
			for each(var n:Note in notes)
			{
				update(n);
			}
			metronomeDisplay.showVector(marks);
		}
		
		public function update(note:Note, tick:Boolean = false ):void
		{
			if (!note) note = new Note(Number.MAX_VALUE, "C", uint.MAX_VALUE, uint.MAX_VALUE);
			//WARNING, MAX and MIN_FREQ must be set
			if (MAX_FREQ < 0 || MIN_FREQ < 0)
			{
				trace("ERROR in FrequencyAutoIntervalDisplay, max and min freauencies not set");
				throw(new Error("ERROR in FrequencyAutoIntervalDisplay, max and min freauencies not set"));
			}
			//current notes in the display
			_currentNotesVect.shift();
			_currentNotesVect.push(note);

			//check the display interval (and if modified, then recheck all values in the valsVect)
			{
				//TODO improve efficiency of this code, for the moment I recalculate everything every time
				//get max and min values -> this could be done tracking the input instead of rechecking all the values each time
				//for (var i:uint = 0; i < _currentNotesVect.length ; i++)
				_currMax = Number.MIN_VALUE;
				_currMin = Number.MAX_VALUE;
				for each(var tn:Note in _currentNotesVect)
				{
					//test max
					if (tn && tn.freq <=  _MAX_FREQ && tn.freq > _currMax)
					{
						//_prevMax = _currMax;
						_currMax = tn.freq;
					}
					//test min
					if (tn && tn.freq >=  _MIN_FREQ && tn.freq < _currMin)
					{
						//_prevMin = _currMin;
						_currMin = tn.freq;
					}
				}
				//calculate interval
				_nextFreqInterval = _currMax - _currMin;
				//if (_nextFreqInterval - _currFreqInterval > 0.001) //equality condition for non int must be an epsilon value
				{
					_prevFreqInterval = _currFreqInterval;
					_currFreqInterval = _nextFreqInterval;
					for (var i:uint = 0; i < _currentNotesVect.length ; i++)
					{
						if(_currentNotesVect[i])
							_valsVect[i] = (_currentNotesVect[i].freq - _currMin) / _currFreqInterval;
					}
					
					//TODO redo the scales
				}
			}
			
			//calculate the normalized to [0,1] interval, DC must be eliminated
			var v:Number = (note.freq - _currMin) / _currFreqInterval;
			_valsVect.shift();
			_valsVect.push(v);
		
			if (note.freq >= MIN_FREQ && note.freq <= MAX_FREQ)
			{
				currNote.text = note.name + " " +note.octave;
				currF0.text = note.freq.toString().substr(0,6) + " Hz";
			}
			//check colour for the display according to error policy .
			//var c:uint = _errColour;
			//if (Math.abs(note.errorCents) < _maxErrorCents)
			//{
				//c = _okColour;
			//}
			//colour according to the note
			var c:uint = note.colour;
			
			_coloursVect.shift();
			_coloursVect.push(c);
			//update accepted cents error regions
			
			
			//draw
			_display.drawGraph(_valsVect, _coloursVect);
			_freqBar.update(_currMin, _currMax)
			//redo the lines
			resetStandardNotesVector(_currMin, _currMax);
			drawNotesLines(createAcceptedErrorRegions());
			
			metronomeDisplay.update(tick);
			
		}
		
		public function get MIN_FREQ():Number 
		{
			return _MIN_FREQ;
		}
		
		
		public function set MIN_FREQ(value:Number):void 
		{
			_MIN_FREQ = value;
			resetStandardNotesVector(_MIN_FREQ,_MAX_FREQ);
		}
		
		public function get MAX_FREQ():Number 
		{
			return _MAX_FREQ;
		}
		
		public function set MAX_FREQ(value:Number):void 
		{
			_MAX_FREQ = value;
			resetStandardNotesVector(_MIN_FREQ,_MAX_FREQ)
		}
		
		private function resetStandardNotesVector(min:Number, max:Number):void
		{
			standardNotesVector = new Vector.<Note>;
			var noteMapper:NoteMapper = new NoteMapper;
			
			for each( var f:Number in NoteMapper.NOTES_FREQUENCIES)
			{
				if (f >= min && f <= max)
				{
					noteMapper.updateFreq(f)
					var n:Note = noteMapper.getNote();
					standardNotesVector.push(n);
				}
			}
			
		}
		
		//returns a vector of normalized [0,1] values 
		private function createAcceptedErrorRegions():Vector.<CenteredRectData>
		{
			var vect:Vector.<CenteredRectData> = new Vector.<CenteredRectData>;
			for each(var n:Note in standardNotesVector)
			{
				var cr:CenteredRectData = new CenteredRectData;
				cr.centralVal = (n.freq - _currMin) / _currFreqInterval;
				cr.name = n.name
				cr.colour = n.colour;
				vect.push(cr);
			}
			
			return vect;
		}
		
		
		public function drawNotesLines(vect:Vector.<CenteredRectData>):void
		{
			var xbase:Number = 25;
			var ybase:Number = 20;
			var w:Number = _w -30;
			var h:Number = _h - 25;
			
			for each(var l:Shape in _linesVector)
			{
				if (l.parent)
				{
					removeChild(l);
				}
			}
			_linesVector = new Vector.<Shape>;
			
			for each(var tt:TextField in _namesVector)
			{
				if (tt.parent)
				{
					removeChild(tt);
				}
			}
			_namesVector = new Vector.<TextField>;
			
			
			for each(var v:CenteredRectData in vect)
			{
				//line
				var scaleLine:Shape = new Shape;
				scaleLine.graphics.lineStyle( 2, 0x505050, 0.3 );
				var ypos:Number =  (h + ybase) - (h * v.centralVal); // offset - pixels from the bottom
				scaleLine.graphics.moveTo(xbase + 30, ypos );
				scaleLine.graphics.lineTo( xbase + w,  ypos);
				_linesVector.push(scaleLine);
				addChild(scaleLine);
				//text
				var t:TextField = new TextField();
				t.maxChars = 5;
				t.text = v.name;
				t.width = 0;
				t.height = 10;
				t.x = xbase + 15 ;
				t.y = ypos - t.height;
				t.selectable = false;
				t.textColor = 0x505050;
				t.autoSize = TextFieldAutoSize.CENTER;
				_namesVector.push(t);
				addChild(t);
			}
			
		}
		
	}

}