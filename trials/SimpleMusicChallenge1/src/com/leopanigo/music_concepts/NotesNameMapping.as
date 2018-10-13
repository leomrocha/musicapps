package com.leopanigo.music_concepts 
{
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class NotesNameMapping
	{
		//TODO complete this conversion dictionary
		//public static const FROM_LATIN_NOTES_NAMES_SHARP_POS_MAP:Object = { "Do":"C", "Do#":"C#", "Reb":"Db", "Re":"D", "D#":"Re#", "Eb":"Mib", "E":"Mi",
														   //"F":"Fa", "F#":"Fa#", "Gb":"Solb", "G":"Sol", "G#":"Sol#", "Ab":"Lab", "A":"La",
														   //"A#":"La#", "Bb":"Sib", "B":"Si" };
		
		public static const TO_LATIN_NOTES_NAMES_SHARP_POS_MAP:Object = { "C":"Do", "C#":"Do#", "Db":"Reb", "D":"Re", "D#":"Re#", "Eb":"Mib", "E":"Mi",
														   "F":"Fa", "F#":"Fa#", "Gb":"Solb", "G":"Sol", "G#":"Sol#", "Ab":"Lab", "A":"La",
														   "A#":"La#", "Bb":"Sib", "B":"Si" };
		
		public static const NOTES_NAMES_SHARP_POS_MAP:Object = { "C":0, "C#":1, "D":2, "D#":3, "E":4,
																 "F":5, "F#":6, "G":7, "G#":8, "A":9,
																 "A#":10, "B":11}; 
		
		public static const NOTES_NAMES_FLAT_POS_MAP:Object = { "C":0, "Db":1, "D":2, "Eb":3, "E":4,
																"F":5, "Gb":6, "G":7, "Ab":8, "A":9,
																"Bb":10, "B":11}; 
																 
		public static const NOTES_NAMES_POS_MAP:Object = { "C":0, "C#":1, "Db":1, "D":2, "D#":3, "Eb":3, "E":4,
														   "F":5, "F#":6, "Gb":6, "G":7, "G#":8, "Ab":8, "A":9,
														   "A#":10, "Bb":10, "B":11 };

		public static const IS_ACCIDENTAL:Object = { "C":false, "C#":true, "Db":true, "D":false, "D#":true, "Eb":true, "E":false,
														   "F":false, "F#":true, "Gb":true, "G":false, "G#":true, "Ab":true, "A":false,
														   "A#":true, "Bb":true, "B":false };
														   
		public static const IS_FLAT:Object = { "C":false, "C#":false, "Db":true, "D":false, "D#":false, "Eb":true, "E":false,
														   "F":false, "F#":false, "Gb":true, "G":false, "G#":false, "Ab":true, "A":false,
														   "A#":false, "Bb":true, "B":false };
														   
		public static const IS_SHARP:Object = { "C":false, "C#":true, "Db":false, "D":false, "D#":true, "Eb":false, "E":false,
														   "F":false, "F#":true, "Gb":false, "G":false, "G#":true, "Ab":false, "A":false,
														   "A#":true, "Bb":false, "B":false };
														   
		public static const NOTES_NAMES_SHARP_ARRAY:Vector.<String> = new <String>["C", "C#", "D", "D#", "E",
																 "F", "F#", "G", "G#", "A",
																 "A#", "B" ]; 
																 
		public static const NOTES_NAMES_FLAT_ARRAY:Vector.<String> = new <String>["C", "Db", "D", "Eb", "E",
																 "F", "Gb", "G", "Ab", "A",
																 "Bb", "B" ];
																 
		public static const NOTES_COLOURS_ARRAY:Vector.<uint> = new <uint>[0xCC0000, 0xaa2200, 0x884400, 0x666600, 0x448800,0x22aa00,0x00cc00, 0x00aa22, 0x008844, 0x006666, 0x004488,0x0022aa, 0x0000cc];
		
		//precomputed vectors of names, frequencies and some other things. This allows faster processing on expence of more memory used
		
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
                "A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", 
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
		
	}

}