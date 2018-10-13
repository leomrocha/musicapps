package com.metronome
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;
	
	public class Metronome extends Sprite
	{
		//Definitions:
		// static var _notes_values:Array = {redonda: 1, blanca:2, negra:4, corchea:8, semicorchea:16, fusa:32, semifusa:64};
		private static var _notesValues:Array = [1,2,4,8,16,32,64];
		//tempo
		private var _bpm:Number = 40;
		private var _tickWait:Number = 60.0 * 1000 /40.0;
		private var _timeSignature:Number = 4; //goes from 1 to 4, meaning 1/4,  2/4 , 3/4 and 4/4 respectively
		private var _noteValue:Number = 4; // redonda = 1, blanca = 2, negra = 4, corchea = 8, semicorchea = 16, fusa, semifusa, // don't know the terms in english 
		private var ticker:Timer;
		private var updateTimer:Timer;
		//counters
		private var tickCount:Number = 0;
		private var compassCount:Number = 0;
		private var tickInCompassCount:Number = 0;
		
		//sounds (embedded)
		private var tickSnd:Sound; //handler for the tickling sound
		// Forte 
		[Embed(source="../assets/snd/metronome2.mp3")] public var forteTick:Class;
		private var tickForte:Sound;
		// Medio
		//[Embed(source="../assets/snd/metronome2.mp3")] public var mezzoTick:Class;
		// Debil
		//[Embed(source="../assets/snd/metronome2.mp3")] public var pianoTick:Class;
		
		//Pendulum
		//characteristics for the metronome inverted  pendulum (after you can implement whatever for the graphics)
		
		public function Metronome()
		{
			super();
			//init sounds
			tickForte = new forteTick() as Sound;
			//init timers
			ticker = new Timer(_tickWait);
			//updateTimer = new Timer(30); //30 fps, for graphics to be OK
			//init listeners
			ticker.addEventListener(TimerEvent.TIMER, tick);
			//updateTimer.addEventListener(TimerEvent.TIMER, updatePendulum);
		}
		
		public function startTicking():void
		{
			//reset counters
			tickCount = 0;
			compassCount = 0;
			tickInCompassCount = 0;
			//start timers
			ticker.delay = _tickWait;
			ticker.start();
			//updateTimer.start();
			//reset pendulum characteristics
		}
		
		public function stopTicking():void
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
//			compassCount++;
//			tickInCompassCount++;
			//check counters agains the metronome configuration: and find the correct sound to play
			//tickSnd = forteTick as Sound;
			//now play the correct sound .. for the moment is just one untill I find a nice set of sounds
			//tickSnd.play();
			tickForte.play();
		}
		
		private function updatePendulum(e:TimeEvent):void
		{
			//update angle for the pendulum
		}
//		public function get noteValue():Number
//		{
//			return _noteValue;
//		}

		public function set noteValue(value:Number):void
		{
			//check is a correct value
			if( ! (_notesValues.indexOf(value) <0) ){
				_noteValue = value;
				if ( _timeSignature > _noteValue){
					this.timeSignature = _noteValue;	
				}
			}
		}

//		public function get timeSignature():Number
//		{
//			return _timeSignature;
//		}

		public function set timeSignature(value:Number):void
		{
			if (value>=1 && value <= _noteValue) //check is a valud time signature
			{
				_timeSignature = value;
			}
		}

		
		//		public function get bpm(Number):Number
		//		{
		//			return _bpm;
		//		}
		
		public function set bpm(value:Number):void
		{
			//maximum value = 208, minimum value = 40
			if(value>=40 && value<=208)
			{
				//this.stopTicking();
				_bpm = value;
				_tickWait = 60000.0 /_bpm; //60 seconds by minute * 1000 miliseconds by second
				ticker.delay = _tickWait;
			}
		}

		 
	}
}