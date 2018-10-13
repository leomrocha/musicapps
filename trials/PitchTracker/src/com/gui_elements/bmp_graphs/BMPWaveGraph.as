package com.gui_elements.bmp_graphs 
{
	import flash.geom.Rectangle; 
    import flash.utils.ByteArray;
    import flash.events.SampleDataEvent;
    import flash.media.Microphone;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.display.Sprite;
	import flash.geom.Rectangle;	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class BMPWaveGraph extends Bitmap
	{ // from http://wonderfl.net/c/heMs
        private var _w:uint,//width  with a rate of 11 this should be 512
                    _h:uint,//should be an odd number.
                    _a:uint,//amplitude factor
                    _ww:uint,//wave width
                    _wc:uint,//wave colour
                    _bgc:uint,//background colour
                    _offset:uint,//offset... just think of a DCOffset to get the idea
                    _sampleRect:Rectangle,//this is the line that we will draw per x
                    _N:int, //the max number of samples to draw
                    _sn:Number,//the current value of the sample at n  or s[n]
                    _n:int,
					_maxVal:Number = 1.0;
        public function BMPWaveGraph(width:uint = 512, height:uint = 211, waveWidthPercent:uint = 20, maxVal:Number=1.0, waveColour:uint = 0xAAffAA, backgroundColour:uint = 0x000000):void{
            _maxVal = maxVal;
			_w = width;
            //the height should be odd, or you will over flow... this isn't a concern in as3, as the player handles this automatically, so you won't get errors if you remove it.
            //I just wanted to keep it there for myself...
            if (height & 1) {
                //if odd do something
            }else {
                height += 1; //I know I should't have written it like this, but w/e  I it as it's better/faster than if(height%2==0){height+=1}
            }
            _h = height;
            _ww = (_h/100)*waveWidthPercent;
            _a = (_h - _ww) / 2;
            _offset = _a;
            _wc = waveColour;
            _bgc = backgroundColour;
            _sampleRect = new Rectangle(0, 0, 1, _ww);
            super(new BitmapData(_w, _h, false, _bgc));
        }
        public function drawGraph(valsVect:Vector.<Number>, maxVal:Number = 0):void {
			trace("valsVect", valsVect);
			if (maxVal != 0 )
			{
				_maxVal = maxVal;
			}
            _N = valsVect.length;
			//limit the display to the first _w elements, MAX
            if (_N>_w){
                _N = _w;
            }
            super.bitmapData.lock();
            super.bitmapData.fillRect(super.bitmapData.rect, _bgc);//clear screen this should be implemented in a  more efficient way!
			_n = 0;
			for each (var v:Number in valsVect)
			{
                _sampleRect.x = _n;// We could constrain this within bounds but I'm not going to.
                _sampleRect.y = _offset - v ;//_offset - _a * _sn / _maxVal;
				trace("drawing", _sampleRect.x, _sampleRect.y, v);
                super.bitmapData.fillRect(_sampleRect, _wc);
				_n++;
			}
            //for (_n = 0; _n != _N; ++_n) {
				//_sn = valsVect[_n];
                //_sampleRect.x = _n;// We could constrain this within bounds but I'm not going to.
                //_sampleRect.y = _offset - _sn ;//_offset - _a * _sn / _maxVal;
				//trace("drawing", _sampleRect.x, _sampleRect.y);
                //super.bitmapData.fillRect(_sampleRect,_wc);
            //}//I should probably also add a bit of code to draw the rest of the wave if _n is less than _w
            super.bitmapData.unlock();
        }
    }
	

}