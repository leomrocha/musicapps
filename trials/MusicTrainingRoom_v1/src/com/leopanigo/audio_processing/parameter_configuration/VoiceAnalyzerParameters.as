package com.leopanigo.audio_processing.parameter_configuration 
{
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class VoiceAnalyzerParameters extends SpectAnalyzerParametrization 
	{
		
		public function VoiceAnalyzerParameters() 
		{
			//SAMPLE_RATE = 5512;   // Actual microphone sample rate (Hz)
            //SAMPLE_RATE:Number = 8000;   // Actual microphone sample rate (Hz)
            SAMPLE_RATE = 11025;   // Actual microphone sample rate (Hz)
            //SAMPLE_RATE:Number = 22050;   // Actual microphone sample rate (Hz)
            //SAMPLE_RATE:Number = 44100;   // Actual microphone sample rate (Hz)
			
            LOGN = 16;              // Log2 FFT length
            WIN_LEN = 2048;
            UPDATE_PERIOD = 30;       // Period of spectrum updates (ms)

            HPS_LEVEL = 3; //number of harmonics in the HPS calculation

			DETECTION_THRESHOLD = 30; //Detection threshold .. yet to tune it
		
			////public var makeFFT:Boolean = true; //not used yet
			//public var makeHPS:Boolean = true; //HPS is almost mandatory for any good thing, 
			////public var makePowerSpectrum:Boolean = false; //FUTURE, for power spectrum calculation
			//public var makeChroma:Boolean = false; //CURRENTLY in development, calculate the chromagram, for that needs the 
			//public var makeMultiPitch:Boolean = false;
			//public var multiPitchLevel = 1;
		}
		
	}

}