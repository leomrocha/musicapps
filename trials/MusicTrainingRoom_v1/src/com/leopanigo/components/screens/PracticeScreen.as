package com.leopanigo.components.screens 
{
	import com.leopanigo.audio_processing.parameter_configuration.SpectAnalyzerParametrization;
	import com.leopanigo.audio_processing.SpectrumAnalyzer;
	import com.leopanigo.components.screens.sub_components.PracticeOptions;
	import com.leopanigo.components.screens.sub_components.PracticePlayMenu;
	import com.leopanigo.components.screens.sub_components.PracticeVisualization;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PracticeScreen extends Sprite 
	{
		private var _w:Number, _h:Number;
		
		private var playMenu:PracticePlayMenu;
		private var optionsMenu:PracticeOptions;
		private var visualization:PracticeVisualization;
		
		private var spect:SpectrumAnalyzer;
		
		public function PracticeScreen(w:Number, h:Number)
		{
			_w = w;
			_h = h;
			
			spect = new SpectrumAnalyzer();
			
			playMenu = new PracticePlayMenu(_w * 0.15, _h * 0.3);
			playMenu.x = 0;
			playMenu.y = 0;
			addChild(playMenu);
			
			optionsMenu = new PracticeOptions( _w * 0.03, _h * 0.3);
			optionsMenu.x = _w * 0.16;
			optionsMenu.y = 0;
			addChild(optionsMenu);
			
			visualization = new PracticeVisualization(_w * 0.9, _h * 0.6);
			visualization.x = _w * 0.1;
			visualization.y = _h * 0.6;
			addChild(visualization);
			
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		
		public function reconfigureParams(params:SpectAnalyzerParametrization):void
		{
			try {
				spect.stop();//just in case
			}catch(e:Error){}
			
			spect = new SpectrumAnalyzer();

		}
		
	}

}