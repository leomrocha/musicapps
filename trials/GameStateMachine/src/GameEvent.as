package 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	
	 //TODO rename to GameStateEvent!!!
	public class GameEvent extends Event 
	{
		public static const INSTRUMENT_SELECTION_SCREEN:String = "instrumentSelectionScreen";
		public static const CHANGE_GAME_STATE:String = "ChangeGameState";
		public static const SETTINGS_MAIN_SCREEN:String = "settingsScreen";
		public static const BACK_BUTTON_EVENT:String = "BackButtonPressed";
		
		private var m_eventName:String;
		private var m_nextState:String;
		
		public function GameEvent(eventName:String = null, nextState:String=null)
		{
			m_nextState = nextState;
			m_eventName = eventName;
			super(eventName, false, false);
		}
		
		public function get nextState():String 
		{
			return m_nextState;
		}
		
		public function get eventName():String 
		{
			return m_eventName;
		}
	}
	
}