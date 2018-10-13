package  com.gui_elements
{
	import com.audio_processing.NoteMapper;
	import com.music_concepts.Note;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class BottomButtonContainer extends Sprite 
	{
		private var buttonsVector:Vector.<GradientButton>;
		private var tunningsDict:Dictionary; // mapings between text (a name of the tunning) and a tunning
		private var defaultTunning:Vector.<Number> = new <Number>[82.41, 110.00, 146.83, 196.00, 246.94, 329.63];
		
		public function BottomButtonContainer() 
		{
			buttonsVector = new Vector.<GradientButton>();
			//tunningsDict = new Dictionqry();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			var nm:NoteMapper = new NoteMapper();
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var xpos:uint = 2;
			var step:Number = stage.stageWidth / 6.0;
			for each ( var n:Number in defaultTunning )
			{
				nm.updateFreq(n);
				var b:NoteSelectorButton = new NoteSelectorButton(nm.getNote(), step-5, 28);
				buttonsVector.push(b);
				addChild(b);
				b.x = xpos;
				b.y = 2;
				xpos += step ;
			}
			
		}	
		public function update(note:Note, errorCents:Number):void
		{
			for each(var b:NoteSelectorButton in buttonsVector)
			{
				b.update(note, errorCents);
			}
		}
	}

}