package com.leopanigo.components.sprites 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class ErrorMark extends Sprite 
	{
		private var _length:Number;
		private var _maxErrorCents:Number;
		private var _color:uint;
		private var _lineWidth:uint;
		private var _alpha:Number;
		private var _txtEnabled:Boolean;
		
		private var _errorCents:Number;
		private var _txtField:TextField;
		
		//private var _minAngle:Number;
		//private var _maxAngle:Number;
		//
		public function ErrorMark(xpos:uint, ypos:uint, length:Number, errorCents:Number, color:uint = 0x000000,  lineWidth:uint = 2, transparency:Number=0.7, txtEnabled:Boolean=false, maxErrorCents:Number = 50.0) 
		{
			//x = xpos;
			//y = ypos;
			_length = length;
			_maxErrorCents = maxErrorCents;
			_errorCents = errorCents;
			_color = color;
			_lineWidth = lineWidth;
			_alpha = transparency;
			_txtEnabled = txtEnabled;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		//init for use after added to stage
		protected function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			trace("init error mark");
			//TODO at 0,0 add a nice center of rotation ... maybe a circle with degrade
			this.graphics.lineStyle(_lineWidth, _color, _alpha); //thickness, color, alpha
			this.graphics.moveTo(0, - _length / 2);
			this.graphics.lineTo(0, - ( _length - 20));
			if (_txtEnabled)
			{
				_txtField = new TextField;
				_txtField.x = 0;
				_txtField.y = - _length;
				_txtField.textColor = 0xffffff;
				_txtField.text = _errorCents.toString();
				_txtField.width = _txtField.textWidth * 2 ;
				_txtField.height = _txtField.textHeight * 1.4;
				_txtField.scaleX = 1;
				_txtField.scaleY = 1;
			
				//_txtField.rotation;
				addChild(_txtField);
			}

			
			var a:Number = ( _errorCents * 90.0 / _maxErrorCents );
			if (_errorCents < - _maxErrorCents)
				a = -90;
			if (_errorCents > _maxErrorCents)
				a = 90;
					
			TweenMax.to(this, 1, { rotation:a } ); //TODO do the rotation without the tweening although is nice efect at init!
			if (_txtEnabled)
				{
					TweenMax.to(_txtField, 1, { rotation:a } );
				}
				
		}
		
	}

}