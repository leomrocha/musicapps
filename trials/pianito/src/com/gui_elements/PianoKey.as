package  com.gui_elements 
{
	import com.audio_processing.ToneSynthesis;
	import com.music_concepts.Note;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PianoKey extends NoteGradientButton 
	{
		protected var _whiteColor2:uint  = 0xffffff;
		protected var _whiteColor1:uint = 0xaaaaaa;
		protected var _blackColor1:uint  = 0x000000;
		protected var _blackColor2:uint = 0x0a0a0a;
		protected var toneSynthesis:ToneSynthesis;
		//whole means Do, Re, Mi, Fa, Sol, La, Si keys, the sharp (or flat) are half notes
		public function PianoKey(note:Note, w:uint=40, h:uint=30, r:uint=10) 
		{
			var color1:uint;
			var color2:uint;
			
			//type selection ... black or white
			if(note.wholeNote)
			{
				color1 = _whiteColor1;
				color2 = _whiteColor2;
			}
			else
			{
				color1 = _blackColor1;
				color2 = _blackColor2;
			}
			super(note, w, h, r, color1, color2);
			addEventListener(MouseEvent.CLICK, onCLick);
			toneSynthesis = new ToneSynthesis(_note.freq);
		}
		//protected override function init(e:Event = null):void
		//{
//
			//removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			//setProperties();
			//this.buttonMode = true;
			//
			//drawGradient();
//
			//this.width  = _w;
			//this.height = _h;
			//this.scaleX = 1;
			//this.scaleY = 1;
			//
			//this.addEventListener(MouseEvent.MOUSE_OVER, startAnimatingGradient);
			//this.addEventListener(MouseEvent.MOUSE_OUT, resetAnimatingGradient);
		//}
		
		protected override function setProperties():void
		{
			//just overriding to avoid writing the names!!
		}
		
		protected function onCLick(e:MouseEvent):void
		{
			//startAnimatingGradient();
			//TODO send signal that indicates the note played!!!
			//now play the sound
			
			toneSynthesis.play();
			//resetAnimatingGradient();
		}
	}

}