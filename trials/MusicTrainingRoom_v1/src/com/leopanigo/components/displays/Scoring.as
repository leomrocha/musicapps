package com.leopanigo.components.displays 
{
	import com.music_concepts.Note;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class Scoring extends Sprite 
	{

		private var _w:Number;
		private var _h:Number;
		
		private var _noteCount:uint;
		private var _sumAbsErrors:Number;
		
		private var _result:Number;
		
		private var _txt:String; // something that should be written
		private var _resultTxt:TextField;
		
		private var _bgc:uint = 0x050505;
		
		public function Scoring(w:Number, h:Number) 
		{
			_w = w;
			_h = h;

			
			
			_result = 0;
			_sumAbsErrors = 0;
			_noteCount = 0;
			
			_resultTxt = new TextField();
			_resultTxt.wordWrap = true;
			_resultTxt.width = _w *0.9;
			_resultTxt.height = 10;
			_resultTxt.scaleX = 1;
			_resultTxt.scaleY = 1;
			_resultTxt.x = 0;
			_resultTxt.y = 0;
			_resultTxt.maxChars = 8;
			_resultTxt.textColor = 0xFFFF44;
			_resultTxt.selectable = false;
			//_resultTxt.type = TextFieldType.INPUT;
			_txt = "100 /100";
			_resultTxt.text = _txt;
			_resultTxt.autoSize = TextFieldAutoSize.CENTER;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//background
			var rectangle1:Shape = new Shape;
			rectangle1.graphics.lineStyle(1, 0xf0f0f0, 0.9);
			rectangle1.graphics.beginFill(_bgc); 
			rectangle1.graphics.drawRect( 0 , 0, _w , _h);
			rectangle1.graphics.endFill(); 
			addChild(rectangle1); 
			
			addChild(_resultTxt);
			//addChild();
		}
		
		public function update(note:Note):void
		{
			_sumAbsErrors += Math.abs(note.errorCents/50.0);
			_noteCount++;
			_result = 100 - 100*(_sumAbsErrors / (_noteCount) ) ;//
			_resultTxt.text = _result.toString().substr(0,3)+" /100";
		}
		
		public function clear():void
		{
			_result = 0;
			_noteCount = 0;
			_sumAbsErrors = 0;
			_resultTxt.text = "100 /100";
		}
	}

}