package 
{
	import com.components.PubSlideshow;
	import com.components.SimpleTuner;
	import com.music_concepts.Note;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	//[SWF(width = "320", height = "480")]
	[SWF(width='320', height='480', frameRate='30', backgroundColor='0x050505')]
	public class Main extends Sprite 
	{
		private var simpleTuner:SimpleTuner;
		private var pub:PubSlideshow;
		
		[Embed(source = "../assets/imgs/blackBackground_simple_320x480.svg")]
		private var B:Class;
		
		private var b:Sprite;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//stage properties
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE; //so it does not scale automatically :)
			//
			
			b = new B();
			b.width = stage.stageWidth;
			b.height = stage.stageHeight;
			b.scaleX = 1;
			b.scaleY = 1;
			addChild(b);
			
			var w:Number = stage.stageWidth;
			var h:Number = stage.stageHeight * 0.75;
			simpleTuner = new SimpleTuner(w, h);
			addChild(simpleTuner);
			pub = new PubSlideshow(w, stage.stageHeight * 0.25);
			pub.y = h;
			addChild(pub);
		}
		
	}
	
}