package com.gui_elements 
{
	import com.music_concepts.Note;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class SimpleSheet extends Sprite 
	{
		protected var _notes:Vector.<Note>;
		protected var _mainLinesVector:Vector.<Line>;
		protected var _overLinesVector:Vector.<Line>;
		protected var _underLinesVector:Vector.<Line>;
		protected var _w:uint;
		protected var _h:uint;
		protected var _maxOverLines:uint;
		protected var _numberLines:uint;
		protected var _numberSpaces:uint;
		
		//
		
		
		public function SimpleSheet(overlines:uint = 4, w:uint=1024, h:uint=600) 
		{
			_maxOverLines = overlines;
			_w = w;
			_h = h;
			_numberLines = overlines * 2 + 5;
			_numberSpaces = _numberLines + 1;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_notes = new Vector.<Note>;
			_mainLinesVector = new Vector.<Line>;
			_overLinesVector = new Vector.<Line>;
			_underLinesVector = new Vector.<Line>;
			
			//draw the five base lines
			var ystep:Number = Number(_h) / Number(_numberSpaces);
			var yfirstFixedLine:Number = ystep * (_maxOverLines + 1);
			var xlinepos:Number = _w * 0.15;
			var lineLength:Number =  _w * 0.85 - xlinepos;
			var i:uint;
			//now create the FIVE fixed lines)
			for (i = 0; i < 5 ; i++)
			{
				var l:Line = new Line(lineLength);
				l.x = xlinepos;
				l.y = yfirstFixedLine + ystep * i;
				addChild(l);
				_mainLinesVector.push(l);
			}
			xlinepos = _w * 0.55;
			lineLength=  _w * 0.75 - xlinepos;
			//lines over the main fixed lines (will appear only if a note is being painted over it)
			for (i = 0; i < _maxOverLines; i++)
			{
				var l:Line = new Line(lineLength);
				l.x = xlinepos;
				l.y = yfirstFixedLine + ystep * i;
				//addChild(l);
				_overLinesVector.push(l);
			}
			//lines under the main fixed lines (IDEM as previous case)
			for (i = 0; i < _maxOverLines; i++)
			{
				var l:Line = new Line(lineLength);
				l.x = xlinepos;
				l.y = yfirstFixedLine + ystep * i;
				//addChild(l);
				_underLinesVector.push(l);
			}
			
			//draw the "clave"
			//draw the "armadura en clave"
			
			//dimensions
			//this.width  = _w;
			//this.height = _h;
			//this.scaleX = 1;
			//this.scaleY = 1;
		}
		
		//private function drawMainLines():void
		//{
			//get height and width
			//calculate the position for the 5 main lines
			//create them
			//add them to the stage
		//}
		
		//private function drawLine():void
		//{
			//
		//}
		
		public function clear():void
		{
			//erase the notes from the drawing
			for each (var n:Note in _notes)
			{
				if (n.parent != null)
				{
					removeChild(n);
				}
			}
			//erase all the extra lines drawn for the notes
			for each ( var l:Line in _overLinesVector)
			{
				if (l.parent != null)
				{
					removeChild(l);
				}
			}
			for each ( var l:Line in _underLinesVector)
			{
				if (l.parent != null)
				{
					removeChild(l);
				}
			}
			// erase all the notes
			_notes = new Vector.<Note>;
		}
		
		public function get notes():Vector.<Note> 
		{
			return _notes;
		}
		
		public function set notes(notesVector:Vector.<Note>):void 
		{
			//clear all the previous things
			for each (var n:Note in notesVector)
			{
				drawNote(n);
			}
			_notes = notesVector;
		}
		
		public function drawNote(note:Note):void
		{
			//check the posoition in  which the note should be drawn
			//check if we need an extra line
			// if so draw it
			// check the type of note
			// draw it
			// check if we need an accidental
			// if so, draw it
		}
		
	}

}