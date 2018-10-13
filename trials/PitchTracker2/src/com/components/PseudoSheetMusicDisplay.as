package com.components 
{
	import com.gui_elements.GradientButton;
	import com.gui_elements.PseudoMusicSheetNote;
	import com.gui_elements.SimpleLine;
	import com.music_concepts.Note;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PseudoSheetMusicDisplay extends Sprite 
	{
		
		private var _w:uint;
		private var _h:uint;
		private var _label:String;
		
		private var _bgc:uint;
		private var _currentSamplesShown:uint;
		
		private var _currentNotesVect:Vector.<Note>; //current notes being displayed
		
		//private var _nextVectorToShow:Vector.<Note>; //is an easy hack to implement the vector showing with a complete input vector
		private var _displayNotesVect:Vector.<PseudoMusicSheetNote>;
		
		private var _yValsVect:Vector.<Number>; //current values to show, normalized to 1
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
		
		//colouring
		private var _okColour:uint, _errColour:uint;
		
		//actual display of the data
		//private var _display:BMPAmplitudGraph;
		//private var _freqBar:VerticalScale;
		//names and marks for the notes
		//private var _namesVector:Vector.<TextField>;
		private var _linesVector:Vector.<Shape>;
		private var _sheetLinesVector:Vector.<Shape>;
		private var _ticksVector:Vector.<SimpleLine>;
		
		private var _ystep:Number; //amplification factor, the step needed for each note to be drawn, the y scale is discreete
		private var _xstep:Number; //x step between consecutive samples to fullfil the screen with the nulber of samples on screen
		//protected var _txtObject:TextField;
		
		private const NOTES_NAMES_K_VALUE:Object = { "C":1, "C#":1, "Db":2, "D":2, "D#":2, "Eb":3, "E":3,
														   "F":4, "F#":4, "Gb":5, "G":5, "G#":5, "Ab":6, "A":6,
														   "A#":6, "Bb":7, "B":7 };
		//private const NOTES_NAMES_K_VALUE:Object = { "C":4, "C#":4, "Db":5, "D":5, "D#":5, "Eb":6, "E":6,
														   //"F":7, "F#":7, "Gb":8, "G":8, "G#":9, "Ab":9, "A":9,
														   //"A#":10, "Bb":10, "B":10 };
														   
		private var DRAW_LINES:Vector.<Boolean> ;//

		
		[Embed(source = "../../../assets/clef_sol_grey.svg")]
		private var ClefG:Class;
		[Embed(source = "../../../assets/Bass_clef.svg")]
		private var ClefF:Class;
		
		private var clefG:Sprite;
		private var clefF:Sprite;
		
		private var sheetLinesIndex:Array = [11, 13, 15, 17, 19, 23, 25, 27, 29, 31];
		
		private var plus8Button:GradientButton;
		private var minus8Button:GradientButton;
		
		//protected var _updateMax:Boolean;
		/**
		 * Display for the volueme (maybe later will make it more generic)
		 * 
		 * @param	w = width
		 * @param	h = height
		 * @param	
		 */
		public function PseudoSheetMusicDisplay(w:uint = 640 , h:uint = 480,
													maxErrorCents:Number = 20,  //is big cause is for singing, is not an instrument tuned
													label:String = "Sheet",
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
			_bgc = backgroundColour;
			
			_showFreq = showFreq;
			_showNote = showNote;
			
			if (_showNote)
			{
				currNote = new TextField();
				currNote.x = _w * 0.05;
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
				currF0.x = _w * 0.05;
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
			_displayNotesVect = new Vector.<PseudoMusicSheetNote>(_currentSamplesShown);
			
			_ticksVector = new Vector.<SimpleLine>; //metronome ticks history
			
			_yValsVect = new Vector.<Number>(_currentSamplesShown); 
			_coloursVect = new Vector.<uint>(_currentSamplesShown); 
			
			_linesVector = new Vector.<Shape>;
			_sheetLinesVector = new Vector.<Shape>;
			//_namesVector = new Vector.<TextField>;
			
			_ystep = Number(_h) / 40.0;//40 because is the number of notes I will be able to draw in the vertical scale
			//_xstep = (Number(_w) -60) / Number(_currentSamplesShown);
			_xstep = (Number(_w) -40) / Number(_currentSamplesShown);
			
			//line drawing:
			
			DRAW_LINES = new Vector.<Boolean>(40);
			for (var i:uint = 0; i < 40; i++)
			{
				DRAW_LINES[i] = false;
			}
			//var lineok:Array = [1, 3, 5, 7, 9, 21, 33, 35, 37, 39];
			var lineok:Array = [2, 4, 6, 8, 10, 22, 34, 36, 38, 40];
			for each(var j:uint in lineok)
			{
				DRAW_LINES[j] = true;
			}
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//background
			var rectangle1:Shape = new Shape; // initializing the variable named rectangle
			//rectangle1.graphics.lineStyle(1, 0x000000, 0.9);
			rectangle1.graphics.beginFill(_bgc); // choosing the colour for the fill
			rectangle1.graphics.drawRect( 5 , 0, _w - 10, _h);// (x spacing, y spacing, width, height)
			rectangle1.graphics.endFill(); // not always needed but I like to put it in to end the fill
			rectangle1.alpha = 0.8;
			addChild(rectangle1); // adds the rectangle to the stage	
			
			plus8Button = new GradientButton("+8", 20, 20 , 5, 0x202020, 0x303030);
			plus8Button.x = 5; // _w * 0. - _w / 12;
			plus8Button.y = _h *0.47;
			plus8Button.addEventListener(MouseEvent.CLICK, onPlus8Clicked);
			addChild(plus8Button);
			
			minus8Button = new GradientButton("-8", 20, 20 , 5, 0x202020, 0x303030);
			minus8Button.x = 5; // _w * 0. - _w / 12;
			minus8Button.y = _h *0.53;
			minus8Button.addEventListener(MouseEvent.CLICK, onMinus8Clicked);
			addChild(minus8Button);
			
			//scales
			//_freqBar = new VerticalScale(24, _h);
			//_freqBar.x = 5;
			//_freqBar.y = 0;
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

			//lines
			
			//for each(var v:uint in sheetLinesIndex)
			for (var i:uint = 0; i < 39; i++)
			{
				//line
				var scaleLine:Shape = new Shape;
				scaleLine.graphics.lineStyle( 2, 0x0f0f0f0f, 0.5 );
				var ypos:Number = _h - (i +1)*_ystep ; // offset - pixels from the bottom
				scaleLine.graphics.moveTo( 30, ypos );
				//scaleLine.graphics.lineTo( _w - 30,  ypos);
				scaleLine.graphics.lineTo( _w-10,  ypos);
				_linesVector.push(scaleLine);
				addChild(scaleLine);
			}
			
			//Text ->frequency and error information
			if (_showNote)
			{
				addChild(currNote);
			}
			if(_showFreq)
			{
				addChild(currF0);
			}
			
			clefG = new ClefG();
			clefG.width = 40;
			clefG.height = _ystep * 5;
			clefG.scaleX = 0.15;
			clefG.scaleY = 0.15;
			
			clefF = new ClefF();
			clefF.width = 40;
			clefF.height = _ystep * 4.5;
			clefF.scaleX = 1.3;
			clefF.scaleY = 1.5;
			
			
			sheetLinesBaseTreble();
		}
		
		private function onPlus8Clicked(e:MouseEvent):void
		{
			sheetLinesMove8( -1);
		}
		private function onMinus8Clicked(e:MouseEvent):void
		{
			sheetLinesMove8( +1);
		}
		//moves up the lines
		private function sheetLinesMove8(dir:int = -1):void
		{
			for each(var l:Shape in _sheetLinesVector)
			//for (var v:uint = 0; i < 41; i++)
			{
				//line
				l.y += dir*(7 * _ystep);
				//addChild(scaleLine);
			}
			

			//clefG.x = 10;
			clefG.y += dir*(7 * _ystep);
			//addChild(clefG);
			
			//clefF.x = 30;
			clefF.y += dir*(7 * _ystep);
			//addChild(clefF);
			
			//put the text over everything
			if (_showNote)
			{
				removeChild(currNote);
				addChild(currNote);
			}
			if(_showFreq)
			{
				removeChild(currF0);
				addChild(currF0);
			}
		}
		
		private function sheetLinesBaseTreble():void
		{

			for each(var v:uint in sheetLinesIndex)
			//for (var v:uint = 0; i < 41; i++)
			{
				//line
				var scaleLine:Shape = new Shape;
				scaleLine.graphics.lineStyle( 2, 0xf0f0f0, 0.5 );
				var ypos:Number= _h - ( (v +1)*_ystep ); // offset - pixels from the bottom
				scaleLine.graphics.moveTo( 30, ypos );
				//scaleLine.graphics.lineTo( _w - 30,  ypos);
				scaleLine.graphics.lineTo( _w - 10,  ypos);
				_sheetLinesVector.push(scaleLine);
				addChild(scaleLine);
			}
			

			clefG.x = 10;
			clefG.y = _h - (35 * _ystep);
			addChild(clefG);
			
			clefF.x = 30;
			clefF.y = _h - (20 * _ystep);
			addChild(clefF);
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
			for each(var n:PseudoMusicSheetNote in _displayNotesVect)
			{
				if (n && n.parent)
				{
					removeChild(n);
				}
			}
			_displayNotesVect = new Vector.<PseudoMusicSheetNote>(_currentSamplesShown);
			_currentNotesVect = new Vector.<Note>(_currentSamplesShown);
			_yValsVect = new Vector.<Number>(_currentSamplesShown); 
			_coloursVect = new Vector.<uint>(_currentSamplesShown);
			
			for each (var mt:SimpleLine in _ticksVector)//move metronome marks
			{
				if (mt && mt.parent)
				{
					removeChild(mt);
				}
			}
			_ticksVector = new Vector.<SimpleLine>;
			//_linesVector = new Vector.<Shape>;
			//_namesVector = new Vector.<TextField>;
			update(null,false);
		}
		
		public function showVector( notes:Vector.<Note>, marks:Vector.<Boolean>=null):void
		{
			trace("showVector Freq visualizer");
			if (marks && marks.length === notes.length)
			{
				for (var i:uint = 0; i < notes.length; i++)
				{
					update(notes[i], marks[i]);
				}
			}
			else
			{
				for each(var n:Note in notes)
				{
					update(n,false);//TODO also is missing the metronome ticks vector!!
				}
			}
			
		}
		
		public function update(note:Note, tick:Boolean, _tickInCompass:uint = 0 ):void
		{
			//trace("tick at music sheet update = ", tick);
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

			//TODO check the display interval (and if modified, then recheck all values in the valsVect)
			
			
			//calculate y position of the new element
			var vy:uint = ( 7 * (note.octave -1) + NOTES_NAMES_K_VALUE[note.name]);
			var ypos:Number = _h - (vy * _ystep);// (note position ) * position_amplfier_factor
			_yValsVect.shift();
			_yValsVect.push(ypos);
			//var xpos:Number = _w - 30;
			var xpos:Number = _w-10;
		
			//check colour for the display according to error policy .
			var c:uint = _errColour;
			//if (Math.abs(note.errorCents) < _maxErrorCents)
			//{
				//c = _okColour;
			//}
			//{
				//var  proxim:Number;
				//if (Math.abs(note.errorCents) < _maxErrorCents)
				//{
					//proxim = Math.log( 1 + ( (50.0 - Math.abs(note.errorCents) ) / 50.0 ) )/ Math.log(2);
				//}
				//else
				//{
					//proxim = Math.log( 1 + ( (50.0 - Math.abs(note.errorCents) ) / 50.0 ) );
				//}
				//
				//
				//c = ( uint(0xff * (1 - proxim) ) << 16 ) + ( uint(0xff * (proxim) ) << 8); // RR and GG components
			//}
			//colour according to the note
			//var c:uint = note.colour;
			//colour according to accidental or not accidental
			if (Note.IS_FLAT[note.name])
			{
				c = 0xff22ff;
			}else if (Note.IS_SHARP[note.name])
			{
				c = 0x2266ff;
			}else
			{
				c = 0xffffaa;
			}
			//update accepted cents error regions
			
			//caclulate if needs line or not
			try {
				var drawLine:Boolean = DRAW_LINES[vy];
			}catch (e:Error)
			{
				//bhaaa
			}
			
			
			var dn:PseudoMusicSheetNote = new PseudoMusicSheetNote(note, _xstep*2, c, drawLine);
			dn.x = xpos;
			dn.y = ypos;
			
			
			var prevN:PseudoMusicSheetNote = _displayNotesVect.shift();
			try {
					removeChild(prevN);
			}catch ( e:Error)
			{
				//prevN was null
			}
			
			if (note.freq >= MIN_FREQ && note.freq <= MAX_FREQ)
			{
				currNote.text = note.name + " " +note.octave;
				currF0.text = note.freq.toString().substr(0, 6) + " Hz";
				
				addChild(dn);
				
			}
			_displayNotesVect.push(dn);
			
			//move all the elements xstep to the left
			//I know this is not fast, but it works for the moment and I want something now
			//var tweenArr:Array = new Array();
			
			//metronome mark lines creation
			if (tick)
			{
				var tc:uint = 0xa0a040;
				if (_tickInCompass == 0) tc = 0xff5040;
				var mMark:SimpleLine = new SimpleLine(_h - 100, 1, tc);
				mMark.x = xpos;
				mMark.y = 50;
				_ticksVector.push(mMark);
				addChild(mMark);
			}
			//metronome update
			if (_ticksVector.length > 0)//clean old metronome marks
			{
				if (_ticksVector[0].x < 30)
					{
						var sl:SimpleLine = _ticksVector.shift();
						removeChild(sl);
					}
			}
			for each (var mt:SimpleLine in _ticksVector)//move metronome marks
			{
				if (mt)
				{
					mt.x -= _xstep;
				}
			}
			//notes
			for each(var np:PseudoMusicSheetNote in  _displayNotesVect)//move notes
			{
				if (np)
				{
					np.x -= _xstep;
					//tweenArr[tweenArr.length] = np;
				}
			}

			//TweenMax.allTo(tweenArr, 0.1, { x: -_xstep } );

		}
		
		public function get MIN_FREQ():Number 
		{
			return _MIN_FREQ;
		}
		
		
		public function set MIN_FREQ(value:Number):void 
		{
			_MIN_FREQ = value;
			//resetStandardNotesVector(_MIN_FREQ,_MAX_FREQ);
		}
		
		public function get MAX_FREQ():Number 
		{
			return _MAX_FREQ;
		}
		
		public function set MAX_FREQ(value:Number):void 
		{
			_MAX_FREQ = value;
			//resetStandardNotesVector(_MIN_FREQ,_MAX_FREQ)
		}
		
	}

}