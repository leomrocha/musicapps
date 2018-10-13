package com.leopanigo.components.screens 
{
	import com.leopanigo.audio_processing.parameter_configuration.ParameterConfigurationFactory;
	import com.leopanigo.audio_processing.parameter_configuration.SpectAnalyzerParametrization;
	import com.leopanigo.components.events.InstrumentSelectedEvent;
	import com.leopanigo.components.screens.sub_components.MainMenuBar;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class MainScreen extends Sprite 
	{
		
		
		private var instrumentSelection:InstrumentSelectionScreen;
		
		private var practiceScreen:PracticeScreen;
		
		private var mainMenu:MainMenuBar;
		
		//private var tuner:TunerScreen;
		
		
		public function MainScreen():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//spect = new SpectrumAnalyzer();
			//test for tuner
			var w:Number = stage.stageWidth - 30; //leave 20 pixels at left for something e.g. a menu for opening tuner and other things
			var h:Number =  stage.stageHeight - 20; //leave enough for something e.g. pub
			
			mainMenu = new MainMenuBar(30, h);
			mainMenu.x = 0;
			mainMenu.y = 20;
			addChild(mainMenu);
			
			//tuner = new TunerScreen(w,h);
			//tuner.x = 0;
			//tuner. y = 0;
			//addChild(tuner);
			
			practiceScreen = new PracticeScreen(w,h);
			practiceScreen.x = 0;
			practiceScreen.y = 0;
			addChild(practiceScreen);
			
			instrumentSelection = new InstrumentSelectionScreen(w, h);
			//instrumentSelection.x = 0;
			//instrumentSelection.y = 0;
			instrumentSelection.addEventListener(InstrumentSelectedEvent.INSTRUMENT_SELECTED_EVENT, onInstrumentSelected);
			addChild(instrumentSelection)//must be the last added, in order to put the choice to the user
			
		}
		
		private function onInstrumentSelected(e:InstrumentSelectedEvent):void
		{
			removeChild(instrumentSelection);
			//now I could destroy the screen for memory preserving
			//instrumentSelection = null;
			
			//reparametrinzation of the spectrum analyzer for best matching the choosen instrument
			var params:SpectAnalyzerParametrization = ParameterConfigurationFactory.getConfiguration(e.name);
			practiceScreen.reconfigureParams(params);
		}
		
	}

}