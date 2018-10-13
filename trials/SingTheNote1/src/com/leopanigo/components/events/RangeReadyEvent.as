package com.leopanigo.components.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class RangeReadyEvent extends Event 
	{
		public static const RANGE_READY_EVENT:String = "RangeReadyEvent";
		private var _maxFreq:Number, _minFreq:Number;
		
		public function RangeReadyEvent(minFreq:Number, maxFreq:Number, type:String = RANGE_READY_EVENT, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_maxFreq = maxFreq;
			_minFreq = minFreq;
			
			super(type, bubbles, cancelable);
			
		}
		
		public function get maxFreq():Number 
		{
			return _maxFreq;
		}
		
		public function set maxFreq(value:Number):void 
		{
			_maxFreq = value;
		}
		
		public function get minFreq():Number 
		{
			return _minFreq;
		}
		
		public function set minFreq(value:Number):void 
		{
			_minFreq = value;
		}
		

	}

}