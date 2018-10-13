package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class ToneRect extends Sprite 
	{
		//private var f0:Number;
		//private var duration:Number;
		//private var t0:Number;
		
		private var m_note:Note;
		
		//public function ToneRect( f:Number, t:Number, d:Number )
		public function ToneRect( n:Note)
		{
				//f0 = f;
				//duration = d;
				//t0 = t;
				//m_note = new Note(f,t,d);
				m_note = n;
				//trace("n= ", n, "m_note = ", m_note);

		}
		
		public function highlight():void
		{
			this.graphics.beginFill(0x00AA00, 0.5); 
			this.graphics.drawRect(-2, -2, 27, 9);
			this.graphics.endFill();
		}
		
		public function setPos( xpos:Number, ypos:Number ):void // TODO add width!!
		{
			x = xpos;
			y = ypos;
			
			//graphics.moveTo(0,0);
			graphics.beginFill(0x0000AA, 0.5); 
			graphics.drawRect(0, 0, 23, 7);
			graphics.endFill();
		}

		public function set note( n:Note):void
		{
			m_note = n;
		}
		
		public function get time():Number
		{
			//trace("get time = ", m_note);
			return m_note.time;
		}
		
		public function get freq():Number
		{
			return m_note.freq;
		}
		
		public function get duration():Number
		{
			return m_note.duration;
		}
		
		
		public function updateX( xdiff:Number ):void
		{
			x += xdiff;
			//highlight();
			
			/*if (visible && ( x < 0 || x > 900 ) ) //TODO put here a way to do it dynamic
			{
				visible = false;
			}else if (!visible && x > 0 && x < 900)
			{
				visible = true;
			}*/
		}
		public function updateY( ydiff:Number ):void
		{
			y += ydiff;
		}
	}
	
}