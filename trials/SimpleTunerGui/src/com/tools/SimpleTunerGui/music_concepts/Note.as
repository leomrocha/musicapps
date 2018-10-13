package com.tools.SimpleTunerGui.music_concepts 
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
		
		public function Note( freq:Number, name:String, octave:uint, midi:uint) 
		{
			_freq = freq;
			_name = name;
			_octave = octave;
			_midiNote = midi;
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
		
	}

}