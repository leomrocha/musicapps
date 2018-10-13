package com.components 
{
	import flash.display.Sprite;
	import com.gui_elements.bmp_graphs.BMPAmplitudGraph;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	
	public class FrequencyDisplay extends Sprite 
	{
		private var _w:uint;
		private var _h:uint;
		private var _label:String;
		
		private var _valsVect:Vector.<Number>;
		
		private var _maxVal:Number = 0;
		private var _maxAge:uint = 0;
		private var _secondMax:Number = -100;
		private var _secondAge:uint = 0;
		
		private var _display:BMPAmplitudGraph;
		
		protected var _txtObject:TextField;
		
		protected var _updateMax:Boolean;
		/**
		 * Display for the volueme (maybe later will make it more generic)
		 * 
		 * @param	w = width
		 * @param	h = height
		 * @param	label  = label of the 
		 */
		public function FrequencyDisplay(w:uint = 512 , h:uint = 480, label:String = "Frequency (Hz)", barHeight:Number = 5, updateMax:Boolean = true, maxVal:Number = 0) 
		{
			_w = w;
			_h = h;
			_label = label;
			
			_valsVect = new Vector.<Number>(w);
			
			_display = new BMPAmplitudGraph(_w, _h-20, 1, barHeight);
			_display.x = 0;
			_display.y = 20;
			addChild(_display);
			
			_txtObject = new TextField();
			_txtObject.x = 5;
			_txtObject.y = 1;
			_txtObject.text = _label;
			_txtObject.selectable = false;
			addChild(_txtObject);
			
			_maxVal = maxVal;
			_maxAge = 0;
			_secondMax = -100;
			_secondAge = 0;
			
			_updateMax = updateMax;
		}
		
		public function draw(v:Number):void
		{
			_valsVect.shift();
			_valsVect.push(v);
			if (_updateMax)
			{
				if (v > _maxVal)
					{
						_secondMax = _maxVal;
						_secondAge = _maxAge;
						_maxVal = v;
						_maxAge = 0;
					}
				else if (v > _secondMax)
				{
					_secondMax = v;
					_secondAge = 0;
				}
			}
			_display.drawGraph(_valsVect, _maxVal);
			
			
			_maxAge++;
			_secondAge++;
			if (_maxAge >= _w)
			{
				_maxVal = _secondMax;
				_maxAge = _secondAge;
				_secondMax = -100;
				_secondAge = 0;
			}
			if (_secondAge >= _w)
			{
				_secondMax = -100;
				_secondAge = 0;
			}
		}
		
	}

}