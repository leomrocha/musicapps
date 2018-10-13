package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
    [SWF(width='800', height='600', frameRate='15', backgroundColor='0xFFFFFF')]
	public class Main extends Sprite 
	{
		
		private var states:Dictionary; //contains the states in which the game takes place. Indexed by name
		private var levelLoader:LevelLoader; 
		private var currentStateName:String;
		private var prevStateName:String;
		private var stateChain:Dictionary; //for backlink tracking

		//private var mainMenu:MainMenu; 
		//screen dimensions -> to make calculations 
		private var x0:uint;
		private var y0:uint;
		private var widthScreen:uint;
		private var heightScreen:uint;
		
		private var START_STATE:String = "mainMenu";
		
		public function Main():void 
		{
			if (stage) init(); //WARNING!!! This is necessary to be sure about dimensions
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//Screen  Dimensions
			x0 = 0;
			y0 = 0;
			widthScreen = stage.stageWidth;
			heightScreen = stage.stageHeight;
			///////////
			//load levels
			levelLoader = new LevelLoader();
			//////////////////////////
			states = new Dictionary();
			stateChain = new Dictionary();
			//main Menu
			var mainmenu:MainMenu = new MainMenu();
			states["mainMenu"] = mainmenu;
			 //Settings
			var settingsScreen:SettingsScreen = new SettingsScreen();
			states["settingsScreen"] = settingsScreen;
			//choosing the instrument to play
			var instrumentSelectionScreen:PlayScreen = new PlayScreen();//TODO rename this to other more meaningful like: InstrumentSelectionScreen
			states["instrumentSelectionScreen"] = instrumentSelectionScreen;
			//choosing level
			var levelSelectionScreen:LevelSelectionScreen = new LevelSelectionScreen();
			states["levelSelectionScreen"] = levelSelectionScreen;
			//actual Game playing screen -> this is created for every game instance later ... i don't care know too much about speed as much as simplicity
			//var challengeScreen:ChallengeScreen = new ChallengeScreen(null, null);
			//states["challengeScreen"] = challengeScreen;
			//states["chooseInstrumentScreen"] = new ChooseInstrumentScreen();
			//////////////////////////
			prevStateName = START_STATE;
			currentStateName = START_STATE;
			changeState(START_STATE);
			//////////////////////////
			//start with the predefined state
			
			//listen to events
			mainmenu.addEventListener(GameEvent.CHANGE_GAME_STATE, onStateChangeEvent);
			instrumentSelectionScreen.addEventListener(InstrumentSelectedEvent.INSTRUMENT_SELECTED_EVENT, onInstrumentSelected);
			levelSelectionScreen.addEventListener(LevelSelectedEvent.LEVEL_SELECTED_EVENT, onLevelSelected);
			//back button
			instrumentSelectionScreen.addEventListener(GameEvent.BACK_BUTTON_EVENT, backButtonPressed);
			levelSelectionScreen.addEventListener(GameEvent.BACK_BUTTON_EVENT, backButtonPressed);
			//challengeScreen.addEventListener(GameEvent.BACK_BUTTON_EVENT, backButtonPressed);
			//TODO
			
		}
		
		private function backButtonPressed(e:GameEvent):void 
		{
			//trace("backButton Pressed");
			changeState(stateChain[currentStateName]);
		}
		
		private function onLevelSelected(e:LevelSelectedEvent):void 
		{
			//trace("level selected = ", e.levelName, e.instrument );
			//TODO
			//get level name,
			//load level
			var level:LevelSprite= levelLoader.loadLevel(e.instrument, e.levelName);
			//create the ChallengeScreen
			var challenge:ChallengeScreen = ChallengeScreenFactory.createChallenge(e.instrument, level);
			//pass to the Challenge Screen
			//challengeScreen = challenge;
			try {
				states["challengeScreen"].removeEventListener(GameEvent.BACK_BUTTON_EVENT, backButtonPressed);
			}catch (err:Error) { }
			
			states["challengeScreen"] = challenge;
			challenge.addEventListener(GameEvent.BACK_BUTTON_EVENT, backButtonPressed);
			changeState("challengeScreen");
		}
		
		private function onInstrumentSelected(e:InstrumentSelectedEvent):void 
		{
			var newStateName:String = "levelSelectionScreen";
			//trace("instrument selected = ", e.instrumentName);
			states[newStateName].instrument = e.instrumentName;//important for level loading later
			changeState(newStateName);
		}

		private function onStateChangeEvent(e:GameEvent):void
		{
			var newStateName:String = currentStateName;
			// depending on what arrives, select the new state
			newStateName = e.nextState;
			changeState(newStateName);
		}
		
		private function redimension(e:Event = null ):void
		{
			//recalculate dimensions
			x0 = 0;
			y0 = 0;
			widthScreen = stage.stageWidth;
			heightScreen = stage.stageHeight;
			//redimension and reposition all the current visible elements 
			states[currentStateName].redimension(widthScreen, heightScreen );
			states[currentStateName].width = widthScreen;
			states[currentStateName].height = heightScreen;
		}
		
		private function changeState(stateName:String):void
		{
			
			//erase old one
			if (states[currentStateName].parent!= null)
			{
				removeChild(states[currentStateName]);
			}
			//to avoid redrawing things
			try {
				//add new screen
				addChild(states[stateName]);
				//change names and redraw screen
				prevStateName = currentStateName;
				currentStateName = stateName;
				//create the tracking for back button! ->this works for 
				//		the first time the screen is accessed it creates the backlink
				//trace("state changed, now adding backlinks");
					if (stateChain.hasOwnProperty(currentStateName))
						{
							//trace("link exists");
					}else{
						//trace("creating backlink", prevStateName, currentStateName);
						stateChain[currentStateName] = prevStateName;
						//trace("backlink created", prevStateName, currentStateName);
					}
			}catch (err:Error)
			{
				//trace("adding child");
				addChild(states[currentStateName]);
			}
			//redimension (just in case the screen was not in the correct dimensions)
			states[currentStateName].redimension(widthScreen, heightScreen );
			//trace("states : ", currentStateName, prevStateName);
		}
		
		
	}
	
}