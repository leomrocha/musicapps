package com.leopanigo.components.screens.sub_components 
{
	import com.leopanigo.components.displays.CentsErrorDisplay;
	import com.leopanigo.components.displays.FrequencyAutoIntervalDisplay;
	import com.leopanigo.components.displays.NoteDisplay;
	import com.leopanigo.components.displays.PseudoSheetMusicDisplay;
	import com.leopanigo.components.sprites.ScrollBar;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PracticeVisualization extends Sprite 
	{
		//TODO modify the displays to take multipitch information and also to show more than one source
		//TODO modify the displays to take time associated with the element
		private var freqDisplay:FrequencyAutoIntervalDisplay;
		private var centsErrorDisplay:CentsErrorDisplay;
		private var noteDisplay:NoteDisplay;
		private var scrollBar:ScrollBar;
		private var sheetDisplay:PseudoSheetMusicDisplay;
		
		
		public function PracticeVisualization(w:Number, h:Number) 
		{
			_w = w;
			_h = h;
			
		}
		
	}

}