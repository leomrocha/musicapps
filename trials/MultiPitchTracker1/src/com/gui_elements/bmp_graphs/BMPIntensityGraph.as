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
	public class BMPIntensityGraph extends Bitmap
	{ // from http://wonderfl.net/c/heMs
        private var _w:uint,//width  with a rate of 11 this should be 512
                    _h:Number,//should be an odd number.
                    _a:Number,//amplitude factor
                    _bgc:uint,//background colour
                    _offset:uint,//offset... just think of a DCOffset to get the idea
                    _sampleRect:Rectangle,//this is the line that we will draw per x
                    _N:int, //the max number of samples to draw
                    _sn:Number,//the current value of the sample at n  or s[n]
                    _n:Number,
					_rectWidth:Number,
					_pointWidth:Number,
					_maxVal:Number = 1.0;
        public function BMPIntensityGraph(width:uint = 512, height:uint = 211, maxVal:Number=1.0, pointWidth:Number = 1, backgroundColour:uint = 0x000000):void{
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
            _a = _h /( maxVal * 2 );
            _offset = _h/2;
            _bgc = backgroundColour;
			_pointWidth = pointWidth;
			_rectWidth = 1;
            _sampleRect = new Rectangle(0, 0, _rectWidth, _pointWidth);
            super(new BitmapData(_w, _h, false, _bgc));
        }
		
        public function drawGraph(valsVect:Vector.<Number>, colourVect:Vector.<uint>):void {
			if (valsVect.length != colourVect.length)
			{
				trace("error in number of elements in drawGRaph, BMPAmplitudGraph class");
				throw(new Error("BMPAmplitudGraph.drawGraph ERROR: Values vector and colours vector are different in length, MUST be equal"));
			}
            _N = valsVect.length;
			//limit the display to the first _w elements, MAX, this is for the ease of mind!!
            if (_N>_w){
                _N = _w;
				_rectWidth = 1;
				
            }else if (_N < _w)
			{
				_rectWidth = Number(_w) / Number(_N);
			}else
			{
				_rectWidth = 1;
			}
			
            super.bitmapData.lock();
            super.bitmapData.fillRect(super.bitmapData.rect, _bgc);
			_n = 0;
			//for each (var v:Number in valsVect)
			for (var i:uint = 0 ; i < valsVect.length; i++ )
			{
				var h:Number = Math.abs(valsVect[i] * _a);
				_sampleRect = new Rectangle(0, 0, _rectWidth, h);
                _sampleRect.x = _n;// We could constrain this within bounds but I'm not going to.
                //_sampleRect.y = _offset - (v * _a);//_offset - _a * _sn / _maxVal;
				if (valsVect[i] >= 0)
				{
					_sampleRect.y = _offset - h;
				}else {
					_sampleRect.y = _offset;
				}
				
                //_sampleRect.y = _offset - valsVect[i] ;
				//trace("drawing", _sampleRect.x, _sampleRect.y, v);
                super.bitmapData.fillRect(_sampleRect, colourVect[i]);
				_n += _rectWidth;
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