package 
{
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class GameCanvas extends Sprite 
	{
		
		private var spect:SpectrumAnalyzer;
		private var tfCanvas:TFGameCanvas;
		private var tabCanvas:TabCanvas; 
		private var levelLoader:LevelLoader;
		
		private var gameTimer:Timer;

		private const UPDATE_PERIOD:int = 50;


		private var stage_initialized:Boolean = true;
		
		
		public function GameCanvas()
		{
				this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		public function addedToStage(e:Event):void
		{
			trace("Added to stage");
			//BEGIN SCREEN resolution and size management
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//END  screen resolution fixation
			// tab exercise
			//tabCanvas = new TabCanvas(); //TODO
			levelLoader = new LevelLoader();
			//load level
			var level:Vector.<Note> = levelLoader.loadLevel(); //still dummy function that generates only one exercise
			//Frequency done and todo plot
			tfCanvas = new TFGameCanvas(level);
			addChild(tfCanvas);
			// spectrum and volume analyzer -> TODO plot volume and FFT (for user information)
			spect = new SpectrumAnalyzer();
			// volume plot -> Maybe is nice to compare it with the rest of the levels -> or can be used for some levels
			
			//start game
			//gameTimer = new Timer(UPDATE_PERIOD);
            //gameTimer.addEventListener(TimerEvent.TIMER, update);
            //gameTimer.start();
            stage.addEventListener(Event.ENTER_FRAME, update);

			spect.start();
			
		}
		
		public function update(e:Event):void
		{
			//if (!stage_initialized)
			//{
				//stage_initialized = true;
				//stage.scaleMode = StageScaleMode.NO_SCALE; // TODO put this somewhere that is better!!!
			//}
			//get freq
			var f:Number = spect.freq;
			//get volume
			var v:Number = spect.volume;
			
			tfCanvas.updateScreen(f);
			
		}
	}
	
}