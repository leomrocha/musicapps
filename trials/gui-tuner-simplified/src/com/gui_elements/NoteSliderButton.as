package  com.gui_elements
{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import com.audio_processing.ToneSynthesis;
	import com.music_concepts.Note;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class NoteSliderButton extends NoteGradientButton
	{
		
		public function NoteSliderButton(note:Note, w:uint=40, h:uint=30, r:uint=20, color1:uint=0x04618d, color2:uint=0x379EE0)
		{
			super(note, w, h, r ,color1, color2);	
			addEventListener(MouseEvent.CLICK, onCLick);

		}
		
		protected function onCLick(e:MouseEvent):void
		{
			var toneSynthesis:ToneSynthesis = new ToneSynthesis(_note.freq);
			toneSynthesis.play();
			//trace("calling audio syntehsis");
		}
	}

}