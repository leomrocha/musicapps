package  
{
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class GuitarNoteRect extends NoteRect 
	{
		private var _cord:uint; //cord to play
		private var _freet:uint; //freet to press
		private var _finger:uint; //which finger should be used to press the freet: 1 index; 2 middle; 3 ring; 4 pinky
		
		public function GuitarNoteRect(freq:Number, tick0:Number, note_id:uint = NoteSymbol.NEGRA, 
													cord:uint = 0, freet:uint = 0, finger:uint = 1, 
													instrument:String=ChallengeScreenFactory.INSTRUMENT_GUITAR) 
		{
			_cord = cord;
			_freet = freet;
			_finger = finger;
			var ttext:String = _freet.toString() + " | " + _finger.toString();
			super(freq, tick0, note_id, instrument, true, ttext);
			//TODO check that the given cord and freet matches the actual frequency, if not, throw an error
		}
		
		public function get cord():uint 
		{
			return _cord;
		}
		
	}

}