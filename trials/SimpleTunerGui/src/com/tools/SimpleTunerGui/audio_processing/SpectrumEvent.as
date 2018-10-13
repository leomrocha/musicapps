package com.tools.SimpleTunerGui.audio_processing 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SpectrumEvent extends Event 
	{
		public static const SPECTRUM_UPDATED_EVENT:String = "SpectrumUpdatedEvent";
		
		private var _freq:uint;
		public function SpectrumEvent(freq:Number, type:String = SPECTRUM_UPDATED_EVENT) 
		{
			super(type, false, false);
		}
		
		public function get freq():uint 
		{
			return _freq;
		}

		
	}

}