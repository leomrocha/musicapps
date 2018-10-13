package com.gui_elements 
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
	public class GraphPlot 
	{
		private var _w:uint;
		private var _h:uint;
		private var _maxVal:Number;
		
		public function GraphPlot(w:uint, h:uint, max:Number, label:String ) 
		{
			_w = w;
			_h = h;
			_maxVal = max;
			
		}
		
	}

}
	
/*
 * 
//from http://wonderfl.net/c/x2fX 

import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.events.SampleDataEvent;
internal class BMPWaveGraph extends Bitmap{
        private var _w:uint,//width  with a rate of 11 this should be 512
                    _h:uint,//should be an odd number.
                    _a:uint,//amplitude factor
                    _wc:uint,//water colour
                    _sc:uint,//sky colour
                    _offset:uint,//offset... just think of a DCOffset to get the idea
                    _sampleRect:Rectangle,//this is the line that we will draw per x
                    _N:int, //the max number of samples to draw
                    _sn:Number,//the current value of the sample at n  or s[n]
                    _n:int
					_maxVal:Number;
        public function BMPWaveGraph(width:uint = 512, height:uint = 211, foregroundColor:uint = 0xd7f7ff, backgroundColor:uint = 0x3CD8FF):void{
            _w = width;
            //the height should be odd, or you will over flow... this isn't a concern in as3, as the player handles this automatically, so you won't get errors if you remove it.
            //I just wanted to keep it there for myself...
            if (height & 1) {
                //if odd do something
            }else {
                height += 1; //I know I should't have written it like this, but w/e it's better/faster than if(height%2==0){height+=1}
            }
            _h = height;
            _a = (_h / 2);
            _offset = (_h / 2);
            _wc = foregroundColor;
            _sc = backgroundColor;
            _sampleRect = new Rectangle(0, 0, 1, 0);
            super(new BitmapData(_w, _h, false, _sc));
            super.bitmapData.fillRect(new Rectangle(0, _h/2, _w, _h/2), _wc);
        }
        public function drawGraph(valsVect:Vector.<Number>):void {
            _N = valsVect.length;
			//limit the display to the first _w elements, MAX
            if (_N>_w){
                _N = _w;
            }
            ba.position = 0;
            super.bitmapData.lock();
            super.bitmapData.fillRect(super.bitmapData.rect,_sc); 
            for (_n = 0; _n <= _N; ++_n) {
                _sn = valsVect[n];
                _sampleRect.x = _n;//  We could constraine this within bounds but I'm not going to.
                _sampleRect.y = _offset - _a * _sn;
                _sampleRect.height = _h - _sampleRect.y;
                super.bitmapData.fillRect(_sampleRect,_wc);
            }
            super.bitmapData.unlock();
        }
    }

	
}
*/
/*
//Originally written by NME a.k.a Anthony R Pace
package {

    public class BMPAudioGraph extends Sprite {
        public var  bmpHeight:int = stage.stageHeight,//The height of the graph
                    smplHeight:int = 20,//The height of the Rect that will visually represent the position and height of the sample
                    bmp:Bitmap = new Bitmap(new BitmapData(512,bmpHeight,false,0x006600)), //the bitmap that will be used to represent the time domain
                    mic:Microphone = Microphone.getMicrophone(), //the default microphone if available
                    n:int, // the sample number
                    sn:Number,  //sample value at n, or s[n] 
                    bah:ByteArray, //Byte Array  that Holds the sample data
                    A:Number = ((bmpHeight-smplHeight)/2),//'A'  for amplitude factor.  
                    sampleRect:Rectangle = new Rectangle(0,0,1,smplHeight);
        public function sdeh(e:SampleDataEvent):void{ //sample data event handler
            bah = e.data;
            bah.position = 0;
            bmp.bitmapData.lock();
            bmp.bitmapData.fillRect(bmp.bitmapData.rect,0x3CD8FF);
            for (n = 0;n<512;++n){
               sn = bah.readFloat();//reads 4 bytes = 32 bit floating point sample value
               sampleRect.x = n;
               sampleRect.y = A-sn*A;//in this case I am using the Amplitude as not only a factor, but also the offset for the zero line.
               bmp.bitmapData.fillRect(sampleRect,0xd7f7ff);
            }
            bmp.bitmapData.unlock();
        }
        public function BMPAudioGraph() {
            stage.addChild(bmp);//make the bitmap visible on the display list
            mic.rate = 11;// sets the sample frequency to 11025hz
            mic.setSilenceLevel(0);//setting this to 0 makes it so you hear all activity... you should notice noise in the line.
            mic.addEventListener(SampleDataEvent.SAMPLE_DATA,sdeh); // call the sdeh function if the mic hears audio
        }
    }
}
*/