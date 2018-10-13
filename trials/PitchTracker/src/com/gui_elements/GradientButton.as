package com.gui_elements
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.music_concepts.Note;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class  GradientButton extends Sprite
	{
		//colors
		protected var _color1:uint ;
		protected var _color2:uint ;
		
		//dimensions
		protected var _w:uint;
		protected var _h:uint;
		protected var _r:uint;
		//text
		protected var _txt:String;
		protected var _txtObject:TextField;
		
		protected var colors:Object;
		
		public function GradientButton(txt:String, w:uint=10, h:uint=10, r:uint=5 ,color1:uint=0x04618d, color2:uint=0x379EE0)
		{
			_color1 = color1;
			_color2 = color2;
			
			_w = w;
			_h = h;
			_r = r;
			colors = { left:color1, right:color2 };
			
			_txt = txt

			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		//init for use after added to stage
		protected function init(e:Event = null):void
		{

			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			setProperties();
			this.buttonMode = true;
			
			drawGradient();

			this.width  = _w;
			this.height = _h;
			this.scaleX = 1;
			this.scaleY = 1;
			
			this.addEventListener(MouseEvent.MOUSE_OVER, startAnimatingGradient);
			this.addEventListener(MouseEvent.MOUSE_OUT, resetAnimatingGradient);
			
		}
		
		//does all the calculations for the properties of the button
		protected function setProperties():void
		{
			if (_txtObject && _txtObject.parent)
			{
				trace("remove child");
				removeChild(_txtObject);
			}
			_txtObject = new TextField();
			_txtObject.x = 5;
			_txtObject.y = 5;
			_txtObject.maxChars = 3;
			_txtObject.text = _txt;
			_txtObject.selectable = false;

			if (_txtObject.parent == null)
			{
				addChild(_txtObject);
			}
			
		}
		
		public function drawGradient():void 
		{
			var m:Matrix = new Matrix();
			m.createGradientBox(_w, _h, 0, 0, 0);
			this.graphics.beginGradientFill(GradientType.LINEAR, [colors.left, colors.right], 
												[1, 1], [0x00, 0xFF], m, SpreadMethod.REFLECT);
			this.graphics.drawRoundRect(0,0,_w,_h, _r);
		}
		
		protected function startAnimatingGradient(e:MouseEvent):void
		{
			TweenMax.to(colors, 0.3, {hexColors:{left:_color2, right:_color1}, onUpdate:drawGradient});
		}
		
		protected function resetAnimatingGradient(e:MouseEvent):void
		{
			TweenMax.to(colors, 0.3, {hexColors:{left:_color1, right:_color2}, onUpdate:drawGradient});
		}
		
	}
	
}