package com.components 
{
	import flash.display.Sprite;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	//import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	import flash.utils.Timer;

	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class PubSlideshow extends Sprite 
	{
		private var _w:Number, _h:Number;
		private var xml:XML;
		private var urlLoader:URLLoader;
		private var imgLoaders:Vector.<Loader>;
		//private static const XML_PATH:String = "slideshow.xml"	
		private static const XML_PATH:String = "http://leopanigo.net/wp-content/uploads/2012/11/slideshow_leopanigo_tuner.png"	
		private var images:Array;
		private var imageSource:Vector.<String>;
		//private var imageURLs:Vector.<URLRequest>;
		private var imageReady:Vector.<Boolean>;
		private var links:Vector.<String>;
		private var titles:Vector.<String>;
		
		private var message:TextField;
		
		private var imgIndex:uint = 0;		
		private var totalImgCount:uint;
		private var imgCount:uint = 0;
		private var timer:Timer;
		private var timerDelay:Number = 2500;
		
		private var imgContainer:Array;
		
		private var initialized:Boolean;
		
		public function PubSlideshow(w:Number, h:Number ) {
			_w = w;
			_h = h;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			initialized = false;

		}	

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//load XML
			urlLoader = new URLLoader();
			images = new Array();
			imageSource = new Vector.<String>;
			//imageURLs = new Vector.<URLRequest>;
			links = new Vector.<String>();
			titles = new Vector.<String>();
			imageReady = new Vector.<Boolean>();
			
			imgContainer = new Array();
			
			imgLoaders = new Vector.<Loader>();
			
			message = new TextField(); //for showing messages to the user
			message.selectable = false;
			message.background = 0x000000;
			message.opaqueBackground = true;
			//message.alpha = 0.2;
			message.doubleClickEnabled = false;
			message.border = true;
			
			message.textColor = 0xffff00;
			
			//message.borderColor = 0x000000;
			
			this.buttonMode = true; //enable button mode
			
			urlLoader.load(new URLRequest(XML_PATH));
			urlLoader.addEventListener(Event.COMPLETE, loadXML);
			nextImage();
			timer = new Timer(timerDelay);
			timer.addEventListener(TimerEvent.TIMER, nextImage);
			//on Mouse Over: show text link!!
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			addEventListener(MouseEvent.CLICK, onMouseClick);
			
		}
		
		private function onRollOver(e:MouseEvent = null):void
		{
			//add the message at the mouse position
			message.text = titles[imgIndex];
			
			addChild(message);
			onMouseMove();
			
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onRollOut(e:MouseEvent=null):void
		{
			removeChild(message);
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent = null):void
		{
			//get position of the mouse
			//move the message
			message.text = titles[imgIndex];
			message.width = message.textWidth * 1.1 ;
			message.height = message.textHeight * 1.4;
			message.scaleX = 1;
			message.scaleY = 1;
			
			message.x =  mouseX - message.width /2 ; //e.localX;
			message.y = mouseY - message.height  - 5; // e.localY;
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			//get the address
			//open new tab or window with the link
			var targetURL:URLRequest = new URLRequest(links[imgIndex]);
			navigateToURL(targetURL); //does not work!!
			//if (ExternalInterface.available)
			//{
				//ExternalInterface.call("window.open", targetURL.url); //this works!! but only on a web browser and not as AIR application :/
			//}
			
		}
		
		
		private function loadXML(e:Event):void 
		{
			//display hole content from XML
			xml = new XML(e.target.data);	
			totalImgCount = xml.image.length();			
			
			for (var i:uint = 0; i < totalImgCount; i++) {
				
				var imloader:Loader = new Loader();
				trace("Setting for load: ",  xml.image[i].@src, xml.image[i].@title, xml.image[i].@href) ;
				var src:String = xml.image[i].@src;
				var urlrq:URLRequest = new URLRequest(src);
				imageSource.push(src);
				//imageURLs.push(urlrq);
				links.push(xml.image[i].@href);
				titles.push(xml.image[i].@title);
				imageReady.push(false);
				
				imgLoaders.push(imloader);
				
				imloader.load(urlrq);
				imloader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadingError);
				imloader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
			}
		}		

		private function loadingError(e:IOErrorEvent):void
		{
			trace("There has been an error loading one image.");
		}
		
		private function imageLoaded(e:Event): void
		{
			imgCount++;
			trace("image loaded, now checking things");
			trace("imageSource.length ", imageSource.length);
			trace("things: ", e.target.url, e.target.content );
			
			for (var i:uint = 0; i < imageSource.length; i++ )
			{
				trace("imageSource[i]: ", imageSource[i]);
				///WARNING!! awfull code
				if (imageSource[i] == e.target.url.substr(e.target.url.length - imageSource[i].length, e.target.url.length) ) //TODO find a better way to do this!!!! this is disgustingly awful
				{
					images[i] = e.target.content;
					imageReady[i] = true;
					break; //already found the object
				}
			}
			if (i >= imageSource.length)
			{
				trace("ERROR: the image source was not found");
			}
			if (imgCount >= totalImgCount) //TODO make a fail tolerant mechanism!!
			{
				trace("PubSlideshow initialized !!");
				initialized = true;
			}
			if (!timer.running)
			{
				trace("start pub timer");
				timer.start();
			}
		}
		
		private function nextImage(e:TimerEvent = null):void
		{
			//trace("next image ", imgCount);
			var prevIndex:uint = imgIndex;
			var secCount:uint = 0;
			while (secCount < totalImgCount *2)
			{
				prevIndex = imgIndex;
				imgIndex++;
				imgIndex = imgIndex % totalImgCount; //to loop thourgh images
				if (imgIndex < imageReady.length && imageReady[imgIndex])
				{
					tweenImage(prevIndex, imgIndex);
					break;
				}
				secCount++;
			}
		}	
		private function tweenImage(currentIndex:uint, nextIndex:uint):void
		{
			//trace("tween images");
			images[imgIndex].alpha = 0;
			addChild(images[nextIndex]);
			//check that the message, if being displayed, stays at top
			if (message.parent)
			{
				//message.text = titles[imgIndex];
				//setChildIndex(message, 0);
				//TweenMax.to(message, 1, { text:titles[nextIndex] } );
				onRollOut();
				onRollOver();
			}
			//trace("tween images");
			TweenMax.to(images[nextIndex], 1, { alpha:1 } );
			
			if (images[currentIndex].parent)
			{
				//trace("tween images");
				try
				{
					removeChild(images[currentIndex]);
				}catch (e:Error)
				{
					trace("catching error from remove child");
				}
			}
		}
	}	
	
}
