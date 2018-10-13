package com.leopanigo.components.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class InstrumentSelectedEvent extends Event 
	{
		//public static const INSTRUMENT_VOICE_SELECTED:String = "VoiceSelected";
		//public static const INSTRUMENT_GUITAR_SELECTED:String = "GuitarSelected";
		public static const INSTRUMENT_SELECTED_EVENT:String = "INSTRUMENT_SELECTED_EVENT";
		public static const INSTRUMENT_VOICE_SELECTED:String = "VOICE";
		public static const INSTRUMENT_GUITAR_SELECTED:String = "GUITAR";
		//public static const INSTRUMENT_VOICE_SELECTED:String = "";
		private var _name:String;
		
		public function InstrumentSelectedEvent(name:String, type:String = InstrumentSelectedEvent.INSTRUMENT_SELECTED_EVENT, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_name = name;
			super(type, bubbles, cancelable);
			
		}
		
		public function get name():String 
		{
			return _name;
		}
		
	}

}