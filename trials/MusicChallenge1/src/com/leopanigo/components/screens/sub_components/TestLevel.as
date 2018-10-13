package com.leopanigo.components.screens.sub_components 
{
	import com.leopanigo.audio_processing.NoteMapper;
	import com.leopanigo.music_concepts.Note;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class TestLevel 
	{
		
		private var freqs:Array = [130.81, 138.59, 146.83, 155.56, 164.81, 174.61, 185.00, 196.00, 207.65, 
                220.00, 233.08, 246.94, 261.63, 277.18, 293.66, 311.13, 329.63, 349.23, 
                369.99, 392.00, 415.30, 440.00];
		
		private var notes:Vector.<Note>;
		private var noteMapper:NoteMapper;

		public function TestLevel() 
		{
			notes = new Vector.<Note>;
			noteMapper = new NoteMapper();
			for ( var i:uint = 0 ; i < freqs.length; i++)
			{
				var v:Number = freqs[i];
				noteMapper.updateFreq(v);
				var n:Note = noteMapper.getNote();
				n.initTime = i;
				n.endTime = i + 1;
				notes.push(n);
			}
		}
		
		public function getLevel():Vector.<Note>
		{
			return notes;
		}
		
	}

}