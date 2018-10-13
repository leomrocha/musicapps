package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import mx.events.ItemClickEvent;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class NoteRect extends Sprite 
	{
		
		private var w:Number;
		private var h:Number;
		
		private var _instrument:String; // instrument to play when synthetizing sound
		
		private var _tick0:Number; //time at which to play
		private var _freq:Number; // frequency to play
		private var _duration:Number; // duration in ticks of the sound
		//private var midinote:uint;  //note representation
		private var _noteName:String; //name ... stil to decide if A B C D E ... or Do Re Mi Fa Sol La Si
		private var _octave:uint; 
		//
		private var _currentTick:Number;
		//
		private var BACKGROUNDCOLOR:uint =0x000A0A;
		//private var transparency:;
		//private var image:;
		
		private var initialized:Boolean = false;
		private var isHighlighted:Boolean; // changes in color 
		
		private var _writeText:Boolean; //if write text to the image
		private var _txt:String; // something that should be written
		private var _txtField:TextField;
		
		// Sound Synthesis
		private var toneSynthesis:ToneSynthesis;
		//freq: frequency 
		// tick0: initiation time of the sound in ticks
		// note_id: an uint representing if it is a  round, black, white, fuse ... note
		// instrument: for sound synthesys purposes later
		public function NoteRect( freq:Number, tick0:Number, note_id:uint = NoteSymbol.NEGRA,
									instrument:String = ChallengeScreenFactory.INSTRUMENT_GUITAR, 
									writeText:Boolean=false, text:String = "")
		{
			this._writeText = writeText;
			this._txt = text;
			this._tick0 = tick0;
			this._freq = freq;
			this._duration = NoteSymbol.TICK_BASE / note_id; //all timers will be based on the SEMI_FUSA where ticks are used as time reference
			//trace("NoteRect Constructor", freq, tick0, note_id, NoteSymbol.TICK_BASE, _duration)
			this._instrument = instrument;
			toneSynthesis = new ToneSynthesis(freq);
		}
		
		public function highlight():void
		{
			this.graphics.beginFill(0x00AA00, 0.2); 
			this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();
		}
		
		public function redraw(xpos:Number, ypos:Number, wlen:Number, hlen:Number ):void
		{
			
			x = xpos;
			y = ypos;
			w = wlen;
			h = hlen;
			trace("redawing note rect order given: ",x,y,w,h);
			if (stage) privateRedraw();
			else addEventListener(Event.ADDED_TO_STAGE, privateRedraw);
			
		}
		
		private function privateRedraw(e:Event=null):void
		{
			//trace("note rect is redrawing");
			removeEventListener(Event.ADDED_TO_STAGE, privateRedraw);
			this.graphics.beginFill(BACKGROUNDCOLOR, 0.8); 
			this.graphics.lineStyle(0, 0x888080);
			this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();
			if (_writeText)
			{
				var txtformat:TextFormat = new TextFormat();
				txtformat.color = 0xAAAA00;
				txtformat.size =20;
				txtformat.align = "left";
				txtformat.leftMargin = 0;
				txtformat.rightMargin = width;
				//txtformat.font = "Wingdings";
				_txtField = new TextField();
				_txtField.text = _txt;
				_txtField.borderColor = 0xAAAAAA;
				_txtField.border = true;
				//_txtField.wordWrap = true;
				_txtField.y = 0;
				_txtField.x = 0;
				_txtField.width = width;
				_txtField.height = height;;
				_txtField.setTextFormat(txtformat);
				addChild(_txtField);
			}
			addEventListener(MouseEvent.CLICK, onClick);
			initialized = true;
		}
		
		public function play():void
		{
			//plays the sound zith the corresponding frequency and instrument
			//SoundSynthetizer.playMidiNote(midinote, instrument);
			//SoundSynthetizer.playMidiNote(midinote, duration ,instrument);
			toneSynthesis.play();
		}
		
		private function onClick(e:MouseEvent):void
		{
			//trace("NoteRect Clicked");
			play();
		}
		
		public function get duration():Number 
		{
			return _duration;
		}
		
		public function get freq():Number 
		{
			return _freq;
		}
		
		public function get tick0():Number 
		{
			return _tick0;
		}
		
		public function get txt():String 
		{
			return _txt;
		}
		
		public function set txt(value:String):void 
		{
			_txt = value;
		}
		
		public function get noteName():String 
		{
			return _noteName;
		}
		
		public function set noteName(value:String):void 
		{
			_noteName = value;
		}
		
		public function get octave():uint 
		{
			return _octave;
		}
		
		public function set octave(value:uint):void 
		{
			_octave = value;
		}
		
		
		
	}
	
}