package com.leopanigo.components.screens.sub_components 
{
	import com.leopanigo.audio_processing.MP3Analyzer;
	import com.leopanigo.components.buttons.GradientButton;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PracticeSelectSource extends Sprite 
	{
		private var _w:Number, _h:Number;

		
		private var selectSourceButton:GradientButton;
		private var fileRef:FileReference;
		private var loader:Loader;
		private var mp3analyzer:MP3Analyzer;
		
		public function PracticeSelectSource(w:Number, h:Number)
		{
			_w = w;
			_h = h;
			
			selectSourceButton = new GradientButton("SelectSource", 40, 20);
			addChild(selectSourceButton);
			selectSourceButton.addEventListener(MouseEvent.CLICK, onSelect);
			mp3analyzer = new MP3Analyzer();
		}
		
		private function onSelect(e:MouseEvent):void
		{
            fileRef = new FileReference(); 
			loader = new Loader();
			
            fileRef.addEventListener(Event.SELECT, onFileSelected); 
            fileRef.addEventListener(Event.CANCEL, onCancel); 
            fileRef.addEventListener(IOErrorEvent.IO_ERROR, onIOError); 
            fileRef.addEventListener(SecurityErrorEvent.SECURITY_ERROR, 
                        onSecurityError); 
            var textTypeFilter:FileFilter = new FileFilter("Audio Files (*.mp3)", 
                        "*.mp3"); 
            fileRef.browse([textTypeFilter]); 
		}
		
		public function onFileSelected(evt:Event):void 
        { 
			fileRef.removeEventListener(Event.SELECT, onFileSelected); 
            fileRef.addEventListener(ProgressEvent.PROGRESS, onProgress); 
            fileRef.addEventListener(Event.COMPLETE, onComplete); 
            fileRef.load(); 
        } 
 
        private  function onProgress(evt:ProgressEvent):void 
        { 
            trace("MP3 Loaded " + evt.bytesLoaded + " of " + evt.bytesTotal + " bytes."); 
        } 
 
        private  function onComplete(evt:Event):void 
        { 
			fileRef.removeEventListener(Event.CANCEL, onCancel); 
            fileRef.removeEventListener(IOErrorEvent.IO_ERROR, onIOError); 
            fileRef.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, 
                        onSecurityError); 
			fileRef.removeEventListener(ProgressEvent.PROGRESS, onProgress); 
            fileRef.removeEventListener(Event.COMPLETE, onComplete); 
            trace("File was successfully loaded."); 
			trace(fileRef.name);
            trace(fileRef.type); 
			//now do some magic to be able to transform the loaded reference into a sound!! weird!!
			loader.loadBytes(fileRef.data); 
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete);
			
        } 
 
		private function onLoaderComplete(e:Event):void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onLoaderComplete);
			var snd:Sound = e.target as Sound;//TODO this fails and I don't know why!! the target is there and is a sound object, but the assignment does not work
			mp3analyzer.analyzeMP3FromSound(snd);
		}
		
        private  function onCancel(evt:Event):void 
        { 
            trace("The browse request was canceled by the user."); 
        } 
 
        private  function onIOError(evt:IOErrorEvent):void 
        { 
            trace("There was an IO Error."); 
        } 
        private  function onSecurityError(evt:Event):void 
        { 
            trace("There was a security error."); 
        } 
		
	}

}