package com.leopanigo.audio_processing
{
    import flash.media.Sound;
    import flash.events.SampleDataEvent;
    import flash.events.Event;
 
    public class ToneSynthesis
    {
        protected const RATE:Number = 44100;
        protected var _position:int = 0;
        protected var _sound:Sound;
        protected var _numSamples:int = 2048;
        protected var _samples:Vector.<Number>;
        protected var _isPlaying:Boolean = false;
 
        protected var _frequency:Number;
 
        public function ToneSynthesis(frequency:Number)
        {
            _frequency = frequency;
            _sound = new Sound();
            _sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
            _samples = new Vector.<Number>();
            createSamples();
        }
 
        protected function createSamples():void
        {	//TODO modify the sample generator to make the sounding time longer
            var amp:Number = 10.0;
            var i:int = 0;
            var mult:Number = frequency / RATE * Math.PI * 2;
            while (amp > 0.01)
			//while(i < RATE * 0.5 ) //
            {
                _samples[i] = Math.sin(i * mult) * amp;
                amp *= 0.9998;
                i++;
            }
            _samples.length = i;
        }
 
        public function play():void
        {
            if(!_isPlaying)
            {
                _position = 0;
                _sound.play();
                _isPlaying = true;
            }
        }
 
        protected function onSampleData(event:SampleDataEvent):void
        {
            for (var i:int = 0; i < _numSamples; i++)
            {
                if(_position >= _samples.length)
                {
                    _isPlaying = false;
                    return;
                }
                event.data.writeFloat(_samples[_position]);
                event.data.writeFloat(_samples[_position]);
                _position++;
            }
        }
 
        public function set frequency(value:Number):void
        {
            _frequency = value;
            createSamples();
        }
        public function get frequency():Number
        {
            return _frequency;
        }
    }
}