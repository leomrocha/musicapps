package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class GameStateSprite extends Sprite implements IEventDispatcher
	{
		protected var x0:uint;
		protected var y0:uint;
		protected var widthScreen:uint;
		protected var heightScreen:uint;
		
		public function GameStateSprite()
		{
			trace("GameStateSprite Constructor");
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public virtual function redimension(w:uint, h:uint):void
		{
			//TODO all the calculations this is a virtual method only
			trace("redimension GameStateSprite 1", w, h, widthScreen, heightScreen, width, height);
			widthScreen = w;
			heightScreen = h;
			//width = w;
			//height = h;
			//trace("redimension GameStateSprite 2", w, h, widthScreen, heightScreen, width, height);
		}
		protected virtual function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			trace("init of the abstract GameStateSprite class");

		}
	}
	
}