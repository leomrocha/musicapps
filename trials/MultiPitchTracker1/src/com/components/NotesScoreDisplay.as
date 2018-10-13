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
	public class NotesScoreDisplay extends Sprite
	{
		private var _w:uint;
		private var _h:uint;
		private var _label:String;
		
		private var _maxVal:Number = 0;
		
		private var _display:Vector.<BMPNoteGraph>;
		private var scoreHist:Vector.<Vector.<Number>>; //keeps the history of the shown values (on screen)
		private var _history:uint;
		private var valuesHist:Vector.<Vector.<Number>>; //keeps the latest values (for calculating scores)
		
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
		 * @param	history = if the max vamue should be updated for what is on display at the moment (or will keep the max as the global maximum found up to that point)
		 */		
		public function NotesScoreDisplay(w:uint = 512 , h:uint = 480, label:String = "Notes Score", history:uint = 20) 
		{
			_w = w;
			_h = h;
			_label = label;
			_history = history;
			
			_display = new Vector.<BMPNoteGraph>;
			_labels = new Vector.<TextField>;
			
			scoreHist = new Vector.<Vector.<Number>>();
			valuesHist = new Vector.<Vector.<Number>>();
			
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
				scoreHist.push(ch);
				var vh:Vector.<Number> = new Vector.<Number>(_history);// (_history);
				//for (var j:uint = 0; j < _history; j++) vh.push(0);
				valuesHist.push(vh);
				
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
			
			var features:Vector.<Number> = new Vector.<Number>(valsVect.length);
			//get max value of this input
			var maxV:Number = -100;
			for each( var vv:Number in valsVect)
			{
				if( vv > maxV)
					{
						maxV = vv;
					}
			}
			//create logarithmic feature vector
			for (var i:uint = 0; i < valsVect.length; i++)
			{
				if (i >= 12)
				{
					trace("ERROR  chromavector out of bounds!!!!!!");
				}
				//save history for feature calculation				
				valuesHist[i].shift();
				valuesHist[i].push(valsVect[i] / maxV); //normalize to 1 the input (compared with the 12 notes inputs)
				var f:Number = 0;
				//var fcount:uint = 0;
				//calculate feature
				for (var j:uint = 0 ; j < valuesHist[i].length; j++ )
				{
					f +=   valuesHist[i][j]/(valuesHist[i].length - j) ;//pondered sum; // Math.log(1 + valuesHist[i][j]); //
					//fcount++;
				}
				//f = f / fcount;
				scoreHist[i].shift();
				scoreHist[i].push(f);
				//plot results to screen
				_display[i].drawGraph(scoreHist[i]);
			}
		}
	}

}