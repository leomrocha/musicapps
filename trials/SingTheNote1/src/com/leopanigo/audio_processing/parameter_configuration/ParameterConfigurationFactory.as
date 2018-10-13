package com.leopanigo.audio_processing.parameter_configuration 
{
	import com.leopanigo.components.events.InstrumentSelectedEvent;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class ParameterConfigurationFactory 
	{
		
		
		public static function getConfiguration(name:String):SpectAnalyzerParametrization
		{
			var ret:SpectAnalyzerParametrization;

			if (name == InstrumentSelectedEvent.INSTRUMENT_GUITAR_SELECTED)
			{
				ret =  new GuitarTunerParameters();
			}else if (name == InstrumentSelectedEvent.INSTRUMENT_VOICE_SELECTED)
			{
				ret = new VoiceAnalyzerParameters();
			}
			return ret;
			
		}
		//public function ParameterConfigurationFactory(name:String) 
		//{
			//
		//}
		
	}

}