package com.leopanigo.audio_processing
{
    import __AS3__.vec.Vector;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.media.Microphone;
    import flash.text.*;
    import flash.utils.*;

    /**
     * A real-time spectrum analyzer.
     * Calculates the FFT, HPS, approximation of the Constant Q Transform and the chromagram
     *
     * Copyright (c) 2012 Leonardo M. Rocha
     *
     *
     * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
     * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
     * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
     * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
     * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
     * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
     * IN THE SOFTWARE.
     */
        public class SpectrumAnalyzer extends EventDispatcher
        {

            //private const SAMPLE_RATE:Number = 5512;   // Actual microphone sample rate (Hz)
            //private const SAMPLE_RATE:Number = 8000;   // Actual microphone sample rate (Hz)
            private const SAMPLE_RATE:Number = 11025;   // Actual microphone sample rate (Hz)
            //private const SAMPLE_RATE:Number = 22050;   // Actual microphone sample rate (Hz)
            //private const SAMPLE_RATE:Number = 44100;   // Actual microphone sample rate (Hz)
            private const LOGN:uint = 16;              // Log2 FFT length
            private const N:uint = 1 << LOGN;           // FFT Length
            //private const NS:uint = 1024;               //number of samples for each 
            private const BUF_LEN:uint = N //NS;             // Length of buffer for mic audio
            private const WIN_LEN:uint = 2048;
            private const UPDATE_PERIOD:int = 30//130;       // Period of spectrum updates (ms)

            private const BIN_RESOLUTION:Number = SAMPLE_RATE/N; // resolution of each bin in frequency;
            //private const NEW_BIN_RESOLUTION:Number = (SAMPLE_RATE/5)/N; // resolution of each bin in frequency;
            //private var pos20hz:uint = Math.floor(20.0/BIN_RESOLUTION);


            private var HPS_LEVEL:uint = 3; //number of harmonics in the HPS calculation
			private var HPS_LEN:uint = N / (1<<HPS_LEVEL); //useful length of the HPS, all after that might go to errors
			//private var CHROMA_BINS:uint = 12; //number of bins in the chromagram: MUST be 12*n where n=1,2,....
			//private var XQT_SPREAD_FACTOR:Number = 0.7; //spread factor for constant Q transform approximation, takes care of inharmonicity factor and mistunnings
            
			private var MAX_DETECTABLE_FREQ:Number = SAMPLE_RATE / (2.0 * HPS_LEVEL);
			
			private const DETECTION_THRESHOLD:Number = 30; //Detection threshold .. yet to tune it
            private var m_fft:FFT2;                     // FFT object
            //private var m_chromagram:Vector.<Number>; //actual chromagram
			//private var m_chromaCount:Vector.<uint>; //for improving the enhanced chroma calculation
			//private var m_xqt:Vector.<XqtElement>; //vector containing the constant q transform approximation
			
			
			
            private var f0:Number; // detected fundamental frequency
			private var peaks:Vector.<Number>; //multipitch
			private var peaksPositions:Vector.<uint>;//positions in the lookup vector of the max elements
			
			private var MIN_PROPORTION_THRESHOLD:Number = 0.15; //multipitch detection threshold, taken as relative to the max value of the moment, if less than threshold the value is not considered
			
            private var m_tempRe:Vector.<Number>;       // Temporary buffer - real part
            private var m_tempIm:Vector.<Number>;       // Temporary buffer - imaginary part
            private var m_mag:Vector.<Number>;          // Magnitudes (at each of the frequencies below)
            private var m_freq:Vector.<Number>;         // Frequencies (for each of the magnitudes above) 
            private var m_win:Vector.<Number>;          // Analysis window (Hanning)
			
			private var m_maxnorm:Number;				//keeps the maximum value of the magnitude in the last calculation
			
			private var m_hps:Vector.<Number>;			// HPS from the calculation from the Magnitude above TODO this is still not used and everything is in place on the m_mag vector
			
            private var m_mic:Microphone;               // Microphone object
            private var m_writePos:uint = 0;            // Position to write new audio from mic
            private var m_buf:Vector.<Number> = null;   // Buffer for mic audio
			private var m_currVolume:Number = 0; 		// Current Volume detected by the microphone
			
            //private var m_tickTextAdded:Boolean = false; 

            private var m_timer:Timer;                  // Timer for updating spectrum
			private var initTime:Number;
			private var currentTime:Number;
            //private var hz:TextField; // display the current frequency
			
			
			//private var makeFFT:Boolean = true; //not used yet
			//private var makeHPS:Boolean = true; //HPS is almost mandatory for any good thing, 
			//private var makePowerSpectrum:Boolean = false; //FUTURE, for power spectrum calculation
			//private var makeChroma:Boolean = false; //CURRENTLY in development, calculate the chromagram, for that needs the 
			
			//private var makeMultipitch:Boolean = false;
			//private var multipitchLevel:uint = 3;

			private var valid:Boolean = false;
			
			private var nmp1:NoteMapper = new NoteMapper;
			private var nmp2:NoteMapper = new NoteMapper;
			
			public static const noteNameChromaPosMap:Object = { "C":0, "C#":1, "D":2, "D#":3, "E":4,
																	 "F":5, "F#":6, "G":7, "G#":8, "A":9,
																	 "A#":10, "B":11}; 
																	 
			public static const noteChromaNamePosMap:Vector.<String> = new <String>["C", "C#", "D", "D#", "E",
																	 "F", "F#", "G", "G#", "A",
																	 "A#", "B" ]; 
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
                m_mag = new Vector.<Number>(N / 2);
				
				//m_chromagram = new Vector.<Number>(CHROMA_BINS);
				//m_chromaCount = new Vector.<uint>(CHROMA_BINS);
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

				//setup chromagram calculations
				//if (makeChroma)
				//{
					//initXqtElements();
				//}
				
                // Set up a timer to do periodic updates of the spectrum        
                m_timer = new Timer(UPDATE_PERIOD);
                m_timer.addEventListener(TimerEvent.TIMER, updateSpectrum);
                
            }

			public function start():void
			{
				m_timer.start();
				initTime = getTimer() * 0.001;
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
			
			public function get MAXIMUM_DETECTABLE_FREQ(): Number
			{
				return MAX_DETECTABLE_FREQ;
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

			//makes the preloading of elements for the constant q transform approximation
			//private function initXqtElements():void
			//{
				//m_xqt = new Vector.<XqtElement>();//(NoteMapper.LEN_NOTES);
				//for (var i:uint = 13; i < NoteMapper.LEN_NOTES; i++ ) //from 4 to avoid underflow and non-audible frequencies
				//{
					//var txe:XqtElement = new XqtElement();
					//txe.noteName = NoteMapper.NOTES_NAMES_SHARP[i];
					//txe.noteFreq = NoteMapper.NOTES_FREQUENCIES[i];
					//if(txe.noteFreq > MAX_DETECTABLE_FREQ) break; //to avoid using frequencies that we can not detect
					//calculate position in HPC vector
					//var tpos:uint = txe.noteFreq / BIN_RESOLUTION;
					//txe.pos =  Math.floor(txe.noteFreq / BIN_RESOLUTION);
					//get the span according to the spread factor .. span= np.floor( ( ( (n_hz1-n_hz)/2 )/ bin_res )*k)
					//txe.span = Math.floor ( ( (NoteMapper.NOTES_FREQUENCIES[i] - NoteMapper.NOTES_FREQUENCIES[i - 1]) / 2.0 ) * XQT_SPREAD_FACTOR ) ;
					//txe.initPos = txe.pos - txe.span;
					//txe.endPos = txe.pos + txe.span + 1;
					//txe.value = 0.0;
					//m_xqt.push(txe);
				//}
			//}
			//
			//private function updateXqt():void
			//{
				//trace("updating chromagram");
				//trace(m_xqt.length);
				//clean chromagram
				//for ( var j:uint = 0; j < CHROMA_BINS; j++)
				//{
					//m_chromagram[j] = 0.0;
					//m_chromaCount[j] = 0;
				//}
				//calculate the approximate constant Q transform and make use of the loop to update the chromagram also
				//for each(var xqt:XqtElement in m_xqt)
				//{
					//if (!xqt)
						//continue;
					//trace("update xqt element: ", xqt.noteName);
					//
					//var qsum:Number = 0;
					//for (var i:uint = xqt.initPos; i <= xqt.endPos; i++ )
					//{
						//trace("suming", qsum, m_mag[i], m_maxnorm);
						//qsum = qsum + (m_mag[i] / m_maxnorm); //only normalize the values for the sum this avoids number overflow AND keeps divisions to a minimum
						//qsum = qsum + (m_mag[i]); //only normalize the values for the sum this avoids number overflow AND keeps divisions to a minimum
					//}
					//qsum = qsum + (m_mag[xqt.pos] / m_maxnorm); //WARNING, this does not take in account misstunings and inharmonicity factor, check previous for cycle for that, this is only a test
					//
					//trace("qsum = ", qsum);
					//xqt.value = qsum;
					//update chromagram now
					//
					//var notepos:uint = noteNameChromaPosMap[xqt.noteName];/
					//trace("update xqt element: ", xqt.noteName, xqt.noteFreq, xqt.pos, xqt.span, xqt.initPos, xqt.endPos, xqt.value);
					//trace("notepos,chromaval:  ", notepos, m_chromagram[notepos]);
					//m_chromagram[notepos] += qsum;//WARNING here might be the error
					//m_chromaCount[notepos]++;
				//}
				//for ( j = 0; j < CHROMA_BINS; j++)
				//{
					//m_chromagram[j] = m_chromagram[j]/ m_chromaCount[j];
					//
				//}
			//}
			//private function updateChroma():void
			//{
				//
			//}
            /**
             * Called at regular intervals to update the spectrum
             */
			
			 //TODO this algorithm is only for testing, is really slow, I MUST improve it for performance
			//private function findPeaks():void
			//{
				//var i:uint, j:uint, k:uint;
				//peaks = new Vector.<Number>;
				//peaksPositions = new Vector.<uint>;
				//var maxPos:uint;
				//
				//var power2positions:Vector.<uint> = new Vector.<uint>;
				//var localMax:Number = 0.0;
				//var isMax:Boolean = true;
				//var lenMag:uint = N / (2 * HPS_LEVEL ); // cause transform is symetric, we want only positive part
				//
				//
				//for (k = 0; k < multipitchLevel; k++)
				//{
					//maxPos = 0;
					//localMax = 0;
					//
					// Make HPS //I can compress all the iterations in one I think, and instead of multiplication I could put sumations... things to test for performance and accuracy!!! 
					//for (i = 0; i< lenMag; i++)
					//{
						//isMax = true;
						//if (m_mag[i] > localMax) //for normalization later
						//{
							//for ( j = 0; j < peaksPositions.length; j++ )
							//{//eliminate all the harmonics from the equation
								//if (peaks[j] > 30)
								//{
									//TODO find a better way to do this, this is TOOOOO slow
									//nmp1.updateFreq(peaksPositions[j] * BIN_RESOLUTION);
									//nmp2.updateFreq(i * BIN_RESOLUTION);
									////if ( Number(p) % Number(i) ) isMax = false;
									////if ( p == i || p*2 == i || p*4 == i || p*8 == i) isMax = false;
									////if ( p == i ) isMax = false;
									//if (nmp1.currPos == nmp2.currPos) isMax = false; //only filters equal tempered notes
									////if (nmp1.currNote == nmp2.currNote) isMax = false; //filters by note, does not distinguish between octaves
									//
									//the log transform is MUCH faster than the noteMapper method, though I don't know how much better
									//TODO make the actual logarithmic calculation, this value is only for testing!!!!!
									//if (Math.abs(Math.log(peaksPositions[j]) - Math.log(i) )< 0.5 ) isMax = false;
								//}
								//
							//}
							//if(isMax)
							//{
								//maxPos = i; //getting the point where the max value is found
								//localMax = m_mag[i];
							//}
							//
						//}
					//}
					//peaks.push(m_maxnorm);
					//if (k == 0 || localMax / m_maxnorm > MIN_PROPORTION_THRESHOLD)
					//{
						//peaks.push(maxPos*BIN_RESOLUTION); //and here is the fundamental frequency);
						//peaksPositions.push(maxPos);
						//power2positions.push(maxPos * 16);	
					//}else
					//{
						//peaks.push(0); //and here is the fundamental frequency);
						//peaksPositions.push(maxPos);
						//power2positions.push(maxPos * 16);	
					//}
					//
				//}
			//}
			
            private function updateSpectrum( event:Event ):void
            {
                // Copy data from circular microphone audio 
                // buffer into temporary buffer for FFT, while
                // applying Hanning window.
                var i:int;
                var j:int = 0; 
                var pos:uint;
				//update timer
				currentTime = getTimer() * 0.001 - initTime;
				
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
                    m_mag[i] = Math.sqrt(re * re + im * im); //an approximation that works faster could be done here ... but this will carry more errors to the later processing stages
					//TODO we could only use the first half of the transform, i.e. the positive part (this will cause N/2 less calculations)
                }
				
				var maxPos:uint = 0; //position of the max val in the result

				//if (makeHPS){ //always true for the moment
					//var maxnorm:Number = 0.0;
					m_maxnorm = 0.0;
					var lenMag:uint = N/2; // cause transform is symetric, we want only positive part
					// Make HPS //I can compress all the iterations in one I think, and instead of multiplication I could put sumations... things to test for performance and accuracy!!! 
					for (i = 0; i< lenMag/HPS_LEVEL; i++)
					{
						for(j = 2; j<= HPS_LEVEL; j++) //HPS calculation
						{
							//if(m_mag[i] > 0.0 && m_mag[i*j] > 0.0) //is already non negative
							//{
								m_mag[i] = m_mag[i]* m_mag[i*j];
							//}
						}
						if (m_mag[i] > m_maxnorm) //for normalization later
						{
							maxPos = i; //getting the point where the max value is found
							m_maxnorm = m_mag[i];
						}
					}
					// //normalization ->not useful for the moment
					//for (i = 0; i< lenMag/HPS_LEVEL; i++)
					//{
						//m_mag[i] = m_mag[i]/maxnorm;
					//}
				//} //END if makeHPS
                //else // if makeHPS is false                
                // //get maximum peaks (the 5 most important??)
                //var maxPos:uint = 0;
                //var maxVal:Number = -1000.0;
                // //trace("maxPos" + maxPos);
                // //trace("maxVal" + maxVal);
                // //pos20hz = 20/NEW_BIN_RESOLUTION;

                //for (i=0; i< lenMag/HPS_LEVEL; i++)
                //{
                    //if(m_mag[i] > maxVal)
                    //{
                        //maxPos = i;
                        //maxVal = m_mag[i];
                    //}
                //}
				// } //END else if makeHPS
				//if (makeChroma)
				//{
					//updateXqt();
					//updateChroma();
				//}
				
                f0 = maxPos*BIN_RESOLUTION; //and here is the fundamental frequency
                //put them in the text
                //hz.text = "Resolution = " + BIN_RESOLUTION +"  f0 = " +f0 + " Hz ";
                
                //draw HPS ... for debugging!!!

                // Convert to dB magnitude
                //const SCALE:Number = 20/Math.LN10;      
                //for ( i = 0; i < N/2; i++ )
                //{
                    // 20 log10(mag) => 20/ln(10) ln(mag)
                    // Addition of MIN_VALUE prevents log from returning minus infinity if mag is zero
                    //m_mag[i] = SCALE*Math.log( m_mag[i] + Number.MIN_VALUE );
                //}
				//if (makeMultipitch)
				//{
					//findPeaks();
				//}
				valid = true;
                //here I should launch an event with the detected frequency
				//trace("spectrum analysis available");
				//trace("sending spectrumevent:", m_currVolume, f0, freq)
				//trace("chromagram sent: ", m_chromagram);
				//dispatchEvent(new SpectrumEvent(m_currVolume, f0, currentTime, peaks));
				dispatchEvent(new SpectrumEvent(m_currVolume, f0, currentTime));
            }
			
        }
}

