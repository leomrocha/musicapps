package com.tools.SimpleTunerGui.gui_elements 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class Letter extends Sprite 
	{
		private var _letter:String;
		private var _text:TextField;
		private var _w:Number;
		private var _h:Number;
		
		protected var _redColor1:uint  = 0xff0000;
		protected var _redColor2:uint = 0xAf0000;
		protected var _greenColor1:uint = 0x00ff00;
		protected var _greenColor2:uint = 0x00Af00;
		protected var _yellowColor1:uint = 0x555500;
		protected var _yellowColor2:uint = 0x050500;
		
		protected var DEFAULT_COLOR:uint = 0x090909;
		
		protected var txtFormat:TextFormat;
		
		public function Letter( l:String, w:Number, h:Number) 
		{
			_letter = l;
			_w = w;
			_h = h;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			
			trace("initialization of letter: ", _letter);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
						//text formatting:
			txtFormat = new TextFormat();
			txtFormat.bold = true;
			txtFormat.size = _h * 0.50 ;
			txtFormat.color = DEFAULT_COLOR;
			txtFormat.align = TextFormatAlign.CENTER;
			
			_text = new TextField();
			_text.defaultTextFormat = txtFormat;
			_text.text = _letter;
			_text.wordWrap = true;
			//_text.border = true;
			_text.x = 0; // xpos;
			_text.y = 0; // ypos;
			_text.maxChars = 2;
			//_text.type = TextFieldType.INPUT;
			_text.width = _w;
			_text.height = _h;
			addChild(_text);
			
			//change clickable properties .... ??? how!??? 
			this.buttonMode = false;
		}
		
		public function redLight():void
		{
			//change font color to red
			txtFormat.color = _redColor1;
			_text.defaultTextFormat = txtFormat;
			_text.text = _letter;
		}
		
		public function greenLight():void
		{
			txtFormat.color = _greenColor1;
			_text.defaultTextFormat = txtFormat;
			_text.text = _letter;
		}
		
		public function steadyState():void
		{
			txtFormat.color = DEFAULT_COLOR;
			_text.defaultTextFormat = txtFormat;
			_text.text = _letter;
			
		}
		
		public function get letter():String 
		{
			return _letter;
		}
		
		public function set letter(value:String):void 
		{
			_letter = value;
			steadyState();
		}
		

		
	}

}