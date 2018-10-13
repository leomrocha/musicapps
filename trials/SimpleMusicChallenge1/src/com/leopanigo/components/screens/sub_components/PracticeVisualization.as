package com.leopanigo.components.screens.sub_components 
{
	//import com.leopanigo.components.displays.CentsErrorDisplay;
	//import com.leopanigo.components.displays.FrequencyAutoIntervalDisplay;
	//import com.leopanigo.components.displays.NoteDisplay;
	import com.leopanigo.components.displays.PseudoSheetMusicDisplay;
	import com.leopanigo.components.sprites.PseudoMusicSheetNote;
	import com.leopanigo.components.sprites.ScrollBar;
	import com.leopanigo.music_concepts.Note;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PracticeVisualization extends Sprite 
	{
		private var _w:Number, _h:Number;
		//TODO modify the displays to take multipitch information and also to show more than one source
		//TODO modify the displays to take time associated with the element
		//private var freqDisplay:FrequencyAutoIntervalDisplay;
		//private var centsErrorDisplay:CentsErrorDisplay;
		//private var noteDisplay:NoteDisplay;
		//private var scrollBar:ScrollBar;
		private var sheetDisplay:PseudoSheetMusicDisplay;
		
		private var _displayNotes:Vector.<Note>; //notes being displayed on screen
		private var _displayLevel:Vector.<Note>; //Notes of the current level
		
		private var  _MIN_FREQ:Number;// = 65.0;
		private var  _MAX_FREQ:Number; // = 1000.0;
		
		private var _level:Vector.<Note>;
		private var _currentPage:Vector.<Note>;
		private var _levelInitIndex:uint;
		private var _levelEndIndex:uint;
		
		private var _bpm:uint = 60;
		private var speedFactor:Number = 1; //multiplier for the time, with this I can change playing speed
		
		private var _secondsInDisplayNotes:Number = 6;
		private var _secondsInDisplayLevel:Number = 8;
		
		private var _currentInitTime:Number = 0;
		private var _currentTime:Number;
		
		public function PracticeVisualization(w:Number, h:Number, minFreq:Number, maxFreq:Number) 
		{
			_w = w;
			_h = h;
			MIN_FREQ = minFreq;
			MAX_FREQ = maxFreq;
			
			//if (stage) init();
			//else addEventListener(Event.ADDED_TO_STAGE, init);
		//}
		//
		//private function init(e:Event = null):void 
		//{
			//removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			sheetDisplay = new PseudoSheetMusicDisplay(_w, _h);
			sheetDisplay.MIN_FREQ = _MIN_FREQ;
			sheetDisplay.MAX_FREQ = _MAX_FREQ;
			//sheetDisplay.x = 0;
			//sheetDisplay.y = 0;
			addChild(sheetDisplay);
			
			sheetDisplay.setViewTimeInterval(_currentInitTime, _currentInitTime+ _secondsInDisplayLevel);
		}
		
		public function setLevel(level:Vector.<Note>):void
		{
			_currentInitTime = 0;
			
			_level = level;
			_levelInitIndex = 0;//TODO this index is to improve lookup for setNextPage
			_currentPage = new Vector.<Note>;
			
			//set the page
			setNextPage();
			
		}
		private function setNextPage():void
		{
			//for each(var e:Note in _currentPage)
			_currentPage = new Vector.<Note>;
			for (var i:uint = 0; i < _level.length; i++)
			{
				if (_level[i].initTime - _currentInitTime >= _secondsInDisplayLevel) break;
				if(_level[i].endTime > _currentInitTime) _currentPage.push(_level[i]);
			}
			sheetDisplay.setPage(_currentPage);
		}
		//the next played note
		public function update(note:Note):void
		{
			//Get current time
			_currentTime = note.endTime;
			if (_currentTime - _currentInitTime > _secondsInDisplayNotes)
			{
				_currentInitTime = _currentTime;
				//sheetDisplay.clear();
				//set the new level page
				setNextPage();
				sheetDisplay.setViewTimeInterval(_currentInitTime, _currentInitTime+_secondsInDisplayLevel);
			}
			sheetDisplay.update(note);
			
		}
		
		public function get MIN_FREQ():Number 
		{
			return _MIN_FREQ;
		}
		
		public function set MIN_FREQ(value:Number):void 
		{
			_MIN_FREQ = value;
		}
		
		public function get MAX_FREQ():Number 
		{
			return _MAX_FREQ;
		}
		
		public function set MAX_FREQ(value:Number):void 
		{
			_MAX_FREQ = value;
		}
		
	
	}

}