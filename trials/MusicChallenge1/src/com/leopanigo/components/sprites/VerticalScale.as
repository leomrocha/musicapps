package com.leopanigo.components.sprites 
{
	import com.leopanigo.music_concepts.Note;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class VerticalScale  extends Sprite
	{
		private var _w:uint,//width  with a rate of 11 this should be 512
                    _h:uint,//should be an odd number.
                    _a:uint,//amplitude factor
                    _lineColour:uint,//line colour
                    _backgroundColour:uint,//background colour
					_pointWidth:Number,
					_range:Number,
					_minVal:Number = 1.0,
					_maxVal:Number = 1.0;
		private var MAX_MARKS:uint = 5;
		private var textVector:Vector.<TextField>;
		private var scaleLine:Shape;
		private var backgroundRect:Shape;
		
		public function VerticalScale(width:uint = 15, height:uint = 50, maxVal:Number = 120.0, minVal:Number = 20.0, marks:uint = 5,
										pointWidth:Number = 2, lineColour:uint = 0xFFFFFF, backgroundColour:uint = 0x000000) 
		{
			_w = width;
            _h = height;
			_minVal = minVal;
			_maxVal = maxVal;
			MAX_MARKS = marks;
			_range  = _maxVal - _minVal;
			textVector = new Vector.<TextField>;
			scaleLine = new Shape;
			backgroundRect = new Shape;
			_lineColour = lineColour;
            _backgroundColour = backgroundColour;
			_pointWidth = pointWidth;
			drawScale();
		}
		
		
		public function update(minVal:Number, maxVal:Number):void
		{
			_minVal = minVal;
			_maxVal = maxVal;
			_range  = _maxVal - _minVal;
			drawScale();
		}
		
		private function drawScale():void
		{
			for each (var tf:TextField in textVector)
			{
				if (tf.parent)
				{
					removeChild(tf);
				}
			}
			textVector = new Vector.<TextField>;
			//var n:Note
			//Background
			if (backgroundRect.parent)
			{
				removeChild(backgroundRect);
			}
			backgroundRect = new Shape(); 
			backgroundRect.graphics.beginFill(0x050505);
			backgroundRect.graphics.drawRect(0, 0, _w, _h);
			backgroundRect.graphics.endFill();
			addChild(backgroundRect);
			
			if (scaleLine.parent)
			{
				removeChild(scaleLine);
			}
			scaleLine = new Shape;
			scaleLine.graphics.lineStyle( 1, _lineColour );
			//graphics.drawRect( LEFT, TOP, WIDTH, HEIGHT );
			scaleLine.graphics.moveTo(_w - 2, 0);
			scaleLine.graphics.lineTo(_w - 2, _h);
			//do the scale marks
			for (var i:uint = 0; i < MAX_MARKS; i++)
			{
				var value:Number = ( ( _range / (MAX_MARKS-1) ) * i + _minVal);
				var ypos:Number = _h - ( _h * ( (value - _minVal) / _range ) );
				//mark
				scaleLine.graphics.moveTo(0, ypos);
				scaleLine.graphics.lineTo(_w, ypos);
				//label
				var t:TextField = new TextField();
				t.selectable = false;
				t.maxChars = 5;
				t.text = value.toString().substr(0,4);
				t.width = 0;
				t.height = 10;
				t.x = _w/2;
				t.y = ypos -15;
				if (ypos -15 < 0)
				{
					t.y = 0;
				}
				t.textColor = 0xffff77;
				t.autoSize = TextFieldAutoSize.CENTER;
				textVector.push(t);
				addChild(t);
			}
			addChild(scaleLine);
		}
	}

}
