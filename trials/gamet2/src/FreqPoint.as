package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class FreqPoint extends Shape 
	{
		private var freq:Number;
		private var t0:Number;

		public function FreqPoint(f:Number, t:Number)
		{
			freq = f;
			t0 = t;
		}
		
public function setPos( xpos:Number, ypos:Number ):void
		{
			x = xpos;
			y = ypos;
			
			this.graphics.beginFill(0xAA0000, 0.5); 
			this.graphics.drawCircle(0, 0, 2);
			this.graphics.endFill();
		}
		
		public function updateX( xdiff:Number ):void
		{
			x += xdiff;
		}
		public function updateY( ydiff:Number ):void
		{
			y += ydiff;
		}
		
	}
	
}