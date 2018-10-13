package com.components 
{
	import flash.display.Sprite;
	import com.gui_elements.bmp_graphs.BMPAmplitudGraph;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	
	public class VolumeDisplay extends Sprite 
	{
		private var _w:uint;
		private var _h:uint;
		private var _label:String;
		
		private var _maxVal:Number = 0;
		private var _globalMax:Boolean;
		
		private var _display:BMPAmplitudGraph;
		
		protected var _txtObject:TextField;
		
		/**
		 * Display for the volueme (maybe later will make it more generic)
		 * 
		 * @param	w = width
		 * @param	h = height
		 * @param	label  = label of the 
		 * @param	globalMax = if the max vamue should be updated for what is on display at the moment (or will keep the max as the global maximum found up to that point)
		 */
		public function VolumeDisplay(w:uint = 512 , h:uint = 60, label:String = "Volume", globalMax:Boolean = true) 
		{
			_w = w;
			_h = h;
			_label = label;
			_globalMax = globalMax;
			
			_display = new BMPAmplitudGraph(_w, _h-20, 1);
			_display.x = 0;
			_display.y = 20;
			addChild(_display);
			
			_txtObject = new TextField();
			_txtObject.x = 5;
			_txtObject.y = 1;
			_txtObject.text = _label;
			_txtObject.selectable = false;
			addChild(_txtObject);
			
		}
		
		public function draw(valsVect:Vector.<Number>):void
		{
			//TODO all this is useful for other kind of displays not for the volume that goes between 0 and 1
			//var tmax:Number = Math.max(valsVect);
			//if (_globalMax)
			//{
				//if( tmax >_maxVal) 
				//{
					//_maxVal = tmax;
				//}
			//}
			//else {// !_globalMax, i.e. the max shown will be 
				//_maxVal = tmax;
			//}
			_display.drawGraph(valsVect);
			
		}
		
		public function get updateMax():Boolean 
		{
			return _globalMax;
		}
		
		public function set updateMax(value:Boolean):void 
		{
			_globalMax = value;
		}
		
	}

}