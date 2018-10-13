package 
{
	import com.leopanigo.audio_processing.parameter_configuration.ParameterConfigurationFactory;
	import com.leopanigo.audio_processing.parameter_configuration.SpectAnalyzerParametrization;
	import com.leopanigo.audio_processing.SpectrumAnalyzer;
	import com.leopanigo.components.screens.InstrumentSelectionScreen;
	import com.leopanigo.components.events.InstrumentSelectedEvent;
	import com.leopanigo.components.screens.MainScreen;
	import com.leopanigo.components.screens.PracticeScreen;
	import com.leopanigo.components.screens.TunerScreen;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	//different dimensions -> to test and see how it is seen on screen
	//[SWF(width='1200', height='800', frameRate='30', backgroundColor='0x050505')]
	[SWF(width='800', height='600', frameRate='30', backgroundColor='0x050505')]
	//[SWF(width='960', height='640', frameRate='30', backgroundColor='0x050505')]
	//[SWF(width='640', height='480', frameRate='30', backgroundColor='0x050505')]
	public class Main extends Sprite 
	{
		
		
		private var mainScreen:MainScreen;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			mainScreen = new MainScreen();
			addChild(mainScreen);
			
			
		}
		
	}
	
}