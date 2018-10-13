package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	//import sndanalysis.*;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class TFGameCanvas  extends Sprite
	{
		//frequency range covered in the canvas
		private var fy0:Number = 1000; //frequency of the lowest pixels
		private var fymax:Number = 10; // frequency of the highest pixels
		private var yrange:uint = 400; // height ??
		private var xrange:uint = 600;
		
		//private var Y_SCALE_FACTOR:Number = ( (yrange) / ( Math.log(fy0) - Math.log(fymax) ) );
		private var Y_SCALE_FACTOR:Number = ( yrange / ( fy0 - fymax ) );
		
		private var newMeasurePos:uint = xrange * 0.5;
		
	    //private var spect:SpectrumAnalyzer; 
		private var msecpp:Number = 0.033; // msec per pixel (speed)
		private var ppmsec:Number = 30; // pixels per msec
		private static const XSPEED:Number = -2.0;

		private var tx0:Number; //leftmost pixel time equivalence
		private var txmax:Number;// rigtest "     "
		private var txrange:Number = 1000* (msecpp * xrange);
		private var tstart:Date;
		
		private var MIN_FREQ:Number = 28.0; //minimum acceptable frequency// as 6 string bass is 30.868Hz, I do something to even include it
		
		private var tonesVec:Vector.<ToneRect>;
		private var measuresVect:Vector.<FreqPoint>;

		private var measures:uint = 0 ; // total number of frequency measures
		private var score:uint = 0; // total number of measures that touch a ToneRect;
		
		//private var gameTimer:Timer;
		
		private var background:Shape;

		public function TFGameCanvas( tonesLevel:Vector.<Note>)
		{
			tonesVec = tones2tonesRect(tonesLevel);
			//draw background, to be sure about the dimensions!!
			background = new Shape();
			background.graphics.beginFill(0xAAAAAA, 0.8); 
			background.graphics.drawRect(0,0, xrange, yrange);
			background.graphics.endFill();
			addChild(background);

			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		}
		
		public function start():void
		{
			//start timers and all that
			tstart = new Date();
		}
		
		public function pause():void
		{
		//TODO	
		}
		
		public function stop():void
		{
			//stop timers and all that
			
			//TODO
			
		}
		
		
		// set the new level
		public function set level( newlevel:Vector.<Note>):void 
		{
			clearAll();
			tonesVec = tones2tonesRect(newlevel);
			//container for new points
			measuresVect = new Vector.<FreqPoint>();
						
			for each( var t:ToneRect in tonesVec )
			{
				
				addChild(t);
				//calculate positions
				t.setPos(time2x(t.time), freq2y(t.freq));
				//trace(time2x(t.time), freq2y(t.freq), t.time, t.freq);
			}
			tstart = new Date();
		}
		
		// get the current exercise
		//public function get level():Vector.<ToneRect>
		//{
			//return tonesVec;
		//}
		
		
		//Private helper functions
		private function onAddedToStage(e:Event):void
		{
			redimension();
			clearAll();
			//tonesVec = tones2tonesRect(tonesLevel);
			//container for new points
			measuresVect = new Vector.<FreqPoint>();
						
			for each( var t:ToneRect in tonesVec )
			{
				
				addChild(t);
				//calculate positions
				t.setPos(time2x(t.time), freq2y(t.freq));
				//trace(time2x(t.time), freq2y(t.freq), t.time, t.freq);
			}
			tstart = new Date();
		}
		
		private function tones2tonesRect( notes:Vector.<Note> ) : Vector.<ToneRect>
		{
			var vec:Vector.<ToneRect> = new Vector.<ToneRect>;
			for  each(var no:Note in notes)
			{
				//trace("setting note", no);
				var r:ToneRect = new ToneRect(no);
				vec.push(r);
			}
			
			return vec;
		}
		
		public  function clearAll():void
		{
			//reset all things for restarting the level
			tx0 = 0;
			tstart = new Date();
			measures = 0; 
			score = 0 ;
			//gameTimer = new Timer(50);
			
			for each( var tone:ToneRect in tonesVec)
			{
				if(tone.parent != null)
					{
						removeChild(tone);
					}
			}
			for each ( var p:FreqPoint in measuresVect)
			{
				removeChild(p);
			}
			tonesVec = new Vector.<ToneRect>;
			measuresVect = new Vector.<FreqPoint>;
		}
		
		private function redimension():void
		{
			//get current coordinates and dimensions
			//redimension all children
		}
		
		//private function updateScreen(e:Event):void
		public function updateScreen(newFreq:Number):void
		{	var now:Date = new Date();
			var currF0:Number = newFreq;
			var currT:Number = now.getMilliseconds() - tstart.getMilliseconds();
			var np:FreqPoint = new FreqPoint( currF0 , currT);
			
			measures++;
			
			if (currF0>MIN_FREQ)
			{
				np.setPos(250, freq2y(currF0));
				measuresVect.push(np);
				addChild(np);
				
				var hit:Boolean = false;
				for each( var t:ToneRect in tonesVec )
				{
					t.updateX(XSPEED);
					//check for avoiding repainting things not in the screen
					if (t.parent !=null && t.x < 0 )
					{
						removeChild(t);
					}else if (t.parent ==null && t.x > 0 && t.x < xrange)
					{
						addChild(t);
					}
					
					if ( !hit && t.x >0 && t.x< xrange && np.hitTestObject(t) ) //TODO implement more efficient thing here to compare only with 
					{
						t.highlight();
						score++;
						hit = true;
					}
				}	
			}else {
				for each( var t1:ToneRect in tonesVec )
				{
					t1.updateX(XSPEED);
				}
			}
			
			for each ( var p:FreqPoint in measuresVect)
			{
				p.updateX(XSPEED);
			}
		}
		
		private function getXdisplacement( prevTime:Date, currTime:Date):Number
		{
			var Dt:Number = currTime.getMilliseconds() - prevTime.getMilliseconds();
			//TODO calculate somehow the msecpp
			return Dt*msecpp;
		}
		
		private function freq2y(f:Number):Number
		{
			var yf:Number;
			//yf = height - Math.log( (f - fymax) );
			//yf = yrange - ( Math.log(f) * Y_SCALE_FACTOR ) ;
			yf = yrange - ( f * Y_SCALE_FACTOR ) ;
			//yf = height - ( f * ( height / (fy0 - fymax) ) ) ;
			//trace(width, height, f, "yf= ", yf);
			//trace("bounds = ", this.getBounds(this));
			//trace(yf, f, Math.log(f), Y_SCALE_FACTOR);
			return yf;
		}
		
		private function time2x(t:Number):Number
		{
			var tx:Number;
			//tx = t* msecpp;
			tx = (t - tx0) * (xrange / txrange);
			//trace(tx, t, tx0, xrange, txrange);
			return tx;
		}

	}
	
}