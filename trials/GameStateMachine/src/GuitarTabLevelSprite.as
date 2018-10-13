package 
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class GuitarTabLevelSprite extends LevelSprite 
	{
		//protected var _centsTolerance:Number; //cents tolerance for comparison to check if note was well played
		protected var noteMapper:NoteMapper;
		
		public function  GuitarTabLevelSprite(bpm:uint, notes:Vector.<GuitarNoteRect>, 
												denominator:uint = NoteSymbol.NEGRA, 
												centsTolerance:Number = 30)
		{
			noteMapper = new NoteMapper();
			_centsTolerance = centsTolerance;
			super(bpm, notes as Vector.<NoteRect>, denominator);
			trace("notes check ", _notesVect, notes);
			//I am copying cause if not it makes problems!!!
			_notesVect = new Vector.<NoteRect>;
			for each( var n:GuitarNoteRect in notes)
			{
				trace("n ", n);
				_notesVect.push(n as NoteRect);
			}
			//_notesVect = notes;// as Vector.<NoteRect>;
			trace("notes check ",_notesVect, notes);

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
			//speed
			tickspp = Number(nSec) / (Number(widthScreen) * _tickTime);
			tickWidth = tickspp * widthScreen;
			zeroTickX = widthScreen * 0.2;//current time vertical line
			//reset level
			//trace("init level sprite");
			resetLevel();
			
		}
		
		public override function update(freq:Number):void
		{
			trace("updating level");
			trace("notes vect", _notesVect, _notesVect.length);
			noteMapper.updateFreq(freq);
			var hit:Boolean = false;
			var remainingCount:uint = 0; //number of remaining notes to be played ->for auto-stop
			for each( var t:NoteRect in _notesVect)
			{
				trace("updating x: ",t, t.x, t.y);
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
				trace( noteMapper.octave, t.octave , noteMapper.currNote , t.noteName);
				if (!hit && t.x > 0  && t.x < widthScreen 
						&& (t.x <= zeroTickX && (t.x + t.duration / tickspp) >= zeroTickX )//actual hit test
						&& noteMapper.octave == t.octave && noteMapper.currNote == t.noteName  //actual testing for correct freq
						&& noteMapper.currErrorCents <= _centsTolerance //to make sure you are in a good range
						) //TODO make this a test not hardcoded
				{

					t.highlight();
					_scoreCount++;
					hit = true;
				}
			}		
			if (remainingCount <= 0)
			{
				stop();//game is over, stop it
			}
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
			background.graphics.beginFill(0x995511, 0.5); 
			background.graphics.drawRect(0,0, widthScreen, heightScreen);
			background.graphics.endFill();
			addChild(background);
			//TODO redimension and relocate all the child elements
			repositionChildren();
		}
		protected override function drawReferences():void
		{
			//horzontal, frequency references
			for (var i:uint=1; i <= 6; i++ )
			{	
				//draw line
				var yf:Number = i * heightScreen/7.0;
				var nl:Shape = new Shape();
				nl.graphics.lineStyle(1, 0x0A0A0A, .5);
				nl.graphics.moveTo(0, yf);
				nl.graphics.lineTo(widthScreen, yf);
				addChild(nl);
				freqLines.push(nl);//keep reference for later modifications
				var tf:TextField = new TextField();
				var txtformat:TextFormat = new TextFormat();
				//txtformat.color = 0xAAAA00;
				txtformat.size =30;
				txtformat.align = "left";
				tf.text = i.toString()+ "# Cord";
				tf.x = 5;
				tf.y = yf -20;
				tf.setTextFormat(txtformat);
				freqLinesLegend.push(tf);
				addChild(tf);
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
		
		protected override function repositionChildren():void
		{
			var tminFreq:Number = 1000000;
			var tmaxFreq:Number = -100000;
			var gt:GuitarNoteRect;
			var ystep:Number = heightScreen / 7.0;
			for each(var t:NoteRect in notesVect)
			{
				gt = t as GuitarNoteRect;
				var c:uint = gt.cord;
				gt.redraw(tick2x(gt.tick0) + zeroTickX, (c * ystep) - (ystep/4.0),  gt.duration / tickspp, ystep / 2.0 ); //TODO correct height positioning and 
				trace("note pos: ", tick2x(gt.tick0) + zeroTickX, c * ystep,  gt.duration / tickspp, ystep / 2.0 );
			}
		}
		
	
	}
	
}