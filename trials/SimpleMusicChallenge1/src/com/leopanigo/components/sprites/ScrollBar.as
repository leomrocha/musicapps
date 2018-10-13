package com.leopanigo.components.sprites 
{
	import com.leopanigo.components.buttons.GradientButton;
	import com.leopanigo.components.events.ScrollBarEvent;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class ScrollBar extends Sprite
	{
		private var _w:Number, _h:Number;
		
		
		
		private var goLeftButton:GradientButton;
		private var goRightButton:GradientButton;
		private var _goButtonsWidth:Number = 5;
		
		
		private var scrollButton:GradientButton;
		private var _scrollButtonWidth:Number = 10;
		
		private var message:TextField;
		
		private var _bcg:Shape;
		private var _backgroundColour:uint;
		private var _bordersColours:uint;
		
		private var _currPercentualPosition:Number;
		private var _currPosition:Number;
		
		private var _timer:Timer;  // Timer for updating position on mouse click hold
		private var _timeout:Number = 50;
		
		private var _active:Boolean;
		
		
		public function ScrollBar(w:Number, h:Number, background:uint = 0x050505, bordersColours:uint = 0x707070)
		{
			_w = w;
			_h = h;
			_backgroundColour = background;
			_bordersColours = bordersColours;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		
			//draw background
			_bcg = new Shape;
			_bcg.graphics.lineStyle(2, 0x0044aa, 0.9);
			_bcg.graphics.beginFill(_backgroundColour, 0.9); // choosing the colour for the fill
			_bcg.graphics.drawRect( 0 , 0, _w, _h);// (x spacing, y spacing, width, height)
			_bcg.graphics.endFill(); // not always needed but I like to put it in to end the fill
			addChild(_bcg); // adds the rectangle to the stage
			
			
			//create buttons
			goLeftButton = new GradientButton("", _goButtonsWidth, _h, 2, 0xafaf10, 0xffff10 );
			goLeftButton.y = 0;
			goLeftButton.x = 0;
			addChild(goLeftButton);
			
			goRightButton = new GradientButton("", _goButtonsWidth, _h, 2, 0xafaf10, 0xffff10 );
			goRightButton.y = 0;
			goRightButton.x = _w - _goButtonsWidth;
			addChild(goRightButton);
			
			scrollButton = new GradientButton("", _scrollButtonWidth, _h, 3, 0x7f7f10, 0xfff10 );
			scrollButton.y = 0;
			_currPosition = _goButtonsWidth;
			setScrollPosition(_currPosition);
			addChild(scrollButton);
			
			message = new TextField(); //for showing messages to the user
			message.selectable = false;
			message.backgroundColor = 0x000000;
			message.opaqueBackground = true;
			//message.alpha = 0.2;
			message.doubleClickEnabled = false;
			message.border = true;
			
			message.textColor = 0xffff00;
			
			//
			_timer = new Timer(_timeout);
			
			_active = false;
			setScrollPercentagePosition(100.0);
		}
		
		public function activate():void
		{
			//now listen to events on each of those
			goLeftButton.addEventListener(MouseEvent.CLICK, onGoLeftClick);
			goRightButton.addEventListener(MouseEvent.CLICK, onGoRightClick);
			
			goLeftButton.addEventListener(MouseEvent.MOUSE_DOWN, onGoLeftHold);
			goRightButton.addEventListener(MouseEvent.MOUSE_DOWN, onGoRightHold);
			
			//scrollButton.addEventListener(MouseEvent.MOUSE_DOWN, onScrollHold);
			
			scrollButton.addEventListener(MouseEvent.ROLL_OVER, onRollOverButton);
			scrollButton.addEventListener(MouseEvent.ROLL_OUT, onRollOutButton);
			
			addEventListener(MouseEvent.CLICK, onScrollMove);
			
			_active = true;
		}
		
		public function deactivate():void
		{
			//now listen to events on each of those
			goLeftButton.removeEventListener(MouseEvent.CLICK, onGoLeftClick);
			goRightButton.removeEventListener(MouseEvent.CLICK, onGoRightClick);
			
			goLeftButton.removeEventListener(MouseEvent.MOUSE_DOWN, onGoLeftHold);
			goRightButton.removeEventListener(MouseEvent.MOUSE_DOWN, onGoRightHold);
			
			//scrollButton.removeEventListener(MouseEvent.MOUSE_DOWN, onScrollHold);
			
			scrollButton.removeEventListener(MouseEvent.ROLL_OVER, onRollOverButton);
			scrollButton.removeEventListener(MouseEvent.ROLL_OUT, onRollOutButton);
			
			removeEventListener(MouseEvent.CLICK, onScrollMove);
			
			_active = false;
			setScrollPercentagePosition(100.0);
		}
		
		private function onGoLeftHold(e:MouseEvent):void
		{
			goLeftButton.removeEventListener(MouseEvent.MOUSE_DOWN, onGoLeftHold);
			
			goLeftButton.addEventListener(MouseEvent.MOUSE_UP, onGoLeftUp);
			
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, onGoLeftClick);
		}
		
		private function onGoLeftUp(e:MouseEvent):void
		{
			goLeftButton.removeEventListener(MouseEvent.MOUSE_UP, onGoLeftUp);
			goLeftButton.addEventListener(MouseEvent.MOUSE_DOWN, onGoLeftHold);
			
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onGoLeftClick);
		}
		
		private function onGoRightHold(e:MouseEvent):void
		{
			
			goRightButton.removeEventListener(MouseEvent.MOUSE_DOWN, onGoRightHold);
			goRightButton.addEventListener(MouseEvent.MOUSE_UP, onGoRightUp);
			
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, onGoRightClick);
		}
		
		private function onGoRightUp(e:MouseEvent):void
		{
			goRightButton.removeEventListener(MouseEvent.MOUSE_UP, onGoRightUp);
			goRightButton.addEventListener(MouseEvent.MOUSE_DOWN, onGoRightHold);
			
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, onGoRightClick);
		}
		
		private function onGoLeftClick(e:Event):void
		{
			//setScrollPercentagePosition(_currPercentualPosition -1);
			setScrollPosition(_currPosition -1);
		}
		
		private function onGoRightClick(e:Event):void
		{
			//setScrollPercentagePosition(_currPercentualPosition +1);
			setScrollPosition(_currPosition +1);
		}
		
		
		private function onScrollHold(e:MouseEvent):void
		{
			trace("onScrollHold");
			scrollButton.startDrag();
			scrollButton.removeEventListener(MouseEvent.MOUSE_DOWN, onScrollHold);
			scrollButton.addEventListener(MouseEvent.MOUSE_UP, onScrollLose);
			scrollButton.addEventListener(MouseEvent.MOUSE_MOVE, onScrollMove);
			//show text with percentage or time
		}
		
		private function onScrollLose(e:MouseEvent = null):void
		{
			trace("onScrollLose");
			scrollButton.stopDrag();
			scrollButton.addEventListener(MouseEvent.MOUSE_DOWN, onScrollHold);
			scrollButton.removeEventListener(MouseEvent.MOUSE_UP, onScrollLose);
			scrollButton.removeEventListener(MouseEvent.MOUSE_MOVE, onScrollMove);
			//erase from screen the text with percentage or time
			
		}
		
		//private function onClick(e:MouseEvent):void
		//{
			//var pos:Number = mouseX;
			//setScrollPosition(pos);
		//}
		
		private function onScrollMove(e:MouseEvent):void
		{

			var pos:Number = mouseX;
			setScrollPosition(pos);
		}
		
		public function setScrollPercentagePosition(perc:Number):void
		{
			if (perc >= 0 && perc <= 100)
			{
				var xpos:Number = _goButtonsWidth + ( (_w - 2 * _goButtonsWidth) * perc / 100 ) - _scrollButtonWidth;
				scrollButton.x = xpos;
				_currPercentualPosition = perc;
				
				dispatchEvent(new ScrollBarEvent(_currPercentualPosition));
			}
			
		}
		
		private function setScrollPosition(pos:Number):void
		{
			if (pos >= _goButtonsWidth && pos <= (_w - _goButtonsWidth - _scrollButtonWidth) )
			{
				var perc:Number = 100 * ( (pos - _goButtonsWidth) / (_w - (2 * _goButtonsWidth)) ) ;  //  ( current pos / width )* 100
				scrollButton.x = pos;
				_currPosition = pos;
				_currPercentualPosition = perc;
				dispatchEvent(new ScrollBarEvent(_currPercentualPosition));
			}
			
		}
		
		private function onRollOver(e:MouseEvent = null):void
		{
			trace("onRollOver");
			//add the message at the mouse position
			message.text = _currPercentualPosition.toString() + "%";
			
			addChild(message);
			onMouseMove();
			
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onRollOut(e:MouseEvent=null):void
		{
			trace("onRollOut");
			removeChild(message);
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			//onScrollLose();
		}
		
		private function onRollOverButton(e:MouseEvent = null):void
		{
			//add the message at the mouse position
			message.text = _currPercentualPosition.toString() + "%";
			
			addChild(message);
			onMouseMove();
			
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onRollOutButton(e:MouseEvent=null):void
		{
			removeChild(message);
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent = null):void
		{
			//get position of the mouse
			//move the message
			message.text = _currPercentualPosition.toString().substr(0,4) + "%";
			message.width = message.textWidth * 1.5 ;
			message.height = message.textHeight * 1.4;
			message.scaleX = 1;
			message.scaleY = 1;
			
			message.x =  mouseX - message.width /2 ; //e.localX;
			message.y = mouseY - message.height  - 5; // e.localY;
		}
		
		public function get active():Boolean 
		{
			return _active;
		}
	}

}