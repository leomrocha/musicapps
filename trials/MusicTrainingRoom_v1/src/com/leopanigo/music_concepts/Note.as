package com.leopanigo.music_concepts 
{
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class Note 
	{
		
		import com.leopanigo.music_concepts.NotesNameMapping;
		
		private var _freq:Number;
		private var _name:String;
		
		private var _nameFlat:String;
		private var _nameSharp:String;
		
		private var _octave:uint;
		private var _midiNote:uint;
		
		private var _errorCents:Number;
		private var _errorHz:Number;
		
		private var _time:Number;
		private var _duration:Number;
		
		public function Note( freq:Number, name:String, octave:uint, midi:uint, errCents:Number=Number.MAX_VALUE, errorHz:Number=Number.MAX_VALUE, noteTime:Number = 0, duration:Number = 0) 
		{
			_freq = freq;
			_name = name;
			_octave = octave;
			_midiNote = midi;
			
			_nameFlat =   NotesNameMapping.NOTES_NAMES_FLAT_ARRAY[NotesNameMapping.NOTES_NAMES_POS_MAP[_name]]
			_nameSharp = NotesNameMapping.NOTES_NAMES_SHARP_ARRAY[NotesNameMapping.NOTES_NAMES_POS_MAP[_name]]
			
			_errorCents = errCents;
			_errorHz = errorHz;
			
			_time = noteTime;
			_duration = duration;
			
		}
		
		public function get colour():uint
		{
			var c:uint = NotesNameMapping.NOTES_COLOURS_ARRAY[NotesNameMapping.NOTES_NAMES_POS_MAP[_name]];
			return c;
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
		
		public function get errorCents():Number 
		{
			return _errorCents;
		}
		
		public function set errorCents(value:Number):void 
		{
			_errorCents = value;
		}
		
		public function get errorHz():Number 
		{
			return _errorHz;
		}
		
		public function set errorHz(value:Number):void 
		{
			_errorHz = value;
		}
		
		public function get time():Number 
		{
			return _time;
		}
		
		public function set time(value:Number):void 
		{
			_time = value;
		}
		
		public function get nameFlat():String 
		{
			return _nameFlat;
		}
		
		public function get nameSharp():String 
		{
			return _nameSharp;
		}
		
	}

}