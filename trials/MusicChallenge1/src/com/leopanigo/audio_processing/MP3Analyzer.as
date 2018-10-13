package com.leopanigo.audio_processing
{
    import __AS3__.vec.Vector;
	import com.leopanigo.music_concepts.Note;
    import flash.display.Sprite;
    import flash.events.*;
	import flash.net.URLRequest;
    //import flash.media.Microphone;
	import flash.media.Sound;
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
        public class MP3Analyzer extends EventDispatcher
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
			
            //private var m_mic:Microphone;               // Microphone object
            //private var m_writePos:uint = 0;            // Position to write new audio from mic
            //private var m_buf:Vector.<Number> = null;   // Buffer for mic audio
			//private var m_currVolume:Number = 0; 		// Current Volume detected by the microphone
	
			private var m_analyzedData:Vector.<Note>;//vector of already analyzed data
			private var m_dataToAnalyze:Vector.<Number>;//
			private var m_leftChannel:Vector.<Number>;
			private var m_rightChannel:Vector.<Number>;
			
			private var m_bytesLength:uint;
			private var m_byteArray:ByteArray;
			private var m_currentDataInAnalysis:Vector.<Number>;
			private var m_currentStartIndex:uint=0;
			private var m_currentEndIndex:uint = WIN_LEN-1;
			
			private var m_sound:Sound;
			
			private var noteMapper:NoteMapper;
			
			public static const noteNameChromaPosMap:Object = { "C":0, "C#":1, "D":2, "D#":3, "E":4,
																	 "F":5, "F#":6, "G":7, "G#":8, "A":9,
																	 "A#":10, "B":11}; 
																	 
			public static const noteChromaNamePosMap:Vector.<String> = new <String>["C", "C#", "D", "D#", "E",
																	 "F", "F#", "G", "G#", "A",
																	 "A#", "B" ]; 
            /**
             * 
             */     
            public function MP3Analyzer()
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
                //m_buf = new Vector.<Number>(BUF_LEN);
                //for ( i = 0; i < BUF_LEN; i++ )
                    //m_buf[i] = 0.0;
                
            }
			
			public function get MAXIMUM_DETECTABLE_FREQ(): Number
			{
				return MAX_DETECTABLE_FREQ;
			}
			
			public function cleanup():void
			{
				m_analyzedData = null; // new Vector.<Note>;
				m_sound = null;
				m_currentDataInAnalysis = null;
				m_currentStartIndex = 0;
				m_currentEndIndex = WIN_LEN;
			}
			//TODO get the loaded file
			public function analyzeMP3FromName(name:String):Vector.<Note>
			{
				var req:URLRequest = new URLRequest("click.mp3"); 
				m_sound = new Sound(req);
				//m_sound.addEventListener(ProgressEvent.PROGRESS, onLoadProgress); 
				m_sound.addEventListener(Event.COMPLETE, onLoadComplete); 
				m_sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError); 
				//open mp3
				//ask for raw data
				//analyze data
				
				return m_analyzedData;
			}
			
			private function onLoadProgress(event:ProgressEvent):void 
			{ 
				var loadedPct:uint = Math.round(100 * (event.bytesLoaded / event.bytesTotal)); 
				trace("The sound is " + loadedPct + "% loaded."); 
			} 
			 
			private function onLoadComplete(event:Event):void 
			{ 
				//var localSound:Sound = event.target as Sound; 
				//localSound.play(); 
				analyzeMP3FromSound(m_sound);
			} 
			private function onIOError(event:IOErrorEvent):void
			{ 
				trace("The sound could not be loaded: " + event.text); 
			}
			
			public function analyzeMP3FromSound(snd:Sound):Vector.<Note>
			{
				m_sound = snd;
				//ask for raw data
				m_byteArray = new ByteArray();
				//the loaded sound always is 44100 and has 2 channels
				m_bytesLength =  Math.floor((snd.length/1000)*44100)//sound samples extracted
				m_sound.extract(m_byteArray,m_bytesLength);
				//analyze data
				analyzeData();
				return m_analyzedData;
			}
			
			public function analyzeData():void //:Vector.<Note>
			{
				//cleaunup old data
				cleanup();
				//setup all the stuff
				var len_vect:uint = m_bytesLength + m_bytesLength % WIN_LEN; //make sure there is data enough for processing
				m_leftChannel = new Vector.<Number>(len_vect);
				m_rightChannel = new Vector.<Number>(len_vect);
				
				//vector where the output will be
				m_analyzedData = new Vector.<Note>(len_vect);
				//to actually create the notes with all the data for them
				noteMapper = new NoteMapper();
				
				var i:uint = 0;
				for ( i=0; i < m_bytesLength; i++)
				{
					var leftChannel:Number = m_byteArray.readFloat();
					var rightChannel:Number = m_byteArray.readFloat();
					m_leftChannel[i] = leftChannel;
					m_rightChannel[i] = rightChannel;
				}
				//zero the rest of the vectors
				for (i = m_bytesLength; i < len_vect; i++)
				{
					m_leftChannel[i] = 0;
					m_rightChannel[i] = 0;
				}
				m_dataToAnalyze = m_rightChannel; // I want to test the analysis only on the right channel for the moment, later might do both or a mean, I dont know yet
				//now for the whole vector, analyze chunks of window lenght 
				//updateSpectrum
				//len_vect = m_dataToAnalyze.length; //should not be necessary
				 var j:uint = 0;
				for ( i = 0, j=0; i < m_dataToAnalyze.length; j++)
				{
					m_currentStartIndex = i;
					m_currentEndIndex = i + WIN_LEN;
					if (m_currentEndIndex > len_vect) {break;}//security condition
					//updateSpectrum(m_currentStartIndex, m_currentEndIndex);
					updateSpectrum(m_currentStartIndex);
					//create the new note and put it in the output analyzed data
					noteMapper.updateFreq(f0);
					var n:Note = noteMapper.getNote();
					// calculate time for the note
					n.initTime =  m_currentStartIndex / 44100.0; //TODO check that the value is a Number and was not truncated, I don't know actionscript 3 behaviour here
					n.endTime = m_currentEndIndex / 44100.0;
					m_analyzedData[j] = n;
					
					i += WIN_LEN / 2;
				}
			}
			
            //private function updateSpectrum(startIndex:uint, endIndex:uint ):void
            private function updateSpectrum(startIndex:uint ):void
            {
                // Copy data from mp3 data  buffer
                //  into temporary buffer for FFT, while
                // applying Hanning window.
                var i:int;
                var j:int = 0; 
                //var pos:uint;
				//update timer //TODO or maybe not
				//currentTime = getTimer() * 0.001 - initTime;
				
                //if ( m_writePos-WIN_LEN >= 0 )
                //{
                    //pos = (m_writePos-WIN_LEN)%BUF_LEN;
                //}
                //else
                //{
                    //pos = (BUF_LEN - (WIN_LEN-m_writePos));//%BUF_LEN; //% is in case it gives 0
                //}
                //var pos:uint = m_writePos%BUF_LEN;//to read the last 1024 samples only
                for (i=0; i<N-WIN_LEN; i++)
                {
                    m_tempRe[i] = 0.0;
                }
                for ( i = N-WIN_LEN; i < N; i++ )
                {
                    m_tempRe[i] = m_win[i % WIN_LEN] * m_dataToAnalyze[startIndex + (i % WIN_LEN) ];
                    //pos = (pos+1)%BUF_LEN;
                }
				//END get data
				
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
				
                f0 = maxPos*BIN_RESOLUTION; //and here is the fundamental frequency
				//valid = true;
            }
			
        }
}

