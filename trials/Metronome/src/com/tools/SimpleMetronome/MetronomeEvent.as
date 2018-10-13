package com.tools.SimpleMetronome 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MetronomeEvent extends Event 
	{
		public static const METRONOME_TICK:String = "MetronomeTick";
		public static const METRONOME_START:String = "MetronomeStart";
		public static const METRONOME_STOP:String = "MetronomeStop";
		
		private var _tickInCompass:uint;
		private var _tickCount:uint;
		public function MetronomeEvent(tickCount:uint = 0, tickInCompass:uint = 0, type:String=METRONOME_TICK) 
		{
			_tickCount = tickCount;
			_tickInCompass = tickInCompass;
			super(type, false, false);
		}
		
		public function get tickInCompass():uint 
		{
			return _tickInCompass;
		}
		
		public function set tickInCompass(value:uint):void 
		{
			_tickInCompass = value;
		}
		
		public function get tickCount():uint 
		{
			return _tickCount;
		}
		
		public function set tickCount(value:uint):void 
		{
			_tickCount = value;
		}
		
	}

}