package  com.leopanigo.components.buttons
{
	import com.audio_processing.NoteMapper;
	import com.audio_processing.ToneSynthesis;
	import com.music_concepts.Note;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class NoteSelectorButton extends  NoteGradientButton 
	{
		
		public function NoteSelectorButton(note:Note, w:uint=40, h:uint=30, r:uint=20 , color1:uint=0x04618d, color2:uint=0x379EE0) 
		{
			super(note, w, h, r, color1, color2);
			//_noteMapper = new NoteMapper();
			addEventListener(MouseEvent.CLICK, onCLick);
		}

		protected function onCLick(e:MouseEvent):void
		{
			//here display Menu TODO replace the sound!!
			trace("NoteSelector onClick");
			
		}
		
	}

}