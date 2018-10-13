package 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class TFGameCanvas  extends Sprite
	{
		private var tonesVec:Vector.<ToneRect>;
		
		public function TFGameCanvas()
		{
			
			tonesVec = createTones();
			for each( var t:ToneRect in tonesVec )
			{
				addChild(t);
				
			}
		}
		
		private function createTones():Vector.<ToneRect>
		{
			var tv:Vector.<ToneRect> = new Vector.<ToneRect>; //the actual level
			var i:uint;
			var f:Number = 0 ;
			var t:Number = 0 ;
			var d:Number = 500;
			for (i = 0 ; i < 100; i++)
			{
				f += 10;
				t += 1000;
				var tr:ToneRect = new ToneRect(f, t, d);
				tv.push(tr);
			}
			return tv;
		}
	}
	
}