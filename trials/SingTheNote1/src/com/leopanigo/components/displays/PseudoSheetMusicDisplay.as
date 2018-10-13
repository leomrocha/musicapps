package com.leopanigo.components.displays 
{
	import com.leopanigo.components.buttons.GradientButton;
	import com.leopanigo.components.events.NotesMatchEvent;
	import com.leopanigo.components.sprites.DisplayNote;
	import com.leopanigo.components.sprites.SimpleLine;
	import com.leopanigo.music_concepts.Note;
	import com.leopanigo.music_concepts.NotesNameMapping;
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
		//private var _currentSamplesShown:uint;

		private var _currentNote:Note; //current Note being played
		private var _currentDisplayNote:DisplayNote; //display
		private var _levelNote:Note; //note that should be played
		private var _levelDisplayNote:DisplayNote; //display
		
		
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
		
		private var _linesVector:Vector.<Shape>;
		private var _sheetLinesVector:Vector.<Shape>;
		
		private var _displayList:Vector.<DisplayNote>;
		
		private var _ystep:Number; //amplification factor, the step needed for each note to be drawn, the y scale is discreete
		private var _xinit:Number = 50;
		
		private const NOTES_NAMES_K_VALUE:Object = { "C":1, "C#":1, "Db":2, "D":2, "D#":2, "Eb":3, "E":3,
														   "F":4, "F#":4, "Gb":5, "G":5, "G#":5, "Ab":6, "A":6,
														   "A#":6, "Bb":7, "B":7 };
														   
		private var DRAW_LINES:Vector.<Boolean> ;//

		
		[Embed(source = "../../../../../assets/clef_sol_grey10_40x100.svg")]
		private var ClefG:Class;
		[Embed(source = "../../../../../assets/Bass_clef_grey10_70x100.svg")]
		private var ClefF:Class;
		
		private var clefG:Sprite;
		private var clefF:Sprite;
		
		private var sheetLinesIndex:Array = [11, 13, 15, 17, 19, 23, 25, 27, 29, 31];
		
		private var plus8Button:GradientButton;
		private var minus8Button:GradientButton;
		
		
		/**
		 * Display for the volueme (maybe later will make it more generic)
		 * 
		 * @param	w = width
		 * @param	h = height
		 * @param	
		 */
		public function PseudoSheetMusicDisplay(w:uint , h:uint,
													maxErrorCents:Number = 30,  //is big cause is for singing, is not an instrument tuned
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
				currNote.defaultTextFormat = format;
				currNote.textColor = 0xFFFF44;
				currNote.text = "A0";
			}
			if(_showFreq)
			{
				currF0 = new TextField();
				currF0.x = _w * 0.05;
				currF0.y = 5;
				currF0.textColor = 0xFFAA55;
				currF0.text = "0000 Hz";
			}
			
			_ystep = Number(_h) / 40.0;//40 because is the number of notes I will be able to draw in the vertical scale

			_displayList = new Vector.<DisplayNote>;
			//line drawing:
			_sheetLinesVector = new Vector.<Shape>;
			_linesVector = new Vector.<Shape>;
			DRAW_LINES = new Vector.<Boolean>(40);
			for (var i:uint = 0; i < 40; i++)
			{
				DRAW_LINES[i] = false;
			}
			
			//TODO this is only for one of the positions of the lines, calculate for the others
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
			rectangle1.graphics.lineStyle(1, 0xaaaa66, 0.9);
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
			clefG.width = _xinit -20;
			clefG.height = _ystep * 5;
			clefG.scaleX = _ystep*9/100;
			clefG.scaleY = _ystep*9/100;
			
			
			clefF = new ClefF();
			clefF.width = _xinit -20;
			clefF.height = _ystep * 4.5;
			clefF.scaleX = _ystep*7/100;
			clefF.scaleY = _ystep*7/100;
			
			
			
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
			//recalculate the line drawing for the elements!!
			//TODO
		}
		
		private function sheetLinesBaseTreble():void
		{

			for each(var v:uint in sheetLinesIndex)
			{
				//line
				var scaleLine:Shape = new Shape;
				scaleLine.graphics.lineStyle( 2, 0xf0f0f0, 0.5 );
				var ypos:Number= _h - ( (v +1)*_ystep ); // offset - pixels from the bottom
				scaleLine.graphics.moveTo( 30, ypos );
				scaleLine.graphics.lineTo( _w - 10,  ypos);
				_sheetLinesVector.push(scaleLine);
				addChild(scaleLine);
			}
			

			clefG.x = 30;
			clefG.y = _h - (32 * _ystep);
			addChild(clefG);
			
			clefF.x = 30;
			clefF.y = _h - (20.5 * _ystep);
			addChild(clefF);
		}
		
		public function clear():void
		{
			if (_currentDisplayNote &&_currentDisplayNote.parent)
				removeChild(_currentDisplayNote);
			if (_levelDisplayNote && _levelDisplayNote.parent)
				removeChild(_levelDisplayNote);
			for each(var dn:DisplayNote in _displayList)
			{
				if (dn.parent) removeChild(dn);
			}
			_displayList = new Vector.<DisplayNote>;
		}
		

		public function drawNote(note:Note):void
		{
			var dn:DisplayNote = new DisplayNote(_ystep/2, _ystep/2, note);
			var vy:Number = 1.5+( 7 * (note.octave -1) + NOTES_NAMES_K_VALUE[note.name] );
			var ypos:Number = _h - (vy * _ystep);// (note position ) * position_amplfier_factor
			dn.x =  _xinit + (_w - _xinit)* 2/3;
			dn.y = ypos;
			addChild(dn);
			_displayList.push(dn);
		}
		
		public function setLevel(note:Note):void
		{
			clear();
			_levelNote = note;
			_levelDisplayNote = new DisplayNote(_ystep/2, _ystep/2, note);
			var vy:Number = 1.5+( 7 * (note.octave -1) + NOTES_NAMES_K_VALUE[note.name] );
			var ypos:Number = _h - (vy * _ystep);// (note position ) * position_amplfier_factor
			_levelDisplayNote.x =  _xinit + (_w - _xinit)* 2/3;
			_levelDisplayNote.y = ypos;
			addChild(_levelDisplayNote);
		}
		
		public function update(note:Note):void
		{
			if (note && note.freq >= MIN_FREQ && note.freq <= MAX_FREQ)
			{
				if (_currentDisplayNote && _currentDisplayNote.parent)
				{
					removeChild(_currentDisplayNote);
				}
				_currentNote = note;
				_currentDisplayNote = new DisplayNote(_ystep/2, _ystep/2, note);
				var vy:Number = 1.5+( 7 * (note.octave -1) + NOTES_NAMES_K_VALUE[note.name] );
				var ypos:Number = _h - (vy * _ystep);// (note position ) * position_amplfier_factor
				_currentDisplayNote.x =  _xinit + (_w - _xinit)/3;
				_currentDisplayNote.y = ypos;
				addChild(_currentDisplayNote);
				
				try{
					if (_currentNote.midiNote == _levelNote.midiNote && note.errorCents < _maxErrorCents)
					{
						//TODO SUCCESSS throw event that the level was completed
						dispatchEvent(new NotesMatchEvent());
					}
				}catch (e:Error){}
				
				currNote.text = note.name + " " +note.octave;
				currF0.text = note.freq.toString().substr(0, 6) + " Hz";
			}



		}
		
		public function get MIN_FREQ():Number 
		{
			return _MIN_FREQ;
		}
		
		
		public function set MIN_FREQ(value:Number):void 
		{
			_MIN_FREQ = value;
		}
		
		public function get MAX_FREQ():Number 
		{
			return _MAX_FREQ;
		}
		
		public function set MAX_FREQ(value:Number):void 
		{
			_MAX_FREQ = value;
		}
		
	}

}