package com.components 
{
	import com.gui_elements.bmp_graphs.BMPNoteGraph;
	import flash.display.Sprite;
	import flash.events.TextEvent;
	import flash.text.TextField;

	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class ChordDisplay extends Sprite
	{
		private var _w:uint;
		private var _h:uint;
		private var _label:String;
		
		private var _maxVal:Number = 0;
		
		private var _display:Vector.<BMPNoteGraph>;
		private var posHist:Vector.<Vector.<Number>>;
		
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
		public function ChordDisplay(w:uint = 512 , h:uint = 480, label:String = "Chromagram") 
		{
			_w = w;
			_h = h;
			_label = label;
			
			_display = new Vector.<BMPNoteGraph>;
			_labels = new Vector.<TextField>;
			
			posHist = new Vector.<Vector.<Number>>();
			
			var ypos:Number = 20;
			var ystep:Number = (_h - 20) /12;
			for ( var i:uint = 0; i < 12; i++)
			{
				var disp:BMPNoteGraph = new BMPNoteGraph(_w-20, ystep-2, 1);
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
				posHist.push(ch);
				
				ypos += ystep;
				
			}
			
			_txtObject = new TextField();
			_txtObject.x = 5;
			_txtObject.y = 1;
			_txtObject.text = _label;
			_txtObject.selectable = false;
			addChild(_txtObject);
			
		}
		
		public function draw(valsVect:Vector.<Number>):void
		{
			var maxV:Number = -100;
			
			for each( var vv:Number in valsVect)
			{
				if( vv > maxV)
					{
						maxV = vv;
					}
			}
			for (var i:uint = 0; i < valsVect.length; i++)
			{
				if (i >= 12)
				{
					trace("ERROR  chromavector out of bounds!!!!!!");
				}
				
				posHist[i].shift();
				posHist[i].push(valsVect[i]/maxV); //pass the positions to the drawing, is what matters
				_display[i].drawGraph(posHist[i]);
			}
			//var posVect:Vector.<uint>;
			//sort the vector of positions according to the input values comming
			//posVect = bubbleSort(valsVect);
			//
			//for (var i:uint = 0; i < valsVect.length; i++)
			//{
				//if (i >= 12)
				//{
					//trace("ERROR  chromavector out of bounds!!!!!!");
				//}
				//
				//posHist[i].shift();
				//trace("values to chroma: ", i, tmax, valsVect[i], valsVect[i]/tmax);
				//posHist[i].push(posVect[i]); //pass the positions to the drawing, is what matters
				//_display[i].drawGraph(posHist[i]);
			//}
		}
		
		public function bubbleSort(toSort:Vector.<Number>):Vector.<uint>
		{
			var changed:Boolean = false;
			var posVect:Vector.<uint> = new Vector.<uint>;
			var i:uint;
			for (i = 0; i < 12; i++)
			{
				posVect.push(i);
			}
			while (!changed)
			{
				changed = true;
		 
				for (i = 0; i < toSort.length - 1; i++)
				{
					if (toSort[posVect[i]] > toSort[posVect[i + 1]])
					{
						var tmp:int = posVect[i];
						posVect[i] = posVect[i + 1];
						posVect[i + 1] = tmp;
		 
						changed = false;
					}
				}
			}
		 
			return posVect;
		}
		
		final private function shellSort(data:Vector.<Number>):Vector.<uint> //returns an orderd index
		{
			var posVect:Vector.<uint> = new Vector.<uint>;
			var i:uint;
			for (i = 0; i < 12; i++)
			{
				posVect.push(i);
			}
			var n:int = data.length;
			var inc:int = int(n/2 + 0.5);
			while (inc)
			{
				for ( i = inc; i < n; i++)
				{
					var temp:Number = posVect[i];
					var j:int = i;
					while (j >= inc && data[posVect[int(j - inc)]] > data[temp])
					{
						posVect[j] = posVect[int(j - inc)];
						j = int(j - inc);
					}
					posVect[j] = temp
				}
				inc = int(inc / 2.2 + 0.5);
			}
		return posVect;
		}
		
	}

}