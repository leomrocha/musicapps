package  
{
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class LevelLoader 
	{
		
		public function LevelLoader() 
		{
			
		}
		
		public function loadLevel(instrumentName:String, levelName:String):LevelSprite
		{
			trace("Loading Level");
			var levelNotes:Vector.<NoteRect> = new Vector.<NoteRect>();
			var level:LevelSprite;
			//here load according to name
			if (instrumentName == ChallengeScreenFactory.INSTRUMENT_GUITAR)
			{
				var guitarLevelNotes:Vector.<GuitarNoteRect> = testHardcodedGuitarLevelNotes();
				//levelNotes = guitarLevelNotes as Vector.<NoteRect>;
				level = new GuitarTabLevelSprite(60, guitarLevelNotes, NoteSymbol.NEGRA);
				trace("level creqted", level);
			}
			else 
			{
				if (levelName != "practice")
					levelNotes = testHardcodedLevelNotes();
				level = new LevelSprite(60, levelNotes, NoteSymbol.NEGRA);
			}
			return level;
		}
		
		private function testHardcodedLevelNotes():Vector.<NoteRect>
		{
			trace("chromatic test level");
			//this gives a test chromatic scale
			var notes:Vector.<NoteRect> = new Vector.<NoteRect>();
			var i:uint = 0;
			var f:Array = new Array(130.81, 138.59, 146.83, 155.56, 164.81, 174.61, 185.00, 196.00, 207.65, 220.00, 233.08, 246.94);
			for (i = 0; i < 12; i++)
			{
				var t:uint = (Number(NoteSymbol.SEMI_FUSA) / Number(NoteSymbol.NEGRA)) * Number(i + 1) *2;
				var n:NoteRect = new NoteRect(f[i], t, NoteSymbol.NEGRA);
				notes.push(n);
			}
			return notes;
		}

		private function testHardcodedGuitarLevelNotes():Vector.<GuitarNoteRect>
		{
			trace("chromatic test level");
			//this gives a test chromatic scale
			var notes:Vector.<GuitarNoteRect> = new Vector.<GuitarNoteRect>();
			var i:uint = 0;
			var f:Array = new Array(82.41, 87.31, 92.50, 98.00, 103.83, 110.00, 116.54, 123.47, 130.81, 138.59, 146.83, 155.56);
			var noteMapper:NoteMapper = new NoteMapper();
			
			for (i = 0; i < 12; i++)
			{
				
				var t:uint = (Number(NoteSymbol.SEMI_FUSA) / Number(NoteSymbol.NEGRA)) * Number(i + 1) * 2;
				var c:uint;
				var freet:uint;
				var finger:uint;
				if (i < 5) c = 6;
				else if (i < 10) c = 5;
				else if (i < 15) c = 4;
				finger = freet = i % 5 ;
				var n:GuitarNoteRect = new GuitarNoteRect(f[i], t, NoteSymbol.NEGRA, c, freet, finger);
				noteMapper.updateFreq(f[i]);
				n.octave = noteMapper.octave;
				n.noteName = noteMapper.currNote;
				notes.push(n);
				trace("create new note: ", n);
			}
			return notes;
		}
	}

}