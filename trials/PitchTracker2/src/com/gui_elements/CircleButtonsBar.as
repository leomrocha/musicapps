package com.gui_elements 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CircleButtonsBar extends Sprite 
	{
		private var _numberBullets:uint;
		private var _bulletsVector:Vector.<CircleBullet>;
		private var _currentTempo:uint; //holds the index of the bullet that must be ON
		
		private var _bulletRadius:Number;
		
		//dimensions
		private var _w:Number;
		private var _h:Number;
		
		public function CircleButtonsBar(w:Number, h:Number, nBullets:uint = 4) 
		{
			_numberBullets = nBullets;
			_currentTempo = 0;
			_w = w;
			_h = h;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//borders:
			//this.graphics.beginFill(BACKGROUNDCOLOR, 0.8); 
			this.graphics.lineStyle(1, 0x888080);
			this.graphics.drawRect(0, 0, _w, _h);
			//this.graphics.endFill();
			
			createBullets(_numberBullets);
			_currentTempo = 0;
			
		}	
		
		public function start():void
		{
			if (_bulletsVector.length > 0 )
			{
				_bulletsVector[0].on();
			}
		}
		
		public function stop():void
		{
			//turns off all the bullets
			for each(var b:CircleBullet in _bulletsVector)
			{
				b.off();
			}
		}
		
		public function decrementNumberBullets():void
		{
			numberBullets = _numberBullets -1;
		}
		
		public function incrementNumberBullets():void
		{
			numberBullets = _numberBullets +1;
		}
		
		public function get numberBullets():uint 
		{
			return _numberBullets;
		}
		
		public function set numberBullets(nBullets:uint):void 
		{
			stop();
			_numberBullets = nBullets;
			createBullets(nBullets);
		}
		
		public function get currentTempo():uint 
		{
			return _currentTempo;
		}
		
		public function set currentTempo(value:uint):void 
		{
			_currentTempo = value;
			trace("on bullets: tempo= ", _currentTempo);
			if (_currentTempo > 0 && _currentTempo < _numberBullets)
			{
				_bulletsVector[_currentTempo].on();
				_bulletsVector[_currentTempo-1].off(); 
			}else if (_currentTempo == 0 )
			{
				_bulletsVector[_currentTempo].on();
				_bulletsVector[_bulletsVector.length -1 ].off(); 
			}else
			{
				trace("ERROR!!!! _currentTempo MUST be always less than _numberBullets");
			}
				
		}
		
		private function createBullets(nBullets:uint):void
		{
			var i:uint = 0;
			//first be sure all is out of the screen
			for each(var b:CircleBullet in _bulletsVector)
			{
				if (b.parent)
				{
					removeChild(b);
				}
			}
			//now delete everything and create the new ones
			_bulletsVector = new Vector.<CircleBullet>;
			// calculate radious and spacing
			var step:Number;
			var ypos:Number = _h / 2;
			var xpos:Number;
			
			step = _w / (_numberBullets) ;
			xpos = step / 2;
			_bulletRadius = Math.min(step * 0.25, _h * 0.2 );
			 
			for (i = 0; i < nBullets; i++)
			{
				var b1:CircleBullet;
				if(i ==0) b1 = new CircleBullet(_bulletRadius * 2);
				else b1 = new CircleBullet(_bulletRadius);
				addChild(b1);
				b1.y = ypos;
				b1.x = xpos;
				b1.off();
				_bulletsVector.push(b1);
				xpos += step;
			}
			
		}
		
	}

}