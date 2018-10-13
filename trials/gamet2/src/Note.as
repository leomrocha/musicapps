package 
{
	import adobe.utils.CustomActions;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class Note 
	{
		private var f0:Number;
		private var m_duration:Number;
		private var t0:Number;
		
		private var m_midinote:uint;
		private var m_name:String;
		private var m_octave:uint;
		
		public function Note( freq:Number, beginTime:Number, noteDuration:Number)
		{
			//m_midinote = midiNumber;
			t0 = beginTime;
			m_duration = noteDuration;
			//calculate frequency
			f0 = freq;
			//TODO
			//calculate name
			//TODO
			//calculate octave
			//TODO
		}
		
		//public function noteFromMidi( midi:uint):Note
		//{
			//var n:Note = new Note();
		//}
		
		public function get time():Number
		{
			return t0;
		}
		
		public function get freq():Number
		{
			return f0;
		}
		
		public function get duration():Number
		{
			return m_duration;
		}

		public function get midinote():uint
			{
			return m_midinote;	
			}
		
		public function get name():String
			{
				return m_name;
			}
			
		public function set name(n:String):void
			{
				m_name = n;
			}
		
			
		public function set octave(o:uint):void
			{
				m_octave = o;
			}
	}
	
}