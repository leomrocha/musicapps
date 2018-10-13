package com.gui_elements 
{
	import com.music_concepts.Note;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PseudoMusicSheetNote extends Sprite 
	{
		private var _note:Note;
		private var _drawLine:Boolean;
		private var _line:Shape; //if line has to be drawn for this particular note
		private var _circle:Shape;
		private var _r:Number;
		private var _fillColour:uint;
		//private var _isAccidental:Boolean;
		
		//accidentals
		private var _sharp:Shape; //if needed
		private var _flat:Shape; //if needed
		
		public function PseudoMusicSheetNote(note:Note, radious:Number, colour:uint, drawLine:Boolean = false) 
		{
			_note = note;
			_r = radious;
			_fillColour = colour;
			//_fillColour = 0xffff6a;
			_drawLine = drawLine;
			
			//isAccidental = false;
			
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//amplitud display
			
			_circle = new Shape; // initializing the variable named rectangle
			if (Note.IS_SHARP[_note.name])
			{
				//_circle.graphics.lineStyle(1, 0xffffff, 0.9);
				_circle.graphics.beginFill(_fillColour, 0.7); 
				_circle.graphics.drawRect(-_r,-_r, 2*_r, 2*_r);
				_circle.graphics.endFill(); 

			}else if (Note.IS_FLAT[_note.name])
			{
				//_circle.graphics.lineStyle(1, 0xffffff, 0.9);
				_circle.graphics.beginFill(_fillColour, 0.7); 
				_circle.graphics.moveTo( -_r, _r);
				_circle.graphics.lineTo( _r, _r);
				_circle.graphics.lineTo( 0, -_r);
				_circle.graphics.lineTo( -_r, _r);
				//_circle.graphics.drawRect(-_r,-_r, 2*_r, 2*_r);
				_circle.graphics.endFill(); 

			}
			else{
				//_circle.graphics.lineStyle(1, 0xffffff, 0.9);
				_circle.graphics.beginFill(_fillColour, 0.7); 
				_circle.graphics.drawCircle(0,0,_r);
				_circle.graphics.endFill(); 
			}
			addChild(_circle); // adds the rectangle to the stage
			
			if (_drawLine)
			{
				_line =  new Shape;
				_line.graphics.lineStyle( 2, 0xf0f0f0, 0.9 );
				_line.graphics.moveTo( - _r -2, 0);
				_line.graphics.lineTo(_r + 2, 0);// 
				addChild(_line); // adds the rectangle to the stage
			}
		}
		
		public function get colour():uint 
		{
			return _fillColour;
		}
		
		public function set colour(value:uint):void 
		{
			_fillColour = value;
		}
		
		//private function update():void
		
		
	}

}