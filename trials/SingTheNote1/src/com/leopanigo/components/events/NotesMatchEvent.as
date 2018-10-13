package com.leopanigo.components.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class NotesMatchEvent extends Event 
	{
		public static const NOTES_MATCH_EVENT:String = "NotesMatchEvent";
		
		public function NotesMatchEvent(type:String = NotesMatchEvent.NOTES_MATCH_EVENT, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}