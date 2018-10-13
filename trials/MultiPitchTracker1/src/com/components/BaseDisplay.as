package com.components 
{
	import com.music_concepts.Note;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class BaseDisplay extends Sprite 
	{
		protected var _w:Number, _h:Number;
		//Limits in frequency, set by owner of the class
		protected var _MIN_FREQ:Number;
		protected var _MAX_FREQ:Number;
		
		protected const MAX_CENTS:Number = 50;
		
		//the currently shown notes are note mandatory sequential, some might happen in parallel
		protected var _currentNotesVect:Vector.<Note>;//notes being shown
		
		protected var _beginTime:Number;//older time to show on screen, seconds
		protected var _endTime:Number;//newer time to show on screen
		protected var _timeInterval:Number;
		protected var _intervalToX:Number;//proportionality factor
		
		public function BaseDisplay(w:Number , h:Number, timeInterval:Number) 
		{
			_w = w;
			_h = h;
			_timeInterval = timeInterval;
			
		}
		
		public function clear():void
		{
			_valsVect = new Vector.<Number>(_currentSamplesShown); 
			_coloursVect = new Vector.<uint>(_currentSamplesShown);
			metronomeDisplay.clear();
			update(null);
		}
		
		//notes is the vector of the notes to show
		//marks is the vector of metronome marks
		public function showVector( notes:Vector.<Note>, marks:Vector.<Boolean>=null):void
		{
			//TODO
		}
		
		//takes an update notes
		public function update(notes:Vector.<Note>):void
		{
			
			//check that are in freq range
		}
		
		protected function plot():void
		{
			
		}
		
		public function get MIN_FREQ():Number 
		{
			return _MIN_FREQ;
		}
		
		public function set MIN_FREQ(value:Number):void 
		{
			_MIN_FREQ = value;
		}
		
		public function get MAX_FREQ():Number 
		{
			return _MAX_FREQ;
		}
		
		public function set MAX_FREQ(value:Number):void 
		{
			_MAX_FREQ = value;
		}
		
		
	}

}