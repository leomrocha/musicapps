package com.tools.pianito.audio_processing
{
	import com.tools.pianito.music_concepts.Note;
	
	import __AS3__.vec.Vector;
	public class NoteMapper
	{
		public static const NOTES_NAMES_COMPLETE:Vector.<String> = new <String>[ 
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
		public static const NOTES_NAMES_SHARP:Vector.<String> = new <String>[ 
                "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", 
                "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", 
                "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", 
                "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", 
                "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", 
                "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", 
                "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", 
                "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", 
                "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", 
                "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", 
                "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", 
                "D#"
                ];

			public static const NOTES_NAMES_FLAT:Vector.<String> = new <String>[ 
                "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", 
                "A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", 
                "Gb", "G", "Ab", "A", "Bb", "B", "C", "Db", "D", 
                "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B", 
                "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", 
                "A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", 
                "Gb", "G", "Ab", "A", "Bb", "B", "C", "Db", "D", 
                "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B", 
                "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", 
                "A", "Bb", "B", "C", "C#/Db", "D", "Eb", "E", "F", 
                "Gb", "G", "Ab", "A", "Bb", "B", "C", "Db", "D", 
                "Eb"
                ];
			public static const NOTES_NAMES:Vector.<String> = NOTES_NAMES_FLAT;

			
		public  static const NOTES_FREQUENCIES:Vector.<Number> = new <Number>[
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
				
				public  static const LEN_NOTES:uint = 100;
            
            //current state, working vars
            private var _currNote:String = ""; //note, description name
            private var _currPos:uint = 0; // position in the array of the note
            private var _currErrorHz:Number = 0; // errors
			private var _octave:uint;
			private var _currFreq:Number;
            //private var currErrorPerc:Number;
            private var _currErrorCents:Number;
			private var _currMidiNote:uint;
            
            private var f0:Number;

            public function NoteMapper()
            {
            }
			
			//transform a cents measure into the eauivalent Cents, based on the center Frequency (cents depend on center frequency)
			public static function cents2hz(centerFrequency:Number, ncents:Number):Number
			{
				var i:uint;
				var hzequiv:Number;	
                for(i=1; i< NoteMapper.LEN_NOTES; i++) // I don't really care for 16 hz, and so avoid problems
                {
                    var currError:Number = centerFrequency-NoteMapper.NOTES_FREQUENCIES[i];
                    if(Math.abs(currError) <0.01)
                    {
                        hzequiv = ncents * ( (NoteMapper.NOTES_FREQUENCIES[i+1] - NoteMapper.NOTES_FREQUENCIES[i]) / 100);// 100s part of the range between notes .. this is a rough approximation, but anyway the error is way below human hearing sensitivity
						trace("hz equivalency: ", centerFrequency, hzequiv, " 1cent= ", (NoteMapper.NOTES_FREQUENCIES[i+1] - NoteMapper.NOTES_FREQUENCIES[i]) / 100 , "hz");
                        break;
                    }
                }
				return hzequiv;
			}
			
            public function updateFreq( freq:Number):void
            {
                _currFreq = f0 = freq;
                var i:uint;
                var color:uint = 0xff0000;
                _octave = 10;
                var prevError:Number = -1000000000.0;
                var currError:Number = 0.0;
                //look for the closest frequency
                for(i=1; i< LEN_NOTES; i++) // I don't really care for 16 hz, and so avoid problems
                {
                    currError = freq-NOTES_FREQUENCIES[i];
                    //check if I already passed the point where I should be
                    if(Math.abs(currError) >Math.abs(prevError))
                    {
                        _currNote = NOTES_NAMES[i-1];
                        _currPos = i-1;
                        _currErrorHz = prevError;
                        //currErrorPerc = (prevError/NOTES_FREQUENCIES[i-1] )*100;
                        _currErrorCents = prevError/( (NOTES_FREQUENCIES[i]-NOTES_FREQUENCIES[i-1])/100);// 100s part of the range between notes .. this is a rough approximation, but anyway the error is way below human hearing sensitivity
                        break;
                    }

                    prevError = currError;
                }
            //update values 
            _octave = _currPos / 12;
			_currMidiNote = _currPos + 12;//to adjust to the displacement
            }
			
			public function get currNote():String 
			{
				return _currNote;
			}
			
			public function get currPos():uint 
			{
				return _currPos;
			}
			
			public function get currErrorHz():Number 
			{
				return _currErrorHz;
			}
			
			public function get octave():uint 
			{
				return _octave;
			}
			
			public function get currErrorCents():Number 
			{
				return _currErrorCents;
			}
			
			public function getNote():Note
			{
				var n:Note = new Note(_currFreq, _currNote, _octave, _currMidiNote );
				return n;
			}
	}
}