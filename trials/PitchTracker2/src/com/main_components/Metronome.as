package com.main_components
{
	import com.gui_elements.GradientButton;
	import com.gui_elements.IconButton;
	import com.gui_elements.PlayButton;
	import com.gui_elements.StopButton;
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	import com.components.metronome_comp.*;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Metronome extends Sprite 
	{
		private var _simpleMetronome:SimpleMetronome;
		//private var 
		//play/stop
		private var playButton:PlayButton;
		private var stopButton:StopButton;
		//up/down
		private var upButton:GradientButton;
		private var downButton:GradientButton;
		//sound on/off
		private var soundOff:GradientButton;
		private var soundOn:GradientButton;
		
		//current bpm
		private var _txt:String; // something that should be written
		private var _bpmField:TextField;
		//private var ;
		private var _bgc:uint = 0x050505;
		
		//state
		private var _running:Boolean;
		//dimensions
		private var _w:Number;
		private var _h:Number;
		
		//icons imagesC:\Users\Leonardo\projects\kitchen-drums\tests\PitchTracker2\assets\imgs\icons
		[Embed(source = "../../../assets/imgs/icons/Mute_Icon_red.svg")]
		private var MuteIcon:Class;
		[Embed(source = "../../../assets/imgs/icons/Speaker_Icon_light-blue.svg")]
		private var SpeakerIcon:Class;
		
		private var muteIcon:Sprite;
		private var speakerIcon:Sprite;
		//lights for the tempo counting // NO, this for a sub specialization of this simple gui
		// some command to change the number of elements in the tempo, no less than 1, no more than ... 8 ? // NO, IDEM line before
		
		public function Metronome(w:Number, h:Number) 
		{
			_w = w;
			_h = h;
			_running = false;
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
			_simpleMetronome.bpm = bpm;
		}
		
		private function init(e:Event = null):void 
		{
			_running =  false;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//background
			var rectangle1:Shape = new Shape;
			rectangle1.graphics.lineStyle(1, 0xf0f0f0, 0.9);
			rectangle1.graphics.beginFill(_bgc); 
			rectangle1.graphics.drawRect( 0 , 0, _w , _h);
			rectangle1.graphics.endFill(); 
			addChild(rectangle1); 
			
			// vars for localization on screen of inner elements
			var xpos:Number;
			var ypos:Number;
			var w:Number;
			var h:Number;
			
			//actual metronome
			_simpleMetronome = new SimpleMetronome(60,1,false);
			//initialize buttons

			//bpm txt
			xpos = 0.05;
			ypos = _h * 0.4;//_h * 0.6;
			w = _w ;
			h = _h * 0.20;
			
			//text formatting:
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.size = h * 0.8 ;
			txtFormat.align = TextFormatAlign.CENTER;
			
			_bpmField = new TextField();
			_bpmField.defaultTextFormat = txtFormat;
			
			
			_bpmField.wordWrap = true;
			//_bpmField.border = true;
			_bpmField.width = _w *0.9;
			_bpmField.height = 12;
			_bpmField.scaleX = 1;
			_bpmField.scaleY = 1;
			_bpmField.x = xpos;
			_bpmField.y = ypos;
			_bpmField.maxChars = 3;
			_bpmField.textColor = 0xFFFF44;
			_bpmField.type = TextFieldType.INPUT;
			_txt = "60";
			_bpmField.text = _txt;
			_bpmField.autoSize = TextFieldAutoSize.CENTER;
			//_bpmField.width = w;
			//_bpmField.height = h;
			//_bpmField.scaleX = 1;
			//_bpmField.scaleY = 1;
			//
			addChild(_bpmField);
			//_bpmField.addEventListener(TextEvent.TEXT_INPUT, textChangeBpm);
			
						
			//dimensioning and positioning
			//play/stop
			xpos = 0.1 * _w;
			ypos = _h*0.75;
			
			h = _h * 0.38;
			//all this to put the image in the correct dimensions!
			playButton = new PlayButton(_w *0.8 ,_h *0.25, 10, 0x303030, 0x5f5f5f, PlayButton.BUTTON_DIRECTION_RIGHT, 0x00aad4);
			playButton.x = xpos;
			playButton.y = ypos;
			addChild(playButton);

			
			stopButton = new StopButton(_w *0.8 ,_h *0.25, 10, 0x303030, 0x5f5f5f, 0x00aad4);
			
			stopButton.x = xpos;
			stopButton.y = ypos;

			playButton.addEventListener(MouseEvent.CLICK, playClicked);

			//addChild(stopButton);
			xpos = _w * 0.1;
			ypos = _h * 0.25;
			w = _w * 0.80;
			h = _h * 0.20;
			
			upButton = new PlayButton(_w * 0.8 ,_h *0.14, 10, 0x303030, 0x5f5f5f, PlayButton.BUTTON_DIRECTION_UP, 0x00aad4); 
			upButton.addEventListener(MouseEvent.CLICK, upClicked);
			upButton.x = xpos;
			upButton.y = ypos;
			addChild(upButton);
			
			ypos = _h * 0.6;
			downButton = new PlayButton(_w * 0.8 ,_h *0.14, 10, 0x303030, 0x5f5f5f, PlayButton.BUTTON_DIRECTION_DOWN, 0x00aad4); 
			downButton.addEventListener(MouseEvent.CLICK, downClicked);
			downButton.x = xpos;
			downButton.y = ypos;
			addChild(downButton); ypos = _h * 0.8;
			
			xpos = _w * 0.1;
			ypos = _h*0.01;//_h * 0.25;
			w = _w * 0.8;
			h = _h *0.23;
			
			speakerIcon = new SpeakerIcon();
			speakerIcon.width = w;
			speakerIcon.height = h;
			speakerIcon.scaleX = 0.04;
			speakerIcon.scaleY = 0.04;
			
			muteIcon = new MuteIcon();
			muteIcon.width = w;
			muteIcon.height = h;
			muteIcon.scaleX = 0.04;
			muteIcon.scaleY = 0.04;
			
			soundOn = new IconButton(muteIcon,w ,h, 10, 0x303030, 0x5f5f5f); 
			soundOn.addEventListener(MouseEvent.CLICK, sndOnClicked);
			soundOn.x = xpos;
			soundOn.y = ypos;
			addChild(soundOn);
			
			soundOff = new IconButton(speakerIcon,w ,h, 10, 0x303030, 0x5f5f5f); 
			soundOff.addEventListener(MouseEvent.CLICK, sndOffClicked);
			soundOff.x = xpos;
			soundOff.y = ypos;
			//addChild(soundOff);
			//
			addEventListener(KeyboardEvent.KEY_DOWN, detectKey);
			
			//put the focus on the textfield, if not the keys do not respond!!! TODO fix this bug
			stage.focus = _bpmField;
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
					if (_running)
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
					_simpleMetronome.bpm = t_bpm;
					trace("Text changing to ", _bpmField.text);
					
				}catch (err:Error)
				{
					
				}
		}
		
		private function sndOnClicked(e:MouseEvent = null):void
		{
			_simpleMetronome.playSound(true);
			removeChild(soundOn);
			addChild(soundOff);
		}
		
		private function sndOffClicked(e:MouseEvent = null):void
		{
			_simpleMetronome.playSound(false);
			removeChild(soundOff);
			addChild(soundOn);
		}
		
		private function upClicked(e:MouseEvent = null):void 
		{
			stopClicked();
			_simpleMetronome.incrementBPM();
			_bpmField.text = _simpleMetronome.bpm.toString();
			trace("up");
		}
		
		private function downClicked(e:MouseEvent = null):void 
		{
			stopClicked();
			_simpleMetronome.decrementBPM();
			_bpmField.text = _simpleMetronome.bpm.toString();
			trace("down");
		}

		private function stopClicked(e:MouseEvent = null):void 
		{
			trace("stop");
			if (_running)
			{
				_running = false;
				_simpleMetronome.stop();
				stopButton.removeEventListener(MouseEvent.CLICK, stopClicked);
				playButton.addEventListener(MouseEvent.CLICK, playClicked);
				if(playButton.parent)				
				{
					//stopButton.visible = false;
					removeChild(stopButton);
				}
				//playButton.visible = true;
				addChild(playButton);

				dispatchEvent( new MetronomeEvent(0,0,MetronomeEvent.METRONOME_STOP));
			}
		}
		
		private function playClicked(e:MouseEvent = null):void 
		{
			trace("play");
			if (!_running)
			{
				_running = true;
				_simpleMetronome.start();
				playButton.removeEventListener(MouseEvent.CLICK, playClicked);
				stopButton.addEventListener(MouseEvent.CLICK, stopClicked);
				if (stopButton.parent)
				{
					//playButton.visible = false;
					removeChild(playButton);
				}
				//stopButton.visible = true;
				addChild(stopButton);
				dispatchEvent( new MetronomeEvent(0,0,MetronomeEvent.METRONOME_START));
			}
		}
		
		public function get simpleMetronome():SimpleMetronome 
		{
			return _simpleMetronome;
		}
		
		public function get running():Boolean 
		{
			return _running;
		}
		
		
		
	}
}