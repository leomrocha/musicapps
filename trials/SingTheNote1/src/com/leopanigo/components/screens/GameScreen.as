package com.leopanigo.components.screens 
{
	import com.leopanigo.audio_processing.NoteMapper;
	import com.leopanigo.audio_processing.SpectrumAnalyzer;
	import com.leopanigo.audio_processing.SpectrumEvent;
	import com.leopanigo.components.displays.PseudoSheetMusicDisplay;
	import com.leopanigo.components.events.NotesMatchEvent;
	import com.leopanigo.music_concepts.Note;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class GameScreen extends Sprite 
	{
		private var _w:Number, _h:Number;
		
		//Limits in frequency, set by owner of the class
		private var _MIN_FREQ:Number = -1;
		private var _MAX_FREQ:Number = -1;
		private var _maxNote:Note;
		private var _minNote:Note;
		
		private var sheetDisplay:PseudoSheetMusicDisplay;
		private var spect:SpectrumAnalyzer;
		
		private var noteMapper:NoteMapper;
		
		//scoring
		private var score:Number;
		private var correctCount:uint;
		private var incorrectCount:uint;
		private var totalCount:uint;
		
		private var scoreTxt:TextField;
		private var correctTxt:TextField;
		private var totalTxt:TextField;
		///timers
		
		private var startTime:Number;
		
		private var timerTxt:TextField;
		
		public function GameScreen(w:uint, h:uint) 
		{
			_w = w;
			_h = h;
			
			sheetDisplay = new PseudoSheetMusicDisplay(_w * 0.8, _h);
			sheetDisplay.x = _w * 0.2;
			sheetDisplay.y = 0; // _h * 0.2;
			addChild(sheetDisplay);

			sheetDisplay.addEventListener(NotesMatchEvent.NOTES_MATCH_EVENT, onNotesMatch);
			
			
			//
				scoreTxt = new TextField();
				scoreTxt.x = _w * 0.05;
				scoreTxt.y = 20;
				var format1:TextFormat = new TextFormat();
				format1.size = 15;
				scoreTxt.defaultTextFormat = format1;
				scoreTxt.textColor = 0xFFFF44;
				scoreTxt.text = "Score";
				addChild(scoreTxt);
				
				correctTxt = new TextField();
				correctTxt.x = _w * 0.05;
				correctTxt.y = 40;
				var format2:TextFormat = new TextFormat();
				format2.size = 15;
				correctTxt.defaultTextFormat = format2;
				correctTxt.textColor = 0x11FF44;
				correctTxt.text = "0";
				addChild(correctTxt);

				totalTxt = new TextField();
				totalTxt.x = _w * 0.05;
				totalTxt.y = 60;
				var format3:TextFormat = new TextFormat();
				format3.size = 15;
				totalTxt.defaultTextFormat = format3;
				totalTxt.textColor = 0xFF1144;
				totalTxt.text = "0";
				addChild(totalTxt);
				
				timerTxt = new TextField();
				timerTxt.x = _w * 0.05;
				timerTxt.y = 80;
				var format:TextFormat = new TextFormat();
				format.size = 10;
				timerTxt.defaultTextFormat = format;
				timerTxt.textColor = 0xFF1144;
				timerTxt.text = "0";
				addChild(timerTxt);
			//
			
			noteMapper = new NoteMapper();
			
			spect = new SpectrumAnalyzer();
			spect.addEventListener(SpectrumEvent.SPECTRUM_UPDATED_EVENT, update);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		
		private function onEnterFrame(e:Event):void
		{
			var elapsed = getTimer();
			timerTxt.text = Math.floor(elapsed/1000)+"."+(elapsed%1000);
		}
		
		public function play():void
		{
			
			nextLevel();
			spect.start();
			
		}
		
		public function stop():void
		{
			spect.stop();
		}
		
		private function onNotesMatch(e:NotesMatchEvent):void
		{
			//update score
			correctCount++;
			correctTxt.text = correctCount.toString();
			//if game serie finished, show stats screen
			nextLevel();
		}
		
		private function nextLevel(e:Event = null):void
		{
			//Generate a new note in the singable range by the player
			var range:uint = _maxNote.midiNote - _minNote.midiNote;
			var midiID:uint =  Math.floor(Math.random() * (1+range)) + _minNote.midiNote;
			noteMapper.updateMidiNote(midiID);
			var n:Note = noteMapper.getNote();
			sheetDisplay.setLevel(n);
			
		}
		
		private function update(e:SpectrumEvent = null):void
		{
			if (e.freq > _MIN_FREQ && e.freq < _MAX_FREQ)
			{
				totalCount++;
				totalTxt.text = totalCount.toString();
			}
			noteMapper.updateFreq(e.freq);
			sheetDisplay.update(noteMapper.getNote());
		}
			public function get MIN_FREQ():Number 
		{
			return _MIN_FREQ;
		}
		
		
		public function set MIN_FREQ(value:Number):void 
		{
			_MIN_FREQ = value;
			sheetDisplay.MIN_FREQ = _MIN_FREQ;
			noteMapper.updateFreq(_MIN_FREQ);
			_minNote = noteMapper.getNote();
			
			
		}
		
		public function get MAX_FREQ():Number 
		{
			return _MAX_FREQ;
		}
		
		public function set MAX_FREQ(value:Number):void 
		{
			_MAX_FREQ = value;
			sheetDisplay.MAX_FREQ = _MAX_FREQ;
			noteMapper.updateFreq(_MAX_FREQ);
			_maxNote =  noteMapper.getNote();
		}
	}

}