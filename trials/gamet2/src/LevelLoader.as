package 
{
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class LevelLoader // may extend something for networking  to allow loading levels from a server on the internet
	{
		
		//WARNING TEST THINGS ONLY
		
            private const NOTES:Vector.<String> = new <String>[ 
                "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", 
                "A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", 
                "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B", "C", "C#/Db", "D", 
                "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B", 
                "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", 
                "A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", 
                "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B", "C", "C#/Db", "D", 
                "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B", 
                "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", 
                "A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", 
                "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B", "C", "C#/Db", "D", 
                "D#/Eb"
                ];

            private const FREQS:Vector.<Number> = new <Number>[
                16.35, 17.32, 18.35, 19.45, 20.60, 21.83, 23.12, 24.50, 25.96, 
                27.50, 29.14, 30.87, 32.70, 34.65, 36.71, 38.89, 41.20, 43.65, 
                46.25, 49.00, 51.91, 55.00, 58.27, 61.74, 65.41, 69.30, 73.42, 
                77.78, 82.41, 87.31, 92.50, 98.00, 103.83, 110.00, 116.54, 123.47, 
                130.81, 138.59, 146.83, 155.56, 164.81, 174.61, 185.00, 196.00, 207.65, 
                220.00, 233.08, 246.94, 261.63, 277.18, 293.66, 311.13, 329.63, 349.23, 
                369.99, 392.00, 415.30, 440.00, 466.16, 493.88, 523.25, 554.37, 587.33, 
                622.25, 659.26, 698.46, 739.99, 783.99, 830.61, 880.00, 932.33, 987.77, 
                1046.50, 1108.73, 1174.66, 1244.51, 1318.51, 1396.91, 1479.98, 1567.98, 1661.22, 
                1760.00, 1864.66, 1975.53, 2093.00, 2217.46, 2349.32, 2489.02, 2637.02, 2793.83, 
                2959.96, 3135.96, 3322.44, 3520.00, 3729.31, 3951.07, 4186.01, 4434.92, 4698.64, 
                4978.03
                ];
            private const LEN_NOTES:uint = 100;
		//END WARNING
		
		public function LevelLoader()
		{
			
		}
		
		public function loadLevel():Vector.<Note>//WARNING, THIS FUNCTION IS ONLY AS A TEST!!!
		{
			trace("Loading Level");
			var notes:Vector.<Note> = new Vector.<Note>;
			//TODO create level
			var t:Number = 500;
			var i:uint;
			var dur:Number = 400;
			for (i = 0; i < LEN_NOTES-28; i++)
			{
				trace(i, FREQS[i], t, dur );
				var note:Note = createNote(FREQS[i], t, dur);
				t += 1500;// + Math.round(( 0.5 - Math.random() ) * 100);
				//dur = 700;// + Math.round(( 0.5 - Math.random() ) * 100);
				notes.push(note);
			}
			return notes;
			
		}
		

            public function createNote( freq:Number, beginTime:Number, duration:Number):Note
            {
				var note:Note;
                var i:uint;
                var oc:uint = 10;
                //look for the closest frequency
                for(i=0; i< LEN_NOTES-28; i++) // I don't really care for 16 hz, and so avoid problems
                {
                    if(Math.abs(FREQS[i]-freq) < 0.00001)
                    {
						note = new Note(freq, beginTime, duration);
						note.name = NOTES[i];
						note.octave = LEN_NOTES / i;
                        break; // return note;
                    }

                }
				return note;
            }
		
	}
	
}