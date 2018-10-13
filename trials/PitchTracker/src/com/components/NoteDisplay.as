package com.components 
{
	import com.gui_elements.bmp_graphs.BMPNoteDisplay;
	import com.music_concepts.Note;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class NoteDisplay extends Sprite 
	{
		private var _w:Number, _h:Number;
		private var _display:BMPNoteDisplay;
		private var _label:String;
		
		private var _MIN_FREQ:Number = -1;
		private var _MAX_FREQ:Number = -1;
		
		private var _currentSamplesShown:uint;
		private var _currentNotesVect:Vector.<Note>; //current notes being displayed
		
		private var _txtObject:TextField;
		private var _namesVector:Vector.<TextField>;
		private var _linesVector:Vector.<Shape>;
		
		private var _bgc:uint;
		
		public function NoteDisplay(w:Number = 640 , h:Number = 50, label:String = "Notes", backgroundColour:uint = 0x000000 )
		{
			_w = w;
			_h = h;
			_label = label;
			_bgc = backgroundColour;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			_namesVector = new Vector.<TextField>;
			_linesVector = new Vector.<Shape>;
			
			//background
			var rectangle1:Shape = new Shape; // initializing the variable named rectangle
			//rectangle1.graphics.lineStyle(1, 0x000000, 0.9);
			rectangle1.graphics.beginFill(_bgc); // choosing the colour for the fill
			rectangle1.graphics.drawRect( 5 , 0, _w - 10, _h);// (x spacing, y spacing, width, height)
			rectangle1.graphics.endFill(); // not always needed but I like to put it in to end the fill
			addChild(rectangle1); // adds the rectangle to the stage	
			
			_display = new BMPNoteDisplay(_w - 30, _h);
			_display.x = 25;
			_display.y = 0;
			//no more labels, they occupy space and do not give enough back
			addChild(_display);
			
			
			var step:Number = _h / 12; //there are 12 notes in the scale
			
			for (var i:uint = 0; i < Note.NOTES_NAMES_SHARP_ARRAY.length; i++)
			{
				//text
				var t:TextField = new TextField();
				var tf:TextFormat = new TextFormat();
				tf.size = step +2;
				t.defaultTextFormat = tf;
				t.selectable = false;
				t.maxChars = 5;
				t.text = Note.NOTES_NAMES_SHARP_ARRAY[i];
				t.width = 0;
				t.height = step - 2;
				//t.textColor = 0xffff55; //Maybe should set the color of the font according to the color of the note
				t.textColor = Note.NOTES_COLOURS_ARRAY[i];
				t.autoSize = TextFieldAutoSize.CENTER;
				t.x =  10 * ((i % 2)+1) -5;
				t.y = _h - step*(i+1) - t.height/3;
				_namesVector.push(t);
				addChild(t);
				//line
				var scaleLine:Shape = new Shape;
				scaleLine.graphics.lineStyle( 1, 0x505030, 0.3 );
				var ypos:Number =  _h - step*(i+1); // offset - pixels from the bottom
				scaleLine.graphics.moveTo( 30, ypos );
				scaleLine.graphics.lineTo( _w -5,  ypos);
				_linesVector.push(scaleLine);
				addChild(scaleLine);
			}
			
			_currentSamplesShown = 100;// _w - 30; //WARNING, TODO: this is fixed like this only for the moment, then should be calculated dinamically!!!
			_currentNotesVect = new Vector.<Note>(_currentSamplesShown);
		}
		
		public function clear():void
		{
			_currentNotesVect = new Vector.<Note>(_currentSamplesShown);
			update(null);
		}
		
		public function showVector( notes:Vector.<Note>):void
		{
			trace("showVector notes display");
			for each(var n:Note in notes)
			{
				update(n);
			}
		}
		
		public function update(note:Note):void
		{
			if (!note) note = new Note(Number.MAX_VALUE, "C", uint.MAX_VALUE, uint.MAX_VALUE);
			//WARNING, MAX and MIN_FREQ must be set
			if (_MAX_FREQ < 0 || _MIN_FREQ < 0)
			{
				trace("ERROR in FrequencyAutoIntervalDisplay, max and min freauencies not set");
				throw(new Error("ERROR in FrequencyAutoIntervalDisplay, max and min freauencies not set"));
			}
			//current notes in the display
			_currentNotesVect.shift();
			if(note.freq >= _MIN_FREQ && note.freq <= _MAX_FREQ)
			{
				_currentNotesVect.push(note);
			}else
			{
				_currentNotesVect.push(null);
			}
			
			
			//draw
			_display.drawGraph(_currentNotesVect);
			
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