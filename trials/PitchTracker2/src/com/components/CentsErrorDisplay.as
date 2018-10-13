package com.components 
{

	import adobe.utils.CustomActions;
	import com.gui_elements.VerticalScale;
	import com.gui_elements.VisualMetronomeMarks;
	import com.music_concepts.Note;
	import flash.display.Shape;
	import flash.display.Sprite;
	import com.gui_elements.bmp_graphs.BMPIntensityGraph;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	
	public class CentsErrorDisplay extends Sprite 
	{
		private var _w:uint;
		private var _h:uint;
		private var _label:String;
		
		//private var _currentNotesVect:Vector.<Note>; //current notes being displayed
		private var _valsVect:Vector.<Number>; //current values to show, normalized to 1
		private var _coloursVect:Vector.<uint>; //colours to show, for each element in the previousvector: MUST have the same amount of elements
		
		private var metronomeDisplay:VisualMetronomeMarks;
		
		//Limits in frequency, set by owner of the class
		private var _MIN_FREQ:Number;
		private var _MAX_FREQ:Number;
		
		private const MAX_CENTS:Number = 50;
		//Aditional display information
		private var _currErrorCentsTxt:TextField;
		
		private var _showErrorCents:Boolean;
		
		//for knowing the samples to show on screen
		private var _currentSamplesShown:uint;
		
		//maximum acceptable error in cents
		private var _maxErrorCents:Number;

		//colouring
		private var _okColour:uint, _errColour:uint;
		
		//actual display of the data
		private var _display:BMPIntensityGraph;
		private var _freqBar:VerticalScale;
		
		protected var _txtObject:TextField;
		
		/**
		 * Display for the volueme (maybe later will make it more generic)
		 * 
		 * @param	w = width
		 * @param	h = height
		 * @param	
		 */
		public function CentsErrorDisplay(w:uint = 640 , h:uint = 480, 
													maxErrorCents:Number = 20, //is big cause is for singing, is not an instrument tuned
													label:String = "Error (Cents)",
													pointWidth:Number = 2, pointHeight:Number = 4,
													okColour:uint = 0x00FF00, errorColour:uint = 0xFF0000,
													backgroundColour:uint = 0x050505,
													showErrorCents:Boolean = true)
		{
			_w = w;
			_h = h;
			_label = label;
			_maxErrorCents = maxErrorCents;
			
			_okColour = okColour;
			_errColour = errorColour;
			
			_showErrorCents = showErrorCents;			
			
			//amplitud display
			_display = new BMPIntensityGraph(_w - 30, _h);
			_display.x = 25;
			_display.y = 0;
			_display.alpha = 0.8;
			addChild(_display);
			//scales
			_freqBar = new VerticalScale(20, _h, 50, -50 , 3);
			_freqBar.x = 5;
			_freqBar.y = 0;
			addChild(_freqBar);
			
			//error zones, separeed by a line
			var line:Shape = new Shape;
			line.graphics.lineStyle( 1, 0x502250 );
			var ypos:Number = (_h / 2 );
			var ystep:Number = ( (_h) * (_maxErrorCents / (MAX_CENTS *2 +1))  ) ;
			line.graphics.moveTo(25, ypos);
			line.graphics.lineTo(_w - 5, ypos);
			ypos = (_h / 2) - ystep;
			line.graphics.moveTo(25, ypos);
			line.graphics.lineTo(_w - 5, ypos);
			ypos = (_h / 2) + ystep;
			line.graphics.moveTo(25, ypos);
			line.graphics.lineTo(_w - 5, ypos);
			
			addChild(line);
			//naming the frequency display
			//_txtObject = new TextField();
			//_txtObject.x = 20;
			//_txtObject.y = 1;
			//_txtObject.text = _label;
			//_txtObject.textColor = 0xFFFFFF;
			//_txtObject.selectable = false;
			//addChild(_txtObject);
			
			//calculate current 
			_currentSamplesShown = 200;// _w - 30; //WARNING, TODO: this is fixed like this only for the moment, then should be calculated dinamically!!!
			//_currentNotesVect = new Vector.<Note>(_currentSamplesShown); 
			_valsVect = new Vector.<Number>(_currentSamplesShown); 
			_coloursVect = new Vector.<uint>(_currentSamplesShown); 
			
			metronomeDisplay = new VisualMetronomeMarks(_w - 30, _h, _currentSamplesShown);
			metronomeDisplay.x = 25;
			metronomeDisplay.y = 0;
			
			addChild(metronomeDisplay);
			
			//Aditional information
			//Text ->frequency and error information
			if (_showErrorCents)
			{
				_currErrorCentsTxt = new TextField();
				_currErrorCentsTxt.x = 30;
				_currErrorCentsTxt.y = 5; // 20;
				//var format:TextFormat = new TextFormat();
				//format.size = 35;
				//format.textColor = 0xffffff;
				//format.
				//_currErrorCentsTxt.defaultTextFormat = format;
				_currErrorCentsTxt.textColor = 0xFFFF44;
				//currNote.maxChars = 4;
				_currErrorCentsTxt.text = "0000 Cents";
				addChild(_currErrorCentsTxt);
			}

		
		}
		
		
		//public function setPercentageViewInterval(initPercentage:uint, endPercentage:uint):void
		//{
			// //TODO
		//}
		
		//public function setViewSamplesInterval(initSampleNumber:uint, endSampleNumber:uint):void
		//{
			// //TODO
		//}
		//
		//public function setViewTimeInterval(initTime:uint, endTime:uint):void
		//{
			// //TODO
		//}
		public function clear():void
		{
			_valsVect = new Vector.<Number>(_currentSamplesShown); 
			_coloursVect = new Vector.<uint>(_currentSamplesShown);
			metronomeDisplay.clear();
			update(null);
		}
		
		public function showVector( notes:Vector.<Note>, marks:Vector.<Boolean>=null):void
		{
			trace("showVector cents error display");
			for each(var n:Note in notes)
			{
				update(n);
			}
			metronomeDisplay.showVector(marks);
		}
		
		public function update(note:Note, tick:Boolean = false):void
		{
			if (!note) note = new Note(Number.MAX_VALUE, "C", uint.MAX_VALUE, uint.MAX_VALUE);
			//current notes in the display
			//_currentNotesVect.shift();
			//_currentNotesVect.push(note);			

			_valsVect.shift();
			
			if(note.freq > _MIN_FREQ && note.freq < _MAX_FREQ) 
			{
				_valsVect.push(note.errorCents / MAX_CENTS);
				//_valsVect.push(Math.abs(note.errorCents / MAX_CENTS));
				_currErrorCentsTxt.text = note.errorCents.toString().substr(0,4) + " Cents";
			}else
			{
				_valsVect.push(0);
			}
		
			
			
			//check colour for the display according to error policy ->gradual colouring
			var c:uint = _errColour;
			//
			//if (Math.abs(note.errorCents) < _maxErrorCents && note.freq > _MIN_FREQ && note.freq < _MAX_FREQ)
				//{
					//c = _okColour;
				//}
			
			{
				var  proxim:Number;
				if (Math.abs(note.errorCents) < _maxErrorCents)
				{
					proxim = Math.log( 1 + ( (50.0 - Math.abs(note.errorCents) ) / 50.0 ) )/ Math.log(2);
				}
				else
				{
					proxim = Math.log( 1 + ( (50.0 - Math.abs(note.errorCents) ) / 50.0 ) );
				}
				
				
				c = ( uint(0xff * (1 - proxim) ) << 16 ) + ( uint(0xff * (proxim) ) << 8); // RR and GG components
			}
			_coloursVect.shift();
			_coloursVect.push(c);
			
			//draw
			_display.drawGraph(_valsVect, _coloursVect);
			//_freqBar.update(0, MAX_CENTS); //TODO should do it only once instead of every single update time!!
			metronomeDisplay.update(tick);
		}
		
		public function get MIN_FREQ():Number 
		{
			return _MIN_FREQ;
		}
		
		public function set MIN_FREQ(value:Number):void 
		{
			_MIN_FREQ = value;
		}
		
		public function get MAX_FREQ():Number 
		{
			return _MAX_FREQ;
		}
		
		public function set MAX_FREQ(value:Number):void 
		{
			_MAX_FREQ = value;
		}
		
	}
	
}