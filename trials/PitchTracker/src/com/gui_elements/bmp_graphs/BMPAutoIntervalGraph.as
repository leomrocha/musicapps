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
	public class BMPAutoIntervalGraph extends Bitmap
	{ // from http://wonderfl.net/c/heMs
        private var _w:uint;//width  with a rate of 11 this should be 512
        private var _h:uint;//should be an odd number.
        private var _a:uint;//amplitude factor
		//colours
        private var _okc:uint;//wave colour
        private var _errc:uint;//wave colour
        private var _bgc:uint;//background colour
		
        //private var _offset:uint;//offset... just think of a DCOffset to get the idea
		
        private var _sampleRect:Rectangle;//this is the line that we will draw per x value
        private var _okSampleRect:Rectangle;
		private var _errorSampleRect:Rectangle;
		
		//
		private var _N:int; //the max number of samples to draw
        private var _sn:Number;//the current value of the sample at n  or s[n]
        private var _n:int;
		
		//value tracking, for interval calculations
		private var _prevMax:Number = 1.0;
		private var _prevMaxAge:uint = 0;
		private var _currMax:Number = 1.0;
		private var _currMaxAge:uint = 0;
		private var _nextMax:Number = 1.0;
		private var _nextMaxAge:uint = 0;
		
		private var _prevMin:Number = 0.0;
		private var _prevMinAge:uint = 0;
		private var _currMin:Number = 0.0;
		private var _currMinAge:uint = 0;
		private var _nextMin:Number = 0.0;
		private var _nextMinAge:uint = 0;
		
        public function BMPAutoIntervalGraph(width:uint = 512, height:uint = 211, 
											maxErrorCents:Number = 5,
											pointWidth:Number = 2, pointHeight:Number = 4,
											okColour:uint = 0x00FF00, errorColour:uint = 0xFF0000,
											backgroundColour:uint = 0x050505):void
		{
			_w = width;
            _h = height;
			
			
            _bgc = backgroundColour;
            _sampleRect = new Rectangle(0, 0, 1, pointWidth);
            super(new BitmapData(_w, _h, false, _bgc));
        }
		
        public function drawGraph(valsVect:Vector.<Number>, maxVal:Number = 0):void {
			//trace("valsVect", valsVect);
			if (maxVal != 0 )
			{
				_maxVal = maxVal;
				_a = _h / maxVal;
			}
            _N = valsVect.length;
			//limit the display to the first _w elements, MAX
            if (_N>_w){
                _N = _w;
            }
            super.bitmapData.lock();
            super.bitmapData.fillRect(super.bitmapData.rect, _bgc);
			_n = 0;
			for each (var v:Number in valsVect)
			{
                _sampleRect.x = _n;// We could constrain this within bounds but I'm not going to.
                _sampleRect.y = _offset - (v * _a);//_offset - _a * _sn / _maxVal;
				//trace("drawing", _sampleRect.x, _sampleRect.y, v);
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