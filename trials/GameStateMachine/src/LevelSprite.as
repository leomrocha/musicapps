package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	//This class is the generic level, for more accurate representations in graphics, 
	//   a subclass with specific things (such as a TAB or music sheet) should be implemented
	public class LevelSprite extends GameStateSprite 
	{
		//protected var spect:SpectrumAnalyzer;//TODO this should be somewhere else!!!

		static public const LEVEL_UPDATE_SCREEN_EVENT:String = "LevelUpdateScreenEvent";//TODO this should be somewhere ELSE!!
		static public const MIN_FREQ:Number = 28.0;// 6 string bass minimum frequency is a bit greater than 30Hz
		//frequency range covered in the canvas -> for screen representation
		protected var fy0:Number; //frequency of the lowest pixels
		protected var fymax:Number; // frequency of the highest pixels
		protected var zeroTickX:Number = 200; // x coordinate for equivalence with current moment (initially zero ticks)
		//private var Y_SCALE_FACTOR:Number = ( (yrange) / ( Math.log(fy0) - Math.log(fymax) ) );
		protected var Y_SCALE_FACTOR:Number;
		
		
		protected var tickspp:Number; //speed number of ticks to move one pixel to the left
		protected var xMsecSpeed:Number; // speed in msec for every update
		//protected var xPixelSpeed:Number; // Speed in pixels per update ->should be recalculated in each update
		protected var pixelsPerTick:Number; // Number of pixels that should move to the left per tick

		protected var background:Shape;
		//////////////////////////////////////////////////////
		/// Current game status
		//////////////////////////////////////////////////////
		//protected var scorePercentual:Number; //  (scoreCount / measuresCount)/100.0 
		//protected var scoreHits:uint; //current number of points that actually hit the correct element
		//protected var pointsCount:uint;//current count of measures (points)
		protected var _measuresCount:uint = 0 ; // total number of frequency measures
		protected var _scoreCount:uint = 0; // total number of measures that touch a ToneRect;
		
		//tempo signature
		protected var _denominator:uint; //is a NoteSymbol.XXXX where XXXX is Redonda, blanca ... etc
		//protected var numerator:uint; //not used
		//tempo
		protected var _bpm:uint; //Beats Per Minute
		protected var _centsTolerance:Number = 50; // tolerance for error in the frequency, in cents
		//protected var _maxCentsError:Number = 10;//in Cents, maximum acceptable error for a detection
		
		protected var playing:Boolean;
		protected var paused:Boolean;
		protected var stopped:Boolean;
		
		protected var tickCount:uint; //number of ticks since beggining (start playing)
		protected var _tickTime:Number; // time in milliseconds of one tick = 0.3125*denominator/bpm = 1/((bpm/60)/(NoteSymbol.SEMI_FUSA/denominator))
		////////other elements in the canvas////////////////
		
		//exercise-level to accomplish
		protected var _notesVect:Vector.<NoteRect>; //the actual level
		protected var measuresVect:Vector.<MeasurePoint>;//all played frequencies at the moment, this vector
		
		//timer
		//protected var tickTimer:Timer;
		// number of seconds that the screen takes to pass one time:
		protected var nSec:uint = 20; //TODO something better
		protected var tickWidth:uint;
		
		//lines for reference on frequency
		protected var freqLines:Vector.<Shape>;
		protected var freqLinesLegend:Vector.<TextField>;
		
		protected var isPractice:Boolean = false;
		//bpm beats per minute
		// notes: the notes to play
		//denominator by default is a black (negra)
		public function LevelSprite(bpm:uint, notes:Vector.<NoteRect>, denominator:uint = NoteSymbol.NEGRA) 
		{
			//trace("level sprite constructor");
			_bpm = bpm;
			_denominator = denominator;
			_notesVect = notes;
			if(_notesVect == null || _notesVect.length <= 0 ) isPractice = true; // -> this is to avoid stopping the practice at begining due to the absence of things to sing
			playing = false;
			paused = false;
			stopped = true;
			tickCount = 0 ;
			_tickTime = 0.3125 * Number(_denominator) / Number(_bpm);
			//spect = new SpectrumAnalyzer();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		protected override function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//trace("init of the LevelSprite class");
			background = new Shape();
			
			measuresVect = new Vector.<MeasurePoint>();
			freqLines = new Vector.<Shape>();
			freqLinesLegend = new Vector.<TextField>();
			
			widthScreen = parent.width;
			heightScreen = parent.height * 0.8;
			redimension(widthScreen, heightScreen);
			//x speed
			pixelsPerTick = - widthScreen * _tickTime / nSec; //  widthScreen / (20 / _tickTime); // 20 seconds all the screen			
			//speed & timers
			tickspp = Number(nSec) / (Number(widthScreen) * _tickTime);
			//trace("tickspp = ", tickspp, nSec, widthScreen, _tickTime );
			//tickTimer = new Timer(_tickTime * 1000);
			//tickTimer.addEventListener(TimerEvent.TIMER, update);
			//
			tickWidth = tickspp * widthScreen;
			zeroTickX = widthScreen * 0.2;//current time vertical line
			if (isPractice) zeroTickX = widthScreen * 0.9;
			//reset level
			//trace("init level sprite");
			resetLevel();
			
		}
		
		public function redraw():void
		{
			redimension(widthScreen, heightScreen);
			
		}
		
		public override function redimension(w:uint, h:uint):void
		{
			//TODO all the calculations this is a virtual method only
			widthScreen = w;
			heightScreen = h;
			//trace(width, widthScreen, height, heightScreen);
			//Dimensions:
			if (background.parent)
			{
				removeChild(background);
			}
			background = new Shape();
			background.graphics.beginFill(0x115599, 0.5); 
			background.graphics.drawRect(0,0, widthScreen, heightScreen);
			background.graphics.endFill();
			addChild(background);
			//TODO redimension all the child elements
			repositionChildren();
		}
		
		public function start(e:MouseEvent = null):void
		{
			if (paused)
			{
				paused = false;
				
			}else if (stopped)
			{
				stopped = false;
				resetLevel();
			}
			//tickTimer.start();
			//spect.start();

		}
		
		public function pause(e:MouseEvent = null):void
		{
			//tickTimer.stop();
			//spect.stop();
		}
		
		public function stop(e:Event = null):void
		{
			//if (tickTimer.running)
			//{
				//tickTimer.stop();
				//spect.stop();
				//
			//}
		}
		public function resetLevel(e:MouseEvent = null):void
		{
			//tickTimer.reset();
			//counts to zero
			//states to original
			playing = false;
			paused = false;
			stopped = true;
			tickCount = 0 ;
			_tickTime = 0.3125 * Number(_denominator) / Number(_bpm);
			_scoreCount = 0;
			//scorePercentual = 0;
			_measuresCount = 0;
			//remove all points
			for each( var point:MeasurePoint in measuresVect)
			{
				if (point.parent)
				{
					removeChild(point);
				}
			}
			measuresVect = new Vector.<MeasurePoint>();
			//recalculate all the notes coordinates from the level
			repositionChildren();
			drawReferences();
			
		}

		public function update(freq:Number):void
		{
			//trace("update screen");
			//calculate x speed!!!
			//create a new FreqPoint with input freq
			// freq:Number, tick0:Number, hzrange:Number, hzpp:Number , tickspp:Number
			//try to get the frequency:
			var np:MeasurePoint = null;
			//var freq :Number = spect.freq;
			if (freq > MIN_FREQ&& freq > fy0 && freq < fymax) // Filter everything that is not in the exercise frequency range!!
			{
				//trace("freq detected: ", freq);
				np = new MeasurePoint(freq, tickCount);
				_measuresCount++;
				np.redraw(zeroTickX, hz2y(freq));
				addChild(np);
				measuresVect.push(np);
			}
			for each( var point:MeasurePoint in measuresVect)
			{
				//TODO update point.x
				point.x +=  pixelsPerTick;
				if (point.parent != null && point.x < 0)//NOTE test for inclusion from the right does not matters cause points are created already in the middle
				{
					removeChild(point);
				}
			}
		
			var hit:Boolean = false;
			var remainingCount:uint = 0; //number of remaining notes to be played ->for auto-stop
			for each( var t:NoteRect in _notesVect)
			{
				t.x +=  pixelsPerTick;
				//check for avoiding repainting things not in the screen
				if (t.parent !=null && (t.x < 0|| t.x > widthScreen ) )
				{
					removeChild(t);
				}else if (t.parent ==null && t.x > 0 && t.x < widthScreen)
				{
					addChild(t);
				}
				if (t.x > 0) remainingCount++; //update count
				if (np!=null && !hit && t.x > 0  && t.x< widthScreen && np.hitTestObject(t) ) //TODO implement more efficient thing here to compare only with the current object
				{
					t.highlight();
					_scoreCount++;
					hit = true;
				}
			}		
			//dispatchEvent(new Event(LEVEL_UPDATE_SCREEN_EVENT));
			if (remainingCount <= 0 && !isPractice)
			{
				stop();//game is over, stop it
			}
		}
		
		protected function drawReferences():void
		{
			var i:uint = 0; //index count
			//horzontal, frequency references
			for each(var f:Number in NoteMapper.NOTES_FREQUENCIES)
			{	
				if (f < fymax && f> fy0)
				{
					//draw line
					var yf:Number = hz2y(f);
					var nl:Shape = new Shape();
					nl.graphics.lineStyle(1, 0x0A0A0A, .5);
					nl.graphics.moveTo(0, yf);
					nl.graphics.lineTo(widthScreen, yf);
					addChild(nl);
					freqLines.push(nl);//keep reference for later modifications
					//Add a legend
					var tf:TextField = new TextField();
					tf.text = NoteMapper.NOTES_NAMES[i] + ": "+ f.toString() + " Hz";
					tf.x = 5;
					tf.y = yf-10;
					freqLinesLegend.push(tf);
					addChild(tf);
				}
				i++;
			}
			//vertical, time references
			var xl:Number = 0;
			for ( i = 1; i < nSec; i++)
			{
				xl = i * (widthScreen / nSec);
				var nl:Shape = new Shape();
				nl.graphics.lineStyle(0.8, 0x888888, .3);
				nl.graphics.moveTo(xl, 0);
				nl.graphics.lineTo(xl, heightScreen);
				addChild(nl);
				freqLines.push(nl);//keep reference for later modifications
			}
			//ADD current tme reference line
			var rl:Shape = new Shape();
			rl.graphics.lineStyle(2, 0x00FF00, .8);
			rl.graphics.moveTo(zeroTickX, 0);
			rl.graphics.lineTo(zeroTickX, heightScreen);
			addChild(rl);
			freqLines.push(rl);//keep reference for later modifications
		}
		
		protected function repositionChildren():void
		{
			var tminFreq:Number = 1000000;
			var tmaxFreq:Number = -100000;
			for each(var t:NoteRect in _notesVect)
			{
				var f:Number = t.freq;
				if ( f < tminFreq) tminFreq = f;
				if (f > tmaxFreq) tmaxFreq = f;
				//calculate hz tolerance from the cents 
				var hztolerance:Number = NoteMapper.cents2hz(f,_centsTolerance);
				//calculate the equivalence in pixels
				var ytolerance:Number = Math.abs(hztolerance * Y_SCALE_FACTOR);
				trace("Width calculations: ", f, hztolerance , ytolerance );
				t.redraw(tick2x(t.tick0)+zeroTickX, hz2y(f)-ytolerance/2, t.duration/tickspp, ytolerance ); //TODO correct height positioning and 
			}
			for each( var point:MeasurePoint in measuresVect)
			{
				point.x = tick2x(point.tick0);
				point.y = hz2y(point.freq);
			}
			//get max and min frequencies
			fy0 = tminFreq - 20; // some extra Hz for it to seem more pleasent to the viewer
			fymax = tmaxFreq + 50; // IDEM
			if (isPractice)//TODO do this more beautiful and useful, the user should be able to setup the interval
			{
				fy0 = 98.0;
				fymax = 440.0;
			}
			var yrange:Number = heightScreen;
			Y_SCALE_FACTOR = ( yrange / ( fy0 - fymax ) ); //negative value
			//Y_SCALE_FACTOR = ( yrange / Math.log( Math.abs(fy0 - fymax) ) ); //negative value
		}
		
		protected function hz2y(f:Number):Number 
		{
			//var ty:Number = heightScreen - ( Math.log(Math.abs(f - fy0)) * Y_SCALE_FACTOR);
			var ty:Number = heightScreen + ( (f - fy0) * Y_SCALE_FACTOR);
			//trace(heightScreen, f, fy0, fymax, Y_SCALE_FACTOR);
			//TODO something better
			return ty;
			
		}
				
		protected function tick2x(tick:Number):Number 
		{
			var tx:Number = zeroTickX + ( (tick - tickCount) / tickspp );
			return tx;
		}
		
		public function get measuresCount():uint 
		{
			return _measuresCount;
		}
		
		public function get scoreCount():uint 
		{
			return _scoreCount;
		}
		
		public function get bpm():uint 
		{
			return _bpm;
		}
		
		public function set bpm(value:uint):void 
		{
			_bpm = value;
			resetLevel();
		}
		
		public function get centsTolerance():Number 
		{
			return _centsTolerance;
		}
		
		public function set centsTolerance(value:Number):void 
		{
			_centsTolerance = value;
			resetLevel();
		}
		
		public function get tickTime():Number 
		{
			return _tickTime;
		}
		
		public function get notesVect():Vector.<NoteRect> 
		{
			return _notesVect;
		}
		
		public function get denominator():uint 
		{
			return _denominator;
		}
		
	}

}