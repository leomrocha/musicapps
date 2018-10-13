package com.tools.SimpleMetronome 
{
	import com.tools.SimpleMetronome.gui_components.BmpButton;
	import com.tools.SimpleMetronome.gui_components.CircleButtonsBar;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MetronomeGui extends Sprite 
	{
		private var simpleMetronome:SimpleMetronome;
		//private var 
		//play/stop
		[Embed(source = "./assets/imgs/buttons/Gold/MediaButtons/play.png")] public var PlayButtonImage:Class;
		private var playButtonImage:Bitmap;
		private var playButton:BmpButton;
		[Embed(source = "./assets/imgs/buttons/Gold/MediaButtons/stop.png")] public var StopButtonImage:Class;
		private var stopButtonImage:Bitmap;
		private var stopButton:BmpButton;
		//up/down
		[Embed(source = "./assets/imgs/buttons/Gold/MediaButtons/up.png")] public var UpButtonImage:Class;
		private var upButtonImage:Bitmap;
		private var upButton:BmpButton;
		[Embed(source = "./assets/imgs/buttons/Gold/MediaButtons/down.png")] public var DownButtonImage:Class;
		private var downButtonImage:Bitmap;
		private var downButton:BmpButton;
		
		[Embed(source = "./assets/imgs/buttons/Gold/arrow-down.png")] public var ArrowDownButtonImage:Class;
		private var arrowDownButtonImage:Bitmap;
		private var arrowDownButton:BmpButton;
		
		[Embed(source = "./assets/imgs/buttons/Gold/arrow-up.png")] public var ArrowUpButtonImage:Class;
		private var arrowUpButtonImage:Bitmap;
		private var arrowUpButton:BmpButton;
		
		//current bpm
		private var _bpmField:TextField; // keeps the BPM indication for the user, gives input to the user
		private var _tempoField:TextField;// keeps the number of beats of the cycle
		//private var ;
		
		
		private var bulletsBar:CircleButtonsBar;
		
		//state
		private var running:Boolean;
		//dimensions
		private var _w:Number;
		private var _h:Number;
		
		//lights for the tempo counting // NO, this for a sub specialization of this simple gui
		// some command to change the number of elements in the tempo, no less than 1, no more than ... 8 ? // NO, IDEM line before
		
		public function MetronomeGui(w:Number, h:Number) 
		{
			_w = w;
			_h = h;
			running = false;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function start():void
		{
			playClicked();
		}
		public function stop():void
		{
			stopClicked();
		}
		public function setBPM(bpm:uint):void
		{
			simpleMetronome.bpm = bpm;
		}
		
		private function init(e:Event = null):void 
		{
			running =  false;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// vars for localization on screen of inner elements
			var xpos:Number;
			var ypos:Number;
			var w:Number;
			var h:Number;
			var _txt:String;
			var _txt2:String;
			simpleMetronome = new SimpleMetronome(60,4);
			//initialize buttons

			//bpm txt
			xpos = _w * 0.10;
			ypos = _h * 0.05;
			w = _w * 0.30;
			h = _h * 0.40;
			
			//text formatting:
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.size = h * 0.8 ;
			txtFormat.align = TextFormatAlign.CENTER;
			
			_bpmField = new TextField();
			_bpmField.defaultTextFormat = txtFormat;
			_txt = "60";
			_bpmField.text = _txt;
			_bpmField.wordWrap = true;
			_bpmField.border = true;
			_bpmField.x = xpos;
			_bpmField.y = ypos;
			_bpmField.maxChars = 3;
			_bpmField.type = TextFieldType.INPUT;
			_bpmField.width = w;
			_bpmField.height = h;
			//_bpmField.scaleX = 1;
			//_bpmField.scaleY = 1;
			//
			addChild(_bpmField);
			//_bpmField.addEventListener(TextEvent.TEXT_INPUT, textChangeBpm);
			//
			xpos = _w * 0.85;
			ypos = _h * 0.55;
			w = _w * 0.10;
			h = _h * 0.40;
			var txtFormat2:TextFormat = new TextFormat();
			txtFormat2.size = h * 0.8 ;
			txtFormat2.align = TextFormatAlign.CENTER;
			
			_txt2 = "4";
			_tempoField = new TextField();
			_tempoField.defaultTextFormat = txtFormat2;
			_tempoField.text = _txt2;
			_tempoField.wordWrap = true;
			_tempoField.border = true;
			_tempoField.x = xpos;
			_tempoField.y = ypos;
			_tempoField.maxChars = 2;
			//_tempoField.type = TextFieldType.INPUT;
			_tempoField.width = w;
			_tempoField.height = h;
			addChild(_tempoField);
			
			//dimensioning and positioning
			//play/stop
			xpos = _w * 0.55;
			ypos = _h * 0.08;
			w = _w * 0.30;
			h = _h * 0.38;
			//all this to put the image in the correct dimensions!
			playButtonImage = new PlayButtonImage() as Bitmap;
			playButton = new BmpButton(playButtonImage, w, h);

			addChild(playButton);
			playButton.x = xpos;
			playButton.y = ypos;
			
			//changing height to cover the bmp from the play button, ...I don't understand why it does not refresh the screen correclty
			ypos = _h * 0.05;
			h = _h * 0.44;
			stopButtonImage = new StopButtonImage() as Bitmap;
			stopButton = new BmpButton(stopButtonImage, w, h);
			
			stopButton.x = xpos;
			stopButton.y = ypos;
			
			//playButton.width = w;
			//stopButton.width = w;
			//playButton.height = h;
			//stopButton.height = h;
			//playButton.scaleX = 1;
			//playButton.scaleY = 1;
			//stopButton.scaleX = 1;
			//stopButton.scaleY = 1;
			playButton.addEventListener(MouseEvent.CLICK, playClicked);

			//addChild(stopButton);
			xpos = _w * 0.40;
			ypos = _h * 0.05;
			w = _w * 0.10;
			h = _h * 0.20;
			
			upButtonImage = new UpButtonImage() as Bitmap;
			upButton = new BmpButton(upButtonImage, w, h);
			upButton.addEventListener(MouseEvent.CLICK, upClicked);
			upButton.x = xpos;
			upButton.y = ypos;

			addChild(upButton);
			
			ypos = _h * 0.23;
			downButtonImage = new DownButtonImage() as Bitmap;
			downButton = new BmpButton(downButtonImage, w, h);
			downButton.addEventListener(MouseEvent.CLICK, downClicked);
			downButton.x = xpos;
			downButton.y = ypos;
			
			addChild(downButton);
			
			xpos = _w * 0.8;
			ypos = _h * 0.55;
			w = _w * 0.05;
			h = _h * 0.40;
			arrowDownButtonImage = new ArrowDownButtonImage();
			arrowDownButton = new BmpButton(arrowDownButtonImage, w, h);
			arrowDownButton.addEventListener(MouseEvent.CLICK, arrowDownClicked);
			arrowDownButton.x = xpos;
			arrowDownButton.y = ypos;
			
			addChild(arrowDownButton);
			
			xpos = _w * 0.95;
			//ypos = _h * 0.55;
			//w = _w * 0.05;
			//h = _h * 0.40;
			arrowUpButtonImage = new ArrowUpButtonImage();
			arrowUpButton = new BmpButton(arrowUpButtonImage, w, h);
			arrowUpButton.addEventListener(MouseEvent.CLICK, arrowUpClicked);
			arrowUpButton.x = xpos;
			arrowUpButton.y = ypos;
			
			addChild(arrowUpButton);
			
			xpos = _w * 0.10;
			ypos = _h * 0.55;
			w = _w * 0.7;
			h = _h * 0.40;
			bulletsBar = new CircleButtonsBar(w, h, 4);
			bulletsBar.x = xpos;
			bulletsBar.y = ypos;
			
			addChild(bulletsBar);
			addEventListener(KeyboardEvent.KEY_DOWN, detectKey);
			
			simpleMetronome.addEventListener(MetronomeEvent.METRONOME_TICK, onTick);
			
			
			//put the focus on the textfield, if not the keys do not respond!!! TODO fix this bug
			stage.focus = _bpmField;
		}
		
		private function arrowDownClicked(e:MouseEvent):void
		{
			bulletsBar.decrementNumberBullets();
			simpleMetronome.beatsPerCompass = bulletsBar.numberBullets;
			_tempoField.text = bulletsBar.numberBullets.toString();
			
		}
		
		private function arrowUpClicked(e:MouseEvent):void
		{
			bulletsBar.incrementNumberBullets();
			simpleMetronome.beatsPerCompass = bulletsBar.numberBullets;
			_tempoField.text = bulletsBar.numberBullets.toString();
		}
		
		
		private function onTick(e:MetronomeEvent):void
		{
			trace("tickOnCompass 1: ", e.tickInCompass);
			bulletsBar.currentTempo = (e.tickInCompass + bulletsBar.numberBullets -1 )% bulletsBar.numberBullets;//WARNING, hack to correct the updated value on the tickInCompass that is passed to the bulletsBar
			trace("tickOnCompass 2: ", e.tickInCompass);
		}
		
		private function detectKey(e:KeyboardEvent = null):void
		{
			trace("detected key down: ", e.keyCode);
			switch(e.keyCode) //case enter
			{
				case(13): //enter
					textChangeBpm();
					break;
				case(32): //space bar
					if (running)
					{
						stopClicked();
					}
					else {
						playClicked();
					}
					break;
				case(38): //up
					upClicked();
					break;
				case(40):
					downClicked();
					break;
			}
		}
		
		private function textChangeBpm(e:TextEvent = null):void
		{
			
				try
				{
					var t_bpm:uint = parseInt(_bpmField.text);
					simpleMetronome.bpm = t_bpm;
					trace("Text changing to ", _bpmField.text);
					
				}catch (err:Error)
				{
					
				}
		}
		private function upClicked(e:MouseEvent = null):void 
		{
			stopClicked();
			simpleMetronome.incrementBPM();
			_bpmField.text = simpleMetronome.bpm.toString();
			trace("up");
		}
		
		private function downClicked(e:MouseEvent = null):void 
		{
			stopClicked();
			simpleMetronome.decrementBPM();
			_bpmField.text = simpleMetronome.bpm.toString();
			trace("down");
		}
		
		private function stopClicked(e:MouseEvent = null):void 
		{
			trace("stop");
			if (running)
			{
				running = false;
				simpleMetronome.stop();
				stopButton.removeEventListener(MouseEvent.CLICK, stopClicked);
				playButton.addEventListener(MouseEvent.CLICK, playClicked);
				if(playButton.parent)				
				{
					stopButton.visible = false;
					removeChild(stopButton);
				}
				playButton.visible = true;
				addChild(playButton);
				bulletsBar.stop();
				
				dispatchEvent( new MetronomeEvent(0,0,MetronomeEvent.METRONOME_STOP));
			}
		}
		
		private function playClicked(e:MouseEvent = null):void 
		{
			trace("play");
			if (!running)
			{
				running = true;
				simpleMetronome.start();
				playButton.removeEventListener(MouseEvent.CLICK, playClicked);
				stopButton.addEventListener(MouseEvent.CLICK, stopClicked);
				if (stopButton.parent)
				{
					playButton.visible = false;
					removeChild(playButton);
				}
				stopButton.visible = true;
				addChild(stopButton);
				bulletsBar.start();
				dispatchEvent( new MetronomeEvent(0,0,MetronomeEvent.METRONOME_START));
			}
		}
		
		
		
	}

}