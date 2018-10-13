package com.leopanigo.audio_processing.parameter_configuration 
{
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class GuitarTunerParameters extends SpectAnalyzerParametrization 
	{
		
		public function GuitarTunerParameters() 
		{
			SAMPLE_RATE = 5512;   // Actual microphone sample rate (Hz)
            //SAMPLE_RATE:Number = 8000;   // Actual microphone sample rate (Hz)
            //SAMPLE_RATE = 11025;   // Actual microphone sample rate (Hz)
            //SAMPLE_RATE:Number = 22050;   // Actual microphone sample rate (Hz)
            //SAMPLE_RATE:Number = 44100;   // Actual microphone sample rate (Hz)
			
            LOGN = 16;              // Log2 FFT length
            WIN_LEN = 2048;
            UPDATE_PERIOD = 130;       // Period of spectrum updates (ms)

            HPS_LEVEL = 3; //number of harmonics in the HPS calculation

			DETECTION_THRESHOLD = 30; //Detection threshold .. yet to tune it
		
			////public var makeFFT:Boolean = true; //not used yet
			//public var makeHPS:Boolean = true; //HPS is almost mandatory for any good thing, 
			////public var makePowerSpectrum:Boolean = false; //FUTURE, for power spectrum calculation
			//makeChroma:Boolean = true; //CURRENTLY in development, calculate the chromagram, for that needs the 
			//makeMultiPitch:Boolean = true;
			//multiPitchLevel = 4;
		}
		
	}

}