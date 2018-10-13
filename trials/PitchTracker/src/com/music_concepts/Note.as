package com.music_concepts 
{
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class Note 
	{
		public static const NOTES_NAMES_SHARP_POS_MAP:Object = { "C":0, "C#":1, "D":2, "D#":3, "E":4,
																 "F":5, "F#":6, "G":7, "G#":8, "A":9,
																 "A#":10, "B":11}; 
		
		public static const NOTES_NAMES_FLAT_POS_MAP:Object = { "C":0, "Db":1, "D":2, "Eb":3, "E":4,
																"F":5, "Gb":6, "G":7, "Ab":8, "A":9,
																"Bb":10, "B":11}; 
																 
		public static const NOTES_NAMES_POS_MAP:Object = { "C":0, "C#":1, "Db":1, "D":2, "D#":3, "Eb":3, "E":4,
														   "F":5, "F#":6, "Gb":6, "G":7, "G#":8, "Ab":8, "A":9,
														   "A#":10, "Bb":10, "B":11 };
																 
		public static const NOTES_NAMES_SHARP_ARRAY:Vector.<String> = new <String>["C", "C#", "D", "D#", "E",
																 "F", "F#", "G", "G#", "A",
																 "A#", "B" ]; 
																 
		public static const NOTES_NAMES_FLAT_ARRAY:Vector.<String> = new <String>["C", "Db", "D", "Eb", "E",
																 "F", "Gb", "G", "Ab", "A",
																 "Bb", "B" ];
																 
		public static const NOTES_COLOURS_ARRAY:Vector.<uint> = new <uint>[0xCC0000, 0xaa2200, 0x884400, 0x666600, 0x448800,0x22aa00,0x00cc00, 0x00aa22, 0x008844, 0x006666, 0x004488,0x0022aa, 0x0000cc];
																 
		private var _freq:Number;
		private var _name:String;
		private var _octave:uint;
		private var _midiNote:uint;
		
		private var _errorCents:Number;
		private var _errorHz:Number;
		
		private var _time:Number;
		
		public function Note( freq:Number, name:String, octave:uint, midi:uint, errCents:Number=Number.MAX_VALUE, errorHz:Number=Number.MAX_VALUE, noteTime:Number = 0) 
		{
			_freq = freq;
			_name = name;
			_octave = octave;
			_midiNote = midi;
			
			
			
			_errorCents = errCents;
			_errorHz = errorHz;
			
			_time = noteTime;
			
		}
		public function get colour():uint
		{
			var c:uint = NOTES_COLOURS_ARRAY[NOTES_NAMES_POS_MAP[_name]];
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
		
	}

}