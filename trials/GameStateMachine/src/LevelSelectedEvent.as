package  
{
	import flash.events.Event;

	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class LevelSelectedEvent extends Event 
	{
		public static const LEVEL_SELECTED_EVENT:String = "levelSelectedEvent";
		private var _levelName:String;
		private var _eventName:String;
		private var _instrument:String;
		
		
		public function LevelSelectedEvent(eventName:String, levelName:String, instrument:String) 
		{
			_levelName = levelName;
			_eventName = eventName;
			_instrument = instrument;
			super(eventName, false, false);
		}
		
		public function get levelName():String 
		{
			return _levelName;
		}
		
		public function get eventName():String 
		{
			return _eventName;
		}
		
		public function get instrument():String 
		{
			return _instrument;
		}
		
	}

}