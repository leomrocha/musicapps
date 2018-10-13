package com.gui_elements 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class ScrollBarEvent extends Event 
	{
		public static const SCROLL_UPDATED:String = "SCROLL_UPDATED";
		
		private var _scrollPos:Number;
		
		
		public function ScrollBarEvent(scrollPos:Number, type:String = ScrollBarEvent.SCROLL_UPDATED, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			_scrollPos = scrollPos;
			
			
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ScrollBarEvent(_scrollPos, type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ScrollBarEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get scrollPos():Number 
		{
			return _scrollPos;
		}
		
		public function set scrollPos(value:Number):void 
		{
			_scrollPos = value;
		}
		
	}
	
}