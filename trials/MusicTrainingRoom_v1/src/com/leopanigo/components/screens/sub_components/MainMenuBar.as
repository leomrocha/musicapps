package com.leopanigo.components.screens.sub_components 
{
	import com.leopanigo.components.buttons.GradientButton;
	import com.leopanigo.components.screens.AboutPageScreen;
	import com.leopanigo.components.screens.BaseScreen;
	import com.leopanigo.components.screens.HelpScreen;
	import com.leopanigo.components.screens.MetronomeScreen;
	import com.leopanigo.components.screens.TunerScreen;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class MainMenuBar extends Sprite 
	{
		private var _w:Number, _h:Number;
		
		private var helpButton:GradientButton;
		private var aboutButton:GradientButton;
		private var metronomeButton:GradientButton; //TODO update to IconButton and add an icon
		private var tunerButton:GradientButton; //TODO same as before
		
		private var buttonsVector:Vector.<GradientButton>;
		private var contentButtonsVector:Array = ["?", "i", "m", "t"];
		
		
		private var _buttonC1:uint, _buttonC2:uint;
		
		//WARNING, I don't actually know how to do this, so I will add the screens to 
		//this menu bar, but I think they should belong to the MainScreen object
		
		private var tuner:TunerScreen;
		private var metronome:MetronomeScreen;
		private var about:AboutPageScreen;
		private var help:HelpScreen;
		
		private var screensVector:Vector.<Sprite>
		
		public function MainMenuBar(w:Number, h:Number,
									buttonColour1:uint = 0x303030,
									buttonColour2:uint = 0x5f5f5f)
		{
			_w = w;
			_h = h;
			_buttonC1 = buttonColour1;
			_buttonC2 = buttonColour2;
			screensVector = new Vector.<Sprite>;
			
			
			var w:Number = _w * 0.8;
			var h:Number = w;
			var xpos:Number = _w * 0.1;
			var yposBase:Number = _h * 0.05;
			var ystep:Number = h * 1.1;
			buttonsVector = new Vector.<GradientButton>;
			
			for (var i:uint = 0; i < contentButtonsVector.length; i++)
			{
				var b:GradientButton = new GradientButton(contentButtonsVector[i], w, h, 10, _buttonC1, _buttonC2);
				b.x = xpos;
				b.y = yposBase + ystep* (i + 1);
				addChild(b);
				buttonsVector.push(b);
			}
			helpButton = buttonsVector[0];
			helpButton.addEventListener(MouseEvent.CLICK, onHelpClicked);
			
			aboutButton = buttonsVector[1];
			aboutButton.addEventListener(MouseEvent.CLICK, onAboutClicked);
			
			metronomeButton = buttonsVector[2];
			metronomeButton.addEventListener(MouseEvent.CLICK, onMetronomeClicked);
			tunerButton = buttonsVector[3];
			tunerButton.addEventListener(MouseEvent.CLICK, onTunerClicked);
		}
		
		private function cleanScreen():void
		{
			for each(var s:Sprite in screensVector)
			{
				if (s.parent)
				{
					removeChild(s);
				}
				s = null;
			}
			screensVector = new Vector.<Sprite>;
		}
		
		private function onHelpClicked(e:MouseEvent):void
		{
			cleanScreen();
			//if (!help)
			{
				help = new HelpScreen(stage.stageWidth - _w, stage.stageHeight);
				help.x = _w;
				screensVector.push(help);
				addChild(help);
			}
			//if (! help.parent)
			//{
				//addChild(help);
			//}else {
				//removeChild(help);
				//help=null;
			//}
		}
		
		private function onAboutClicked(e:MouseEvent):void
		{
			cleanScreen();
			//if (!about)
			{
				about = new AboutPageScreen(stage.stageWidth - _w, stage.stageHeight);
				about.x = _w;
				screensVector.push(about);
				addChild(about);
			}
			//if (! about.parent)
			//{
				//addChild(about);
			//}else {
				//removeChild(about);
				//about=null;
			//}
		}
		
		private function onMetronomeClicked(e:MouseEvent):void
		{
			cleanScreen();
			//if (!metronome)
			{
				metronome = new MetronomeScreen(stage.stageWidth - _w, stage.stageHeight);
				metronome.x = _w;
				screensVector.push(metronome);
				addChild(metronome);
			}
			//if (! metronome.parent)
			//{
				//addChild(metronome);
			//}else {
				//removeChild(metronome);
				//metronome=null;
			//}
		}
		
		private function onTunerClicked(e:MouseEvent):void
		{
			cleanScreen();
			//if (!tuner)
			{
				tuner = new TunerScreen(stage.stageWidth - _w, stage.stageHeight);
				tuner.x = _w;
				screensVector.push(tuner);
				addChild(tuner);
			}
			//if (!tuner.parent)
			//{
				//addChild(tuner);
			//}else {
				//removeChild(tuner);
				//tuner=null;
			//}
		}
		
	}

}