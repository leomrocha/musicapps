package com.leopanigo.components.sprites 
{
	import com.leopanigo.music_concepts.Note;
	import com.leopanigo.music_concepts.NotesNameMapping;
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
		private var _shape:Shape;
		private var _length:Number;
		private var _height:Number;
		private var _fillColour:uint;
		//private var _isAccidental:Boolean;
		
		//accidentals
		private var _sharp:Shape; //if needed
		private var _flat:Shape; //if needed
		
		public function PseudoMusicSheetNote(note:Note, length:Number, height:Number, colour:uint, drawLine:Boolean = false) 
		{
			_note = note;
			_length = length;
			_height = height;
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
			redraw();
		}
		private function redraw():void
		{
			_shape = new Shape; // initializing the variable named rectangle
			if (NotesNameMapping.IS_SHARP[_note.name])
			{
				//_circle.graphics.lineStyle(1, 0xffffff, 0.9);
				_shape.graphics.beginFill(_fillColour, 0.7); 
				_shape.graphics.drawRect(-_length,-_height, 2*_length, 2*_height);
				_shape.graphics.endFill(); 

			}else if (NotesNameMapping.IS_FLAT[_note.name])
			{
				//_circle.graphics.lineStyle(1, 0xffffff, 0.9);
				_shape.graphics.beginFill(_fillColour, 0.7); 
				_shape.graphics.moveTo( -_length, _height);
				_shape.graphics.lineTo( _length, _height);
				_shape.graphics.lineTo( 0, -_height);
				_shape.graphics.lineTo( -_length, _height);
				//_circle.graphics.drawRect(-_r,-_r, 2*_r, 2*_r);
				_shape.graphics.endFill(); 

			}
			else{
				//_circle.graphics.lineStyle(1, 0xffffff, 0.9);
				_shape.graphics.beginFill(_fillColour, 0.7); 
				//_shape.graphics.drawCircle(0,0,_length);
				_shape.graphics.drawEllipse(-_length, -_height, 2*_length, 2*_height);
				_shape.graphics.endFill(); 
			}
			addChild(_shape); // adds the rectangle to the stage
			
			if (_drawLine)
			{
				_line =  new Shape;
				_line.graphics.lineStyle( 2, 0xf0f0f0, 0.9 );
				_line.graphics.moveTo( - _length -2, 0);
				_line.graphics.lineTo(_length + 2, 0);// 
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
		
		public function get length():Number 
		{
			return _length;
		}
		
		public function set length(value:Number):void 
		{
			_length = value;
			redraw();
		}
		
		//private function update():void
		
		
	}

}