package com.gui_elements.bmp_graphs 
{
	import com.music_concepts.Note;
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
	public class BMPNoteDisplay extends Bitmap
	{ // from http://wonderfl.net/c/heMs
        private var _w:uint,//width  with a rate of 11 this should be 512
                    _h:uint,//should be an odd number.
                    _bgc:uint,//background colour
                    _offset:uint,//offset... just think of a DC-Offset to get the idea
                    _sampleRect:Rectangle,//this is the line that we will draw per x
                    _N:int, //the max number of samples to draw
                    _sn:Number,//the current value of the sample at n  or s[n]
                    _n:Number,
					_rectWidth:Number,
					_step:Number,
					_maxVal:Number = 1.0;
        public function BMPNoteDisplay(width:uint = 512, height:uint = 211, backgroundColour:uint = 0x000000):void{
			_w = width;
            _h = height;
			_step = _h / 12; //number of notes are 12, so 12
            _offset = _h;
            _bgc = backgroundColour;
			_rectWidth = 1;
			
            _sampleRect = new Rectangle(0, 0, _rectWidth, _step);
			
            super(new BitmapData(_w, _h, false, _bgc));
        }
		
        public function drawGraph(notesVect:Vector.<Note>):void {
			//trace("valsVect", valsVect);
			//if (maxVal != 0 )
			//{
				//_maxVal = maxVal;
				//_a = _h / maxVal;
			//}
            _N = notesVect.length;
			//limit the display to the first _w elements, MAX, this is for the ease of mind!!
            if (_N > _w)
			{
                _N = _w;
				_rectWidth = 1;
            }else if (_N < _w)
			{
				_rectWidth = Number(_w) / Number(_N);
			}else
			{
				_rectWidth = 1;
			}
			_sampleRect = new Rectangle(0, 0, _rectWidth, _step);
            super.bitmapData.lock();
            super.bitmapData.fillRect(super.bitmapData.rect, _bgc);
			_n = 0;
			for each (var note:Note in notesVect)
			{
				if (note)
				{
					_sampleRect.x = _n;// We could constrain this within bounds but I'm not going to.
					_sampleRect.y = _offset - ( (Note.NOTES_NAMES_POS_MAP[note.name] +1)* _step);//_offset - _a * _sn / _maxVal;
					super.bitmapData.fillRect(_sampleRect, note.colour);
				}
				_n += _rectWidth;
			}
            super.bitmapData.unlock();
        }
    }

}