package com.gui_elements 
{
	import com.music_concepts.Note;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class GraphicNote extends Sprite 
	{
		protected var _note:Note;
		
		public function GraphicNote(note:Note) 
		{
			_note = note;	
		}
		
	}

}