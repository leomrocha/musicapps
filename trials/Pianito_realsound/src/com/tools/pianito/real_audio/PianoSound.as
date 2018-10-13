package com.tools.pianito.real_audio 
{
	import com.tools.pianito.music_concepts.Note;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PianoSound 
	{
		//note information
		private var _note:Note;
		//actual sound
		private var _sound:Sound;
		
		private var initialized:Boolean;
		//loading
		private var loader:Loader;
		
		public function PianoSound(note:Note) 
		{
			initialized = false;
			init();
		}

		public function play():void
		{
			if (initialized) {
				//if(_sound.
				//if being played
				// stop playing
				//play
				_sound.play();
			}
		}

		private function init():void
		{
			
			//find the note name (corresponding to the piano DB
			var fname:String = "";

			_sound = new Sound(new URLRequest(fname));
			initialized = true;
		}

	}

}