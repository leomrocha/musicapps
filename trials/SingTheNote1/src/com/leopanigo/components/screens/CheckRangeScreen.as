
package com.leopanigo.components.screens 
{
	import com.leopanigo.audio_processing.NoteMapper;
	import com.leopanigo.audio_processing.SpectrumAnalyzer;
	import com.leopanigo.audio_processing.SpectrumEvent;
	import com.leopanigo.components.buttons.GradientButton;
	import com.leopanigo.components.displays.PseudoSheetMusicDisplay;
	import com.leopanigo.components.events.NotesMatchEvent;
	import com.leopanigo.components.events.RangeReadyEvent;
	import com.leopanigo.music_concepts.Note;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class CheckRangeScreen extends Sprite 
	{
		private var _w:Number, _h:Number;
		
		//Limits in frequency, set by owner of the class
		private var _MIN_FREQ:Number = Number.MAX_VALUE;
		private var _MAX_FREQ:Number = Number.MIN_VALUE;
		
		private var sheetDisplay:PseudoSheetMusicDisplay;
		private var spect:SpectrumAnalyzer;
		
		private var noteMapper:NoteMapper;
		
		private var okButton:GradientButton;
		private var resetButton:GradientButton;
		
		
		private var instructionsTxt:TextField;
		
		private var prevNote:Note;
		private var minConsecutives:uint = 10;
		private var arrCountConsecutives:Array;
		
		public function CheckRangeScreen(w:uint, h:uint) 
		{
			_w = w;
			_h = h;
			
			sheetDisplay = new PseudoSheetMusicDisplay(_w * 0.8, _h);
			sheetDisplay.x = _w * 0.2;
			sheetDisplay.y = 0; // _h * 0.2;
			addChild(sheetDisplay);

				instructionsTxt = new TextField();
				instructionsTxt.wordWrap = true;
				instructionsTxt.width = _w * 0.8;
				instructionsTxt.scaleX = 1;
				instructionsTxt.x = _w * 0.1;
				instructionsTxt.y = _h * 0.8;
				var format:TextFormat = new TextFormat();
				format.size = 12;
				instructionsTxt.defaultTextFormat = format;
				instructionsTxt.textColor = 0xFFFFFF;
				instructionsTxt.text = "Sing and maintain the highest and lowest pitch you can until there are notes in the right. Then press DONE";
				addChild(instructionsTxt);
			
			okButton = new GradientButton("DONE", 20, 80, 5, 0x303030, 0x5f5f5f);
			okButton.x = 10;
			okButton.y = 10;
			addChild(okButton);
			okButton.addEventListener(MouseEvent.CLICK, onOK);
			
			resetButton = new GradientButton("RESET", 20, 80, 5, 0x303030, 0x5f5f5f);
			resetButton.x = 10;
			resetButton.y = 100;
			addChild(resetButton);
			resetButton.addEventListener(MouseEvent.CLICK, onReset);
			
			noteMapper = new NoteMapper();
			
			arrCountConsecutives = new Array;
			for (var i:uint = 0; i < 150; i++)
			{
				arrCountConsecutives[i] = 0;
			}
			
			spect = new SpectrumAnalyzer();
			//set a range to be able to show something
			sheetDisplay.MIN_FREQ = 65;
			sheetDisplay.MAX_FREQ = 1300;
			
			spect.addEventListener(SpectrumEvent.SPECTRUM_UPDATED_EVENT, update);
		}
		
		public function play():void
		{
			
			spect.start();
			
		}
		
		private function onReset(e:MouseEvent):void
		{
			_MIN_FREQ = Number.MAX_VALUE;
			_MAX_FREQ = Number.MIN_VALUE;
			prevNote = null;
			sheetDisplay.clear();
		}
		
		private function onOK(e:MouseEvent):void
		{
			spect.stop();
			dispatchEvent(new  RangeReadyEvent(_MIN_FREQ, _MAX_FREQ));
		}
		
		
		private function update(e:SpectrumEvent = null):void
		{
			noteMapper.updateFreq(e.freq);
			var n:Note = noteMapper.getNote();
			if (e.freq > 65 && e.freq < 1300)
			{
			
				//keep a trace for later calculating minimum and maximum
				if (prevNote)
				{
					if (prevNote.midiNote == n.midiNote)
					{
						arrCountConsecutives[n.midiNote]++;
					}else
					{
						arrCountConsecutives[n.midiNote] = 1;
					}
				}
				if (arrCountConsecutives[n.midiNote] > minConsecutives)
				{
					if (n.freq > _MAX_FREQ)
					{
						_MAX_FREQ = n.freq;
						trace("_MAX_FREQ = ", _MAX_FREQ);
					}
					else if (n.freq < _MIN_FREQ)
					{
						_MIN_FREQ = n.freq;
						trace("_min freq", _MIN_FREQ);
					}
					sheetDisplay.drawNote(n);
				}
				sheetDisplay.update(n);
			}
			prevNote = n;
		}
		
	}

}