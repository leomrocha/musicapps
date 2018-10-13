package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class ToneRect extends Sprite 
	{
		private var freq:Number;
		private var duration:Number;
		private var t0:Number;
		
		public function ToneRect( f:Number, t:Number, d:Number )
		{
				freq = f;
				duration = d;
				t0 = t;
		}
		
		public function setPos( xpos:Number, ypos:Number ):void
		{
			x = xpos;
			y = ypos;
		}
		
		public function updateX( xdiff:Number ):void
		{
			x += xdiff;
		}
		public function updateY( ydiff:Number ):void
		{
			x += ydiff;
		}
	}
	
}