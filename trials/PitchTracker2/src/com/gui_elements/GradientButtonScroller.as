package com.gui_elements 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.audio_processing.NoteMapper;
	import com.music_concepts.Note;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class GradientButtonScroller extends Sprite 
	{
		private var buttonsVector:Vector.<NoteSliderButton>;
		private var tunningsDict:Dictionary; // mapings between text (a name of the tunning) and a tunning
		
		public function GradientButtonScroller() 
		{
			buttonsVector = new Vector.<NoteSliderButton>();
			tunningsDict = new Dictionary();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			var nm:NoteMapper = new NoteMapper();
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var step:Number = stage.stageWidth / 5.0;
			var xpos:uint = 0;//  - step / 2.0;
			
			for ( var i:uint = 0; i < 5; i++ )
			{
				nm.updateFreq(NoteMapper.NOTES_FREQUENCIES[i+20]);
				var b:NoteSliderButton = new NoteSliderButton(nm.getNote(), step-5, 28);
				buttonsVector[i] = b; // .push(b);
				addChild(b);
				b.x = xpos;
				b.y = 2;
				xpos += step ;
			}
			
		}	
		public function update(note:Note, errorCents:Number):void
		{
			var step:Number = stage.stageWidth / 5.0;

			//get position
			note.midiNote;
			if (note.midiNote > 14)
			for (var i:uint = note.midiNote -2; i <= note.midiNote + 2; i++ )
			{
				
				var j:uint = i -12;
				//trace("i,j = ", i, j);
				//trace(" new note: ", NoteMapper.NOTES_FREQUENCIES[j], NoteMapper.NOTES_NAMES[j], j / 12 , i);
				var newNote:Note = new Note(NoteMapper.NOTES_FREQUENCIES[j], NoteMapper.NOTES_NAMES[j], j / 12 , i ) ;
				//trace("buttonVEctor lenght ", buttonsVector.length)
				buttonsVector[i+2 - note.midiNote].note = newNote;
				buttonsVector[i+2 - note.midiNote].update(note, errorCents);

			}
		}
	}

}