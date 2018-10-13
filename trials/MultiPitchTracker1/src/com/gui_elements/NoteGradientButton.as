package com.gui_elements
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.music_concepts.Note;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class  NoteGradientButton extends GradientButton
	{
		//colors
		protected var _originalColor1:uint ;
		protected var _originalColor2:uint ;
		protected var _redColor1:uint  = 0xff0000;
		protected var _redColor2:uint = 0xAf0000;
		protected var _greenColor1:uint = 0x00ff00;
		protected var _greenColor2:uint = 0x00Af00;
		protected var _yellowColor1:uint = 0x555500;
		protected var _yellowColor2:uint = 0x050500;
		
		protected var _note:Note;
		//private var _noteMapper:NoteMapper;
		protected var TOLERANCE_CENTS:Number = 5.0;
				
		public function NoteGradientButton(note:Note, w:uint=40, h:uint=30, r:uint=20, color1:uint=0x04618d, color2:uint=0x379EE0)
		{
			_note = note;
			super(_note.name + _note.octave.toString(), w, h, r, color1, color2 );
		}
		
		public function tweenToRed():void
		{
			//TweenMax.to(colors, 1, { hexColors: { left:_redColor1, right:_redColor2 }, onUpdate:drawGradient } );
			colors["left"] = _redColor1;
			colors["right"] = _redColor2;
			drawGradient();
		}
		
		public function tweenToGreen():void
		{
			//TweenMax.to(colors, 1, { hexColors: { left:_greenColor1, right:_greenColor2 }, onUpdate:drawGradient } );
			colors["left"] = _greenColor1;
			colors["right"] = _greenColor2;
			drawGradient();
		}
		
		public function tweenToYellow():void
		{
			//TweenMax.to(colors, 1, {hexColors:{left:_yellowColor1, right:_yellowColor2}, onUpdate:drawGradient});
			colors["left"] = _yellowColor1;
			colors["right"] = _yellowColor2;
			drawGradient();
		}
		
		public function tweenToOriginal():void
		{
			//TweenMax.to(colors, 1, { hexColors: { left:_originalColor1, right:_originalColor2 }, onUpdate:drawGradient } );
			colors["left"] = _originalColor1;
			colors["right"] = _originalColor2;
			drawGradient();
			
		}
		
		public function update(note:Note, errorCents:Number):void
		{
			//trace("updating note", _note.name , note.name , _note.octave , note.octave, _txt, errorCents );
			//_noteMapper.updateFreq(freq);
			if (_note.name == note.name && _note.octave == note.octave )
			{
				tweenToRed();
				if ( Math.abs(errorCents) < TOLERANCE_CENTS)
				{
					tweenToGreen();
				}
			}
			//else
			//{
				//tweenToOriginal();
			//}
		}
		
		public function get note():Note 
		{
			return _note;
		}
		
		public function set note(value:Note):void 
		{
			//trace("setting note: ", value.freq, value.name, value.octave, value.midiNote);
			_note = value;
			_txt = _note.name + _note.octave.toString();
			_txtObject.text = _txt;
			//setProperties();
			drawGradient();
		}
	}
	
}