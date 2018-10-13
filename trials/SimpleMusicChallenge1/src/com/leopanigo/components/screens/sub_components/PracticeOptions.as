package com.leopanigo.components.screens.sub_components 
{
	import com.leopanigo.components.buttons.GradientButton;
	import com.leopanigo.components.buttons.IconButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PracticeOptions extends Sprite 
	{
		private var _w:Number, _h:Number;
		
		
		private var soundOff:GradientButton;
		private var soundOn:GradientButton;
		
		//icons imagesC:\Users\Leonardo\projects\kitchen-drums\tests\PitchTracker2\assets\imgs\icons
		[Embed(source = "../../../../../../assets/imgs/icons/Mute_Icon_red.svg")]
		private var MuteIcon:Class;
		[Embed(source = "../../../../../../assets/imgs/icons/Speaker_Icon_light-blue.svg")]
		private var SpeakerIcon:Class;
		
		private var muteIcon:Sprite;
		private var speakerIcon:Sprite;
		
		public function PracticeOptions(w:Number, h:Number) 
		{
			_w = w;
			_h = h;
			
			var xpos:Number = _w * 0.1;
			var ypos:Number = _h * 0.1;
			var w:Number = _w * 0.8;
			var h:Number = _w*0.8;
			
			
			//speakerIcon = new SpeakerIcon();
			//speakerIcon.width = w;
			//speakerIcon.height = h;
			//speakerIcon.scaleX = 0.04;
			//speakerIcon.scaleY = 0.04;
			//
			//muteIcon = new MuteIcon();
			//muteIcon.width = w;
			//muteIcon.height = h;
			//muteIcon.scaleX = 0.04;
			//muteIcon.scaleY = 0.04;
			
			//soundOn = new IconButton(muteIcon,w ,h, 10, 0x303030, 0x5f5f5f); 
			soundOn = new GradientButton("sndOn",w ,h, 10, 0x303030, 0x5f5f5f); 
			soundOn.addEventListener(MouseEvent.CLICK, sndOnClicked);
			soundOn.x = xpos;
			soundOn.y = ypos;
			addChild(soundOn);
			
			//ypos += h*1.2;
			
			//soundOff = new IconButton(speakerIcon,w ,h, 10, 0x303030, 0x5f5f5f); 
			soundOff = new GradientButton("sndOff",w ,h, 10, 0x303030, 0x5f5f5f); 
			soundOff.addEventListener(MouseEvent.CLICK, sndOffClicked);
			soundOff.x = xpos;
			soundOff.y = ypos;
			//addChild(soundOff);
		}
		
		private function sndOnClicked(e:MouseEvent = null):void
		{
			//parent.soundOn();
			removeChild(soundOn);
			addChild(soundOff);
		}
		
		private function sndOffClicked(e:MouseEvent = null):void
		{
			//parent.soundOff();
			removeChild(soundOff);
			addChild(soundOn);
		}
		
	}

}