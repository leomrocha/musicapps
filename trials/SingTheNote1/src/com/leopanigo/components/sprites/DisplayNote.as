
package com.leopanigo.components.sprites 
{
	import com.leopanigo.music_concepts.Note;
	import com.leopanigo.music_concepts.NotesNameMapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class DisplayNote extends Sprite 
	{
		private var _w:Number, _h:Number;
		private var _note:Note;
		private var _drawLine:Boolean;
		private var _img:Sprite; //to hold the nice image to show
		
		//accidentals
		//private var _sharp:Shape; //if needed
		//private var _flat:Shape; //if needed
		
		[Embed(source = "../../../../../assets/whole_note_grey.svg")]
		private var WholeNote:Class;
		[Embed(source = "../../../../../assets/whole_note_line_grey.svg")]
		private var WholeNoteLine:Class;
		[Embed(source = "../../../../../assets/sharp_note_grey.svg")]
		private var SharpNote:Class;
		[Embed(source = "../../../../../assets/sharp_note_line_grey.svg")]
		private var SharpNoteLine:Class;
		[Embed(source = "../../../../../assets/flat_note_grey.svg")]
		private var FlatNote:Class;
		[Embed(source = "../../../../../assets/flat_note_line_grey.svg")]
		private var FlatNoteLine:Class;
		
		
		public function DisplayNote(w:Number,h:Number, note:Note, drawLine:Boolean = false) 
		{
			_w = w;
			_h = h;
			_note = note;
			_drawLine = drawLine;
			
			redraw();
		}
		
		private function redraw():void
		{
			//_img = new Sprite();
			if (NotesNameMapping.IS_SHARP[_note.name])
			{
				if (_drawLine)
				{
					_img = new SharpNoteLine();
				}else {
					_img = new SharpNote();
				}
			}else if (NotesNameMapping.IS_FLAT[_note.name])
			{
				if (_drawLine)
				{
					_img = new FlatNoteLine();
				}else {
					_img = new FlatNote();
				}
			}
			else{
				if (_drawLine)
				{
					_img = new WholeNoteLine();
				}else {
					_img = new WholeNote();
				}
			}
			_img.width = _w;
			_img.height = _h;
			_img.scaleX = _w / 15.0;// * 5/ 100.0;
			_img.scaleY = _h / 15.0;// * 5 / 100.0;
			addChild(_img);

		}
		
		
	}

}