package 
{
	import com.components.AboutPage;
	import com.gui_elements.GradientButton;
	import com.gui_elements.IconButton;
	import com.gui_elements.PlayButton;
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
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	//[SWF(width = "320", height = "480")]
	[SWF(width='640', height='640', frameRate='30', backgroundColor='0x000000')]
	public class Main extends Sprite 
	{
		//private var headerTabs:TabBar; //TODO class to add: about, faq, licence, contact, settings and other things ;)
		private var pitchTracker:PitchTracker;
		private var pub:PubSlideshow;
		private var aboutButton:GradientButton;
		private var backButton:GradientButton;
		private var aboutPage:AboutPage;
		
		
		//[Embed(source = "../assets/imgs/blackBackground_simple_640x640.svg")]
		[Embed(source = "../assets/imgs/blackBackground_not-so-anoying.svg")]
		private var B:Class;
		
		private var b:Sprite;
		
		//[Embed(source = "../assets/imgs/icons/Circle-question-blue.svg")]
		//private var Icon:Class;
		//private var icon:Sprite;
		
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
			
			var w:Number = stage.stageWidth * 0.8;
			var h:Number = stage.stageHeight ;// * 0.7;
			pitchTracker = new PitchTracker(w, h);
			addChild(pitchTracker);
			
			pub = new PubSlideshow(w * 0.2, stage.stageHeight);
			pub.x = stage.stageWidth * 0.8;
			pub.y = 0;
			addChild(pub);
			
			aboutPage = new AboutPage(stage.stageWidth*0.8, stage.stageHeight);
			//aboutPage.x = 0;
			//aboutPage.y = 20;
			//icon = new Icon();
			//icon.width = 20;
			//icon.height = 20;
			//icon.scaleX = 0.015;
			//icon.scaleY = 0.015;
			//icon.alpha = 0.9;
			
			//aboutButton = new IconButton(icon, 20, 20, 10, 0x050505, 0x101010);
			aboutButton = new GradientButton("i", 15, 20, 10, 0x050505, 0x101010);
			aboutButton.x = stage.stageWidth * 0.8  - 30;
			aboutButton.y = 2;
			addChild(aboutButton);
			aboutButton.addEventListener(MouseEvent.CLICK, onAbout);
			
			
			backButton = new PlayButton(30, 20, 5, 0x050505, 0x101010, PlayButton.BUTTON_DIRECTION_LEFT);
			backButton.x = 10;// stage.stageWidth * 0.8  - 40;
			backButton.y = 5;
			//addChild(backButton);
			backButton.addEventListener(MouseEvent.CLICK, onBack);
		}
		
		private function onBack(e:MouseEvent):void
		{
			aboutButton.alpha = 0;
			pitchTracker.alpha = 0;
			
			addChild(pitchTracker);
			addChild(aboutButton);
			//TweenMax.to(aboutPage, 1, { alpha:0.8 } );
			TweenMax.allTo([pitchTracker, aboutButton], 1, { alpha:1} );
			
			removeChild(backButton);
			removeChild(aboutPage);
			
			//removeChild();
		}
		
		private function onAbout(e:MouseEvent):void
		{
			aboutPage.alpha = 0;
			addChild(aboutPage);
			
			TweenMax.to(aboutPage, 1, { alpha:0.8 } );
			
			addChild(backButton);
			
			removeChild(pitchTracker);
			removeChild(aboutButton);
			//removeChild();
		}
	}
	
}