package  
{
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class ChallengeScreenFactory 
	{
		public static const INSTRUMENT_VOICE:String = "voice";
		public static const INSTRUMENT_GUITAR:String = "guitar";
		public static const INSTRUMENT_BASS:String = "bass";
		//public const INSTRUMENT_:String = "";
		
		public function ChallengeScreenFactory() 
		{
			
		}
		
		public static function createChallenge(instrument:String, level:LevelSprite):ChallengeScreen
		{
			var challenge:ChallengeScreen;
			if (instrument == ChallengeScreenFactory.INSTRUMENT_VOICE)
			{
				challenge = new ChallengeScreen(instrument, level);
			}else if (instrument == ChallengeScreenFactory.INSTRUMENT_GUITAR)
			{
				challenge = new GuitarChallengeScreen(instrument, GuitarTabLevelSprite(level) );
			}
			
			return challenge;
		}
		
	}

}