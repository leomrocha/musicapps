package com.leopanigo.components.metronome
{
	import adobe.utils.CustomActions;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	public class SimpleMetronome extends EventDispatcher
	{
		//Definitions:
		//tempo
		
		private var _bpm:Number;
		private var _tickWait:Number = 60.0 * 1000.0 /40.0;
		private var ticker:Timer;
		private var updateTimer:Timer;
		//counters
		private var tickCount:Number = 0;
		private var compassCount:Number = 0;
		private var tickInCompassCount:Number = 0;
		
		private var _beatsPerCompass:uint;
		//sounds (embedded)
		private var tickSnd:Sound; //handler for the tickling sound
		// Forte 
		[Embed(source="../../../../assets/snd/metronome2.mp3")] public var forteTick:Class;
		private var tickForte:Sound;
		// Medio
		[Embed(source="../../../../assets/snd/metronome2.mp3")] public var mezzoTick:Class;
		// Debil
		private var tickMezzo:Sound;
		private var _mezzoTransform:SoundTransform;
		
		private var _playSound:Boolean;
		//[Embed(source="../../assets/snd/metronome2.mp3")] public var pianoTick:Class;
		
		public function SimpleMetronome( bpm:uint = 60, beatsPerCompass:uint = 4, playSound:Boolean = true)
		{
			_bpm = bpm;
			_beatsPerCompass = beatsPerCompass;
			_playSound = playSound;
			//init sounds
			tickForte = new forteTick() as Sound;
			tickMezzo = new mezzoTick() as Sound;
			//init timers
			ticker = new Timer(_tickWait);
			//volume of mezzo sound
			_mezzoTransform = new SoundTransform(0.5);
			//init listeners
			ticker.addEventListener(TimerEvent.TIMER, tick);
		}
		
		public function start():void
		{
			//reset counters
			tickCount = 0;
			compassCount = 0;
			tickInCompassCount = 0;
			//start timers
			ticker.delay = _tickWait;
			ticker.start();
		}
		
		public function stop():void
		{
			//updateTimer.stop();
			ticker.stop();
			//reset pendulum
		}
		
		private function tick(e:TimerEvent):void
		{
			var tickSnd:Sound;
			//update counters
			tickCount++;
			if (_playSound)
			{	
				if (tickInCompassCount == 0 ) //<= 1)
				{
					tickForte.play();
				}else {
					
					tickMezzo.play(0, 0, _mezzoTransform);	
				}
			}
			tickInCompassCount++;
			if (tickInCompassCount >= _beatsPerCompass)
			{
				tickInCompassCount = 0;
				compassCount++;
			}
			//else 
			//{
				//tickInCompassCount++;	
			//}
			//emmit a signal with the count and all the details ... this is for the GUI
			dispatchEvent( new MetronomeEvent(tickCount, tickInCompassCount));
			
		}
		
		public function playSound(v:Boolean):void
		{
			_playSound = v;
		}
		
		public function incrementBPM():void
		{
			//stop playing (if it is playing a sound)
			ticker.stop();
			var newbpm:uint = _bpm + 1;
			this.bpm = newbpm;
		}
		
		public function decrementBPM():void
		{
			//stop playing (if it is playing a sound)
			ticker.stop();
			var newbpm:uint = _bpm - 1;
			this.bpm = newbpm;
		}
		
		public function get bpm():Number
		{
			return _bpm;
		}
		
		public function set bpm(value:Number):void
		{
			//maximum value = 208, minimum value = 40
			if(value>0 && value<250)
			{
				trace("setting bpm to: ", value);
				//this.stopTicking();
				_bpm = value;
				_tickWait = 60000.0 /_bpm; //60 seconds by minute * 1000 miliseconds by second
				ticker.delay = _tickWait;
			}
		}
		
		public function get beatsPerCompass():uint 
		{
			return _beatsPerCompass;
		}
		
		public function set beatsPerCompass(value:uint):void 
		{
			_beatsPerCompass = value;
		}

		 
	}
}