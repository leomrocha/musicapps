package com.audio_processing 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SpectrumEvent extends Event 
	{
		public static const SPECTRUM_UPDATED_EVENT:String = "SpectrumUpdatedEvent";
		
		private var _freq:Number;
		private var _multipitch:Vector.<Number>;
		private var _time:Number;
		private var _volume:Number;
		private var _fft:Vector.<Number>;
		private var _hps:Vector.<Number>;
		private var _chroma:Vector.<Number>;
		
		public function SpectrumEvent(vol:Number, freq:Number, time:Number, multipitch:Vector.<Number> = null, chromaVect:Vector.<Number> = null, type:String = SPECTRUM_UPDATED_EVENT) 
		{
			_volume = vol;
			_freq = freq;
			_time = time;
			_multipitch = multipitch;
			_chroma = chromaVect;
			super(type, false, false);
		}
		
		public function get freq():Number 
		{
			return _freq;
		}
		
		public function get volume():Number 
		{
			return _volume;
		}
		
		public function get fft():Vector.<Number> 
		{
			return _fft;
		}
		

		public function get hps():Vector.<Number> 
		{
			return _hps;
		}
		
		public function get chroma():Vector.<Number> 
		{
			return _chroma;
		}
		
		public function get multipitch():Vector.<Number> 
		{
			return _multipitch;
		}

		
	}

}