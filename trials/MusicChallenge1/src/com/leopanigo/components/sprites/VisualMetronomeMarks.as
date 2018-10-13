package com.leopanigo.components.sprites 
{
	import flash.display.Sprite;

	/**
	 * ...
	 * @author Leo Panigo
	 */
	 
	public class VisualMetronomeMarks extends Sprite 
	{
		
		private var _w:Number, _h:Number;
		private var _ticksVector:Vector.<SimpleLine>;

		private var _ystep:Number; 
		private var _xstep:Number;
		private var _marksOnScreen:Number;
		
		
		public function VisualMetronomeMarks(w:uint , h:uint, marksOnScreen:Number) 
		{
			_w = w;
			_h = h;
			
			_marksOnScreen = marksOnScreen;
			
			_xstep = _w / _marksOnScreen;
			
			_ticksVector = new Vector.<SimpleLine>; //metronome ticks history
		}
		
		
		public function update(tick:Boolean):void
		{
			trace("tick update visual metronome", tick);
			// mark lines creation
			if (tick)
			{
				var mMark:SimpleLine = new SimpleLine(_h);
				mMark.x = _w;
				mMark.y = 0;
				_ticksVector.push(mMark);
				addChild(mMark);
			}
			//screen update
			if (_ticksVector.length > 0)//clean old metronome marks
			{
				if (_ticksVector[0].x < 0)
					{
						var sl:SimpleLine = _ticksVector.shift();
						removeChild(sl);
					}
			}
			for each (var mt:SimpleLine in _ticksVector)//move metronome marks
			{
				if (mt)
				{
					mt.x -= _xstep;
				}
			}
		}
		
		
		public function clear():void
		{
			for each (var mt:SimpleLine in _ticksVector)//move metronome marks
			{
				if (mt && mt.parent)
				{
					removeChild(mt);
				}
			}
			_ticksVector = new Vector.<SimpleLine>;
		}
		
		//TODO complete this function!!
		public function showVector(marks:Vector.<Boolean>):void
		{
			trace("showVector metronome visualizer");
			for each(var m:Boolean in marks)
			{
				update(m);//TODO also is missing the metronome ticks vector!!
			}
			
		}
		
	}

}