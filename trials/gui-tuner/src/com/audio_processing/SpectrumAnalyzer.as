package com.audio_processing
{
    import __AS3__.vec.Vector;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.media.Microphone;
    import flash.text.*;
    import flash.utils.*;
	
	import com.audio_processing.NoteMapper; //for the vectors of the values

    /**
     * A real-time spectrum analyzer.
     * 
     *
     * Copyright (c) 2010 Leonardo M. Rocha
     *
     * Permission is hereby granted, free of charge, to any person obtaining a copy
     * of this software and associated documentation files (the "Software"), to
     * deal in the Software without restriction, including without limitation the
     * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
     * sell copies of the Software, and to permit persons to whom the Software is
     * furnished to do so, subject to the following conditions:
     *
     * The above copyright notice and this permission notice shall be included in
     * all copies or substantial portions of the Software.
     *
     * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
     * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
     * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
     * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
     * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
     * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
     * IN THE SOFTWARE.
     */
        public class SpectrumAnalyzer
        {

            private const SAMPLE_RATE:Number = 5512;   // Actual microphone sample rate (Hz)
            private const LOGN:uint = 16;              // Log2 FFT length
            private const N:uint = 1 << LOGN;           // FFT Length
            //private const NS:uint = 1024;               //number of samples for each 
            private const BUF_LEN:uint = N //NS;             // Length of buffer for mic audio
            private const WIN_LEN:uint = 2048;
            private const UPDATE_PERIOD:int = 130;       // Period of spectrum updates (ms)

            private const BIN_RESOLUTION:Number = SAMPLE_RATE/N; // resolution of each bin in frequency;
            //private const NEW_BIN_RESOLUTION:Number = (SAMPLE_RATE/5)/N; // resolution of each bin in frequency;
            private var pos20hz:uint = Math.floor(20.0/BIN_RESOLUTION);

            private var HPS_LEVEL:uint = 4; //number of harmonics in the HPS calculation
			private var HPS_LEN:uint = N / (1<<HPS_LEVEL); //useful length of the HPS, all after that might go to errors
			private var CHROMA_BINS:uint = 12; //number of bins in the chromagram: MUST be 12*n where n=1,2,....
			

			
            private const DETECTION_THRESHOLD:Number = 0.1; //Detection threshold .. yet to tune it
            private var m_fft:FFT2;                     // FFT object
            private var m_chromagram:Vector.<Number>; //actual chromagram
			
            private var f0:Number; // detected fundamental frequency

            private var m_tempRe:Vector.<Number>;       // Temporary buffer - real part
            private var m_tempIm:Vector.<Number>;       // Temporary buffer - imaginary part
            private var m_mag:Vector.<Number>;          // Magnitudes (at each of the frequencies below) -> will contain the HPS
            private var m_freq:Vector.<Number>;         // Frequencies (for each of the magnitudes above) 
            private var m_win:Vector.<Number>;          // Analysis window (Hanning)

            private var m_mic:Microphone;               // Microphone object
            private var m_writePos:uint = 0;            // Position to write new audio from mic
            private var m_buf:Vector.<Number> = null;   // Buffer for mic audio
			private var m_currVolume:Number = 0; 		// Current Volume detected by the microphone
			
            private var m_tickTextAdded:Boolean = false; 

            private var m_timer:Timer;                  // Timer for updating spectrum
     
            //private var hz:TextField; // display the current frequency

			private var valid:Boolean = false;
            /**
             * 
             */     
            public function SpectrumAnalyzer()
            {
                var i:uint;

                f0 = 0.0;

                // Set up the FFT
                m_fft = new FFT2();
                m_fft.init(LOGN);
                m_tempRe = new Vector.<Number>(N);
                m_tempIm = new Vector.<Number>(N);
                m_mag = new Vector.<Number>(N/2);
                //m_smoothMag = new Vector.<Number>(N/2);

                // Vector with frequencies for each bin number. Used 
                // in the graphing code (not in the analysis itself).           
                m_freq = new Vector.<Number>(N/2);
                for ( i = 0; i < N/2; i++ )
                    m_freq[i] = i*SAMPLE_RATE/N;

                // Hanning analysis window
                m_win = new Vector.<Number>(WIN_LEN);
                for ( i = 0; i < WIN_LEN; i++ )
                    m_win[i] = (4.0/WIN_LEN) * 0.5*(1-Math.cos(2*Math.PI*i/WIN_LEN));

                // Create a buffer for the input audio
                m_buf = new Vector.<Number>(BUF_LEN);
                for ( i = 0; i < BUF_LEN; i++ )
                    m_buf[i] = 0.0;

                // Set up microphone input
                m_mic = Microphone.getMicrophone();
                m_mic.rate = SAMPLE_RATE/1000;      
                m_mic.setSilenceLevel(DETECTION_THRESHOLD);         // if 0.0 Have the mic run non-stop, regardless of the input level
                m_mic.addEventListener( SampleDataEvent.SAMPLE_DATA, onMicSampleData );

                // Set up a timer to do periodic updates of the spectrum        
                m_timer = new Timer(UPDATE_PERIOD);
                m_timer.addEventListener(TimerEvent.TIMER, updateSpectrum);
                
            }

			public function start():void
			{
				m_timer.start();
			}
			//public function pause():void
			//{
			//	m_timer.start();
			//}
			
			public function stop():void
			{
				if (m_timer.running)
					m_timer.stop();
			}
            /**
            * Returns the current frequency
            */
            public function get freq():Number
            {
				var ret:Number = -1;
				if (valid)
                {
					ret = f0;
					valid = false;
				}
				return ret;
            }
			
			/**
			 * Returns the current volume
			 */
			public function get volume():Number
			{
				return m_currVolume;
			}
            /**
             * Called whether new microphone input data is available. See this call
             * above:
             *    m_mic.addEventListener( SampleDataEvent.SAMPLE_DATA, onMicSampleData );
             */
            private function onMicSampleData( event:SampleDataEvent ):void
            {
                // Get number of available input samples
                var len:uint = event.data.length/4;

                // Read the input data and stuff it into 
                // the circular buffer
                for ( var i:uint = 0; i < len; i++ )
                {
                    m_buf[m_writePos] = event.data.readFloat();
                    m_writePos = (m_writePos+1)%BUF_LEN;
                }
				//Update volume detected
				m_currVolume = m_mic.activityLevel;
				
            }

            /**
             * Called at regular intervals to update the spectrum
             */
            private function updateSpectrum( event:Event ):void
            {
                // Copy data from circular microphone audio 
                // buffer into temporary buffer for FFT, while
                // applying Hanning window.
                var i:int;
                var j:int = 0; 
                var pos:uint;
                if ( m_writePos-WIN_LEN >= 0 )
                {
                    pos = (m_writePos-WIN_LEN)%BUF_LEN;
                }
                else
                {
                    pos = (BUF_LEN - (WIN_LEN-m_writePos));//%BUF_LEN; //% is in case it gives 0
                }
                //var pos:uint = m_writePos%BUF_LEN;//to read the last 1024 samples only
                for (i=0; i<N-WIN_LEN; i++)
                {
                    m_tempRe[i] = 0.0;
                }
                for ( i = N-WIN_LEN; i < N; i++ )
                {
                    m_tempRe[i] = m_win[i%WIN_LEN]*m_buf[pos];
                    pos = (pos+1)%BUF_LEN;
                }

                // Zero out the imaginary component
                for ( i = 0; i < N; i++ )
                    m_tempIm[i] = 0.0;

                // Do FFT and get magnitude spectrum
                m_fft.run( m_tempRe, m_tempIm );
                for ( i = 0; i < N/2; i++ )
                {
                    var re:Number = m_tempRe[i];
                    var im:Number = m_tempIm[i];
                    m_mag[i] = Math.sqrt(re*re + im*im);
                }
                var maxnorm:Number = 0.0;
                var lenMag:uint = N / 2; // cause transform is symetric, we want only positive part
				//END of FFT, now at m_fft is the fft
				
                // Make HPS //I can compress all the iterations in one I think, and instead of multiplication I could put sums... things to test for performance and accuracy!!! 
                for (i = 0; i< lenMag/HPS_LEVEL; i++)
                {
                    for(j = 2; j<= HPS_LEVEL; j++) //HPS calculation
                    {
                        //if(m_mag[i] > 0.0 && m_mag[i*j] > 0.0)
                        //{
                            m_mag[i] = m_mag[i]* m_mag[i*j];
                        //}
                    }
                    if (m_mag[i] > maxnorm) //for normalization later
                    {
                        maxnorm = m_mag[i];
                    }
                }
                for (i = 0; i< lenMag/HPS_LEVEL; i++)
                {
                    m_mag[i] = m_mag[i]/maxnorm;
                }
				///end of HPS
                ////Constant Q Transform
				//Actually is only an approximation of the Constant Q transform
				
				//// END constant Q Transform
				////Chromagram
				//TODO
				////END Chromagram
                // get maximum peaks (the 5 most important??)
                var maxPos:uint = 0;
                var maxVal:Number = -1000.0;
                //trace("maxPos" + maxPos);
                //trace("maxVal" + maxVal);
                //pos20hz = 20/NEW_BIN_RESOLUTION;
                for (i=0; i< lenMag/HPS_LEVEL; i++)
                {
                    if(m_mag[i] > maxVal)
                    {
                        maxPos = i;
                        maxVal = m_mag[i];
                    }
                }
                f0 = maxPos*BIN_RESOLUTION;
                //put them in the text
                //hz.text = "Resolution = " + BIN_RESOLUTION +"  f0 = " +f0 + " Hz ";
                
                //draw HPS ... for debugging!!!

                // Convert to dB magnitude
                const SCALE:Number = 20/Math.LN10;      
                for ( i = 0; i < N/2; i++ )
                {
                    // 20 log10(mag) => 20/ln(10) ln(mag)
                    // Addition of MIN_VALUE prevents log from returning minus infinity if mag is zero
                    m_mag[i] = SCALE*Math.log( m_mag[i] + Number.MIN_VALUE );
                }
				valid = true;
                //here I should launch an event with the detected frequency
				//trace("spectrum analysis available");
            }  
        }
}

