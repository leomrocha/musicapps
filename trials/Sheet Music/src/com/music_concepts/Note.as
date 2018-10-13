package com.music_concepts 
{
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class Note 
	{
		private var _freq:Number;
		private var _name:String;
		private var _octave:uint;
		private var _midiNote:uint;
		private var _wholeNote:Boolean;
		
		public function Note( freq:Number, name:String, octave:uint, midi:uint) 
		{
			_freq = freq;
			_name = name;
			_octave = octave;
			_midiNote = midi;
			//TODO find out if it is whole or half
			if (_name.search("#") == -1 && _name.search("b") == -1 )
			{
				_wholeNote = true;
			}else
			{
				_wholeNote = false;
			}
			trace("note name, wholeNote: ", _name, _wholeNote );
		}
		
		public function get freq():Number 
		{
			return _freq;
		}
		
		public function set freq(value:Number):void 
		{
			_freq = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get octave():uint 
		{
			return _octave;
		}
		
		public function set octave(value:uint):void 
		{
			_octave = value;
		}
		
		public function get midiNote():uint 
		{
			return _midiNote;
		}
		
		public function set midiNote(value:uint):void 
		{
			_midiNote = value;
		}
		
		public function get wholeNote():Boolean 
		{
			return _wholeNote;
		}
		
		public function set wholeNote(value:Boolean):void 
		{
			_wholeNote = value;
		}
		
	}

}