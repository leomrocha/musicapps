package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class InstrumentSelectedEvent extends Event 
	{
		public static const INSTRUMENT_SELECTED_EVENT:String = "instrumentSelectedEvent";
		private var _instrumentName:String;
		private var _eventName:String;
		
		public function InstrumentSelectedEvent(eventName:String, instrument:String) 
		{
			_eventName = eventName;
			_instrumentName = instrument;
			super(eventName, false, false);
		}
		
		public function get instrumentName():String 
		{
			return _instrumentName;
		}
		
		public function get eventName():String 
		{
			return _eventName;
		}
		
	}

}