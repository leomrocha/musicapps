package com.tools.pianito.gui_elements 
{
	import com.tools.pianito.audio_processing.NoteMapper;
	import com.tools.pianito.audio_processing.ToneSynthesis;
	import com.tools.pianito.music_concepts.Note;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class OctaveKeyboard extends Sprite
	{
		protected var _w:uint;
		protected var _h:uint;
		protected var _numberOctaves:uint;
		protected var _numberOfKeys:uint;
		protected var _numberOfWhiteKeys:uint;
		protected var _startOctaveNumber:uint;
		protected var _whiteKeyWidth:Number;
		protected var _whiteKeyHeight:Number;
		protected var _blackKeyWidth:Number;
		protected var _blackKeyHeight:Number;
		
		protected var _keyList:Vector.<PianoKey>;
		
		public function OctaveKeyboard(numberOctaves:uint=1, startOctaveNumber:uint=3, w:uint=1024, h:uint=200) 
		{
			_numberOctaves = numberOctaves;
			_startOctaveNumber = startOctaveNumber;
			_w = w;
			_h = h;
			_whiteKeyHeight = h;
			_numberOfKeys = ( (numberOctaves * 12 ) + 1);
			_numberOfWhiteKeys = ( (numberOctaves * 7 ) + 1);
			_whiteKeyWidth = w / _numberOfWhiteKeys; //only white keyx are taken in account for
			_blackKeyHeight = _whiteKeyHeight * 0.67;
			_blackKeyWidth = _whiteKeyWidth * 0.67;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}		
		
		protected function init(e:Event = null):void
		{

			removeEventListener(Event.ADDED_TO_STAGE, init);
			//object properties
			_keyList = new Vector.<PianoKey>;
			//temporal stuff
			var noteMapper:NoteMapper = new NoteMapper();
			var i:uint = 0;
			var whiteKeyList:Vector.<PianoKey> = new Vector.<PianoKey>;
			var blackKeyList:Vector.<PianoKey> = new Vector.<PianoKey>;
			//keys positioning
			var xpos:Number = 0;
			var ypos:Number = 0;
			var step:Number = _whiteKeyWidth; // TODO make some minimum (1 pixel maybe) space between keys ...
			//find first note!!
			//WARNING, this code is to dependent on NoteMapper implementation!!! WARNING!!!!!
			var startPos:uint = _startOctaveNumber * 12;
			//END WARNING ... But SERIOUSLY .. take the warning seriously!!
			//creating notes (and their correspondent keys)
			var key:PianoKey;
			for(i = 0; i < _numberOfKeys; i++)
			{
				// create note
				var noteIndex:uint = i + startPos;
				noteMapper.updateFreq(NoteMapper.NOTES_FREQUENCIES[noteIndex]);
				var note:Note = noteMapper.getNote();
				// create key
				if(note.wholeNote) //is white key
				{
						if (i > 0) //warning, only for the first case, correctly position the key
						{
							xpos += step;
						}
						key = new PianoKey(note, _whiteKeyWidth, _whiteKeyHeight);
						key.x = xpos;
						key.y = ypos;
						_keyList.push(key);
						whiteKeyList.push(key);
				}
				else //is a black key
				{
						key = new PianoKey(note, _blackKeyWidth, _blackKeyHeight);
						key.x = xpos + (step*2.0/3.0);
						key.y = ypos;
						_keyList.push(key);
						blackKeyList.push(key);
				}
			}
			//add to screen
			for each(key in whiteKeyList)
			{
				addChild(key);
			}
			for each(key in blackKeyList)
			{
				addChild(key);
			}

			
			this.width  = _w;
			this.height = _h;
			this.scaleX = 1;
			this.scaleY = 1;
			
		}
		
		public function playNote(note:Note):void
		{
			var toneSynthesis:ToneSynthesis = new ToneSynthesis(note.freq);
			toneSynthesis.play();
		}
		
	}

}