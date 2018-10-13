package 
{
	import com.main_components.PubSlideshow;
	import com.main_components.PitchTracker;
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
	[SWF(width='640', height='640', frameRate='30', backgroundColor='0x9a9a9a')]
	public class Main extends Sprite 
	{
		//private var headerTabs:TabBar; //TODO class to add: about, faq, licence, contact, settings and other things ;)
		private var pitchTracker:PitchTracker;
		private var pub:PubSlideshow;
		
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
			var w:Number = stage.stageWidth * 0.8;
			var h:Number = stage.stageHeight ;// * 0.7;
			pitchTracker = new PitchTracker(w, h);
			addChild(pitchTracker);
			
			pub = new PubSlideshow(w * 0.2, stage.stageHeight);
			pub.x = stage.stageWidth * 0.8;
			pub.y = 0;
			addChild(pub);
		}
		
	}
	
}