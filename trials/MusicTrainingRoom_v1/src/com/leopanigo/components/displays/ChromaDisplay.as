package com.leopanigo.components.displays 
{
	import com.leopanigo.components.displays.bmp_displays.BMPIntensityGraph;
	import flash.display.Sprite;
	import flash.events.TextEvent;
	import flash.text.TextField;

	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class ChromaDisplay extends Sprite
	{
		private var _w:uint;
		private var _h:uint;
		private var _label:String;
		
		private var _maxVal:Number = 0;
		//private var _globalMax:Number = -100;
		//private var _globalAge:uint = 0;
		//private var _secondMax:Number = -100;
		//private var _secondAge:uint = 0;
		
		private var _display:Vector.<BMPIntensityGraph>;
		private var chromaHist:Vector.<Vector.<Number>>;
		
		protected var _txtObject:TextField;
		private var _labels:Vector.<TextField>;
		
		public static const noteChromaNamePosMap:Vector.<String> = new <String>["C", "C#", "D", "D#", "E",
																	 "F", "F#", "G", "G#", "A",
																	 "A#", "B" ]; 
		
		/**
		 * Display for the volueme (maybe later will make it more generic)
		 * 
		 * @param	w = width
		 * @param	h = height
		 * @param	label  = label of the 
		 * @param	globalMax = if the max vamue should be updated for what is on display at the moment (or will keep the max as the global maximum found up to that point)
		 */		
		public function ChromaDisplay(w:uint = 512 , h:uint = 480, label:String = "Chromagram") 
		{
			_w = w;
			_h = h;
			_label = label;
			
			_display = new Vector.<BMPIntensityGraph>;
			_labels = new Vector.<TextField>;
			
			chromaHist = new Vector.<Vector.<Number>>();
			
			var ypos:Number = 20;
			var ystep:Number = (_h - 20) /12;
			for ( var i:uint = 0; i < 12; i++)
			{
				var disp:BMPIntensityGraph = new BMPIntensityGraph(_w-20, ystep-2, 1);
				disp.x = 20;
				disp.y = ypos;
				_display.push(disp);
				addChild(disp);
				
				var ltf:TextField = new TextField();
				ltf.x = 1;
				ltf.y = ypos;
				ltf.maxChars = 2;
				ltf.text = noteChromaNamePosMap[i];
				_labels.push(ltf);
				addChild(ltf);
				
				var ch:Vector.<Number> = new Vector.<Number>(_w - 20);
				chromaHist.push(ch);
				
				ypos += ystep;
				
			}
			
			_txtObject = new TextField();
			_txtObject.x = 5;
			_txtObject.y = 1;
			_txtObject.text = _label;
			_txtObject.selectable = false;
			addChild(_txtObject);
			
			//_globalMax = -100;
			//_globalAge = 0;
			//_secondMax = -100;
			//_secondAge = 0;
			
		}
		
		public function draw(valsVect:Vector.<Number>):void
		{
			var i:uint;
			var tmax:Number = -10000;
			for (i = 0; i < valsVect.length; i++)
			{
				if (valsVect[i] > tmax)
				{
					tmax = valsVect[i] ;
				}
			}
			//if (tmax > _globalMax)
				//{
					//_secondMax = _globalMax;
					//_secondAge = _globalAge;
					//_globalMax = tmax;
					//_globalAge = 0;
				//}
			//else if (tmax > _secondMax)
			//{
				//_secondMax = tmax;
				//_secondAge = 0;
			//}
				
			for (i = 0; i < valsVect.length; i++)
			{
				if (i >= 12)
				{
					trace("ERROR  chromavector out of bounds!!!!!!");
				}
				
				chromaHist[i].shift();
				//trace("values to chroma: ", i, tmax, valsVect[i], valsVect[i]/tmax);
				chromaHist[i].push(valsVect[i]/tmax); //normalize to 1 the value...one never knows what arrives
				_display[i].drawGraph(chromaHist[i]);
			}
			
			//_globalAge++;
			//_secondAge++;
			//if (_globalAge > _w)
			//{
				//_globalMax = _secondMax;
				//_globalAge = _secondAge;
				//_secondMax = -100;
				//_secondAge = 0;
			//}
			//if (_secondAge > _w)
			//{
				//_secondMax = -100;
				//_secondAge = 0;
			//}
		}
		
	}

}