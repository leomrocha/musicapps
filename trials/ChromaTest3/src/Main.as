package 
{
	import com.audio_processing.SpectrumAnalyzerNew;
	import com.audio_processing.SpectrumEvent;
	import com.components.ChordDisplay;
	import com.components.ChromaDisplay;
	import com.components.FrequencyDisplay;
	import com.components.NotesScoreDisplay;
	import com.components.VolumeDisplay;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
		
	/**
	 * ...
	 * @author Leo Panigo
	 */
	[SWF(width = '1300', height = '700', frameRate = '30', backgroundColor = '0xeeeeee')]
	
	public class Main extends Sprite 
	{
		private var spect:SpectrumAnalyzerNew;
		//frequency
		private var freqDisplay:FrequencyDisplay;
		//chroma
		private var chromaDisplay:ChromaDisplay;
		//chroma colored for visual chord detection 
		private var chordDisplay:ChordDisplay;
		//notes over chroma scoring for chord detection ??
		private var notesScoreDisplay:NotesScoreDisplay;
		
		//volume
		private var volume:FrequencyDisplay;

		private var running:Boolean = false;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			spect = new SpectrumAnalyzerNew;
			
			volume = new FrequencyDisplay(300, 120, "Volume", 2, false, 100);
			volume.x = 305;
			volume.y = 0;
			addChild(volume);
			
			//chroma
			chromaDisplay = new ChromaDisplay(300, 350);
			chromaDisplay.x = 0;
			chromaDisplay.y = 0 ;
			addChild(chromaDisplay);
			
			//chord - chroma 2 ... in red
			chordDisplay = new ChordDisplay(300, 350);
			chordDisplay.x = 0;
			chordDisplay.y = 350;
			addChild(chordDisplay);
			
			//frequency
			freqDisplay = new FrequencyDisplay(310, 650);
			freqDisplay.x = 305;
			freqDisplay.y = 125;
			addChild(freqDisplay);
			
			notesScoreDisplay = new NotesScoreDisplay(300, 350, "Notes Score", 20);
			notesScoreDisplay.x = 620;
			notesScoreDisplay.y = 0;
			addChild(notesScoreDisplay);
			
			//add event listeners
			spect.addEventListener(SpectrumEvent.SPECTRUM_UPDATED_EVENT, onDataReady);

			this.addEventListener(MouseEvent.CLICK, onClick);

		}

		private function onClick(e:MouseEvent):void
		{
			if (!running)
			{
				spect.start();
				running = false;
			}
			else
			{
				spect.stop();
				running = true;
			}
		}
		
		private function onDataReady(e:SpectrumEvent):void
		{
			//volume
			volume.draw(e.volume);
			//frequency
			freqDisplay.draw(e.freq);
			//chromagram
			chromaDisplay.draw(e.chroma);
			//chroma in red
			chordDisplay.draw(e.chroma);
			//choma notes scores
			notesScoreDisplay.draw(e.chroma);
		}
	}
	
}