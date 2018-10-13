package 
{
	import com.gui_elements.SimpleSheet;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class Main extends Sprite 
	{
		
		private var sheet:SimpleSheet;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			sheet = new SimpleSheet();
			addChild(sheet);
		}
		
	}
	
}