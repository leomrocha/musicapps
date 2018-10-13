package com.leopanigo.audio_processing.parameter_configuration 
{
	/**
	 * Contains all the configuration for a spefic type of instrument, with the best parameters found for it
	 *
	 * @author Leo Panigo
	 */
	//NOTE TODO this should be done by a dynamic XML file instead of a static compiled as file
	public class SpectAnalyzerParametrization 
	{
		
			//public const SAMPLE_RATE:Number = 5512;   // Actual microphone sample rate (Hz)
            //public const SAMPLE_RATE:Number = 8000;   // Actual microphone sample rate (Hz)
            public var SAMPLE_RATE:Number = 11025;   // Actual microphone sample rate (Hz)
            //public const SAMPLE_RATE:Number = 22050;   // Actual microphone sample rate (Hz)
            //public const SAMPLE_RATE:Number = 44100;   // Actual microphone sample rate (Hz)
			
            public var LOGN:uint = 16;              // Log2 FFT length
            public var WIN_LEN:uint = 2048;
            public var UPDATE_PERIOD:int = 30//130;       // Period of spectrum updates (ms)

            public var HPS_LEVEL:uint = 4; //number of harmonics in the HPS calculation
			//public var HPS_LEN:uint = N / (1<<HPS_LEVEL); //useful length of the HPS, all after that might go to errors
			//public var CHROMA_BINS:uint = 12; //number of bins in the chromagram: MUST be 12*n where n=1,2,....
			//public var XQT_SPREAD_FACTOR:Number = 0.7; //spread factor for constant Q transform approximation, takes care of inharmonicity factor and mistunnings
            
			public var DETECTION_THRESHOLD:Number = 30; //Detection threshold .. yet to tune it
		
			////public var makeFFT:Boolean = true; //not used yet
			//public var makeHPS:Boolean = true; //HPS is almost mandatory for any good thing, 
			////public var makePowerSpectrum:Boolean = false; //FUTURE, for power spectrum calculation
			//public var makeChroma:Boolean = false; //CURRENTLY in development, calculate the chromagram, for that needs the 
			//public var makeMultiPitch:Boolean = false;
			//public var multiPitchLevel:uint = 5;
			
	}

}