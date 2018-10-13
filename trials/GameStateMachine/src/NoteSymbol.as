package  
{
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class NoteSymbol 
	{	
		public static const REDONDA:uint = 3; //3 is to allow the TRECILLO in the representation...
		public static const BLANCA:uint = REDONDA*2;
		public static const NEGRA:uint = REDONDA*4;
		public static const CORCHEA:uint = REDONDA*8;
		public static const SEMI_CORCHEA:uint = REDONDA*16;
		public static const FUSA:uint = REDONDA*32;
		public static const SEMI_FUSA:uint = REDONDA*64;
		
		public static const TRECILLO_CORCHEA:uint = NEGRA/3;
		public static const TRECILLO_SEMI_CORCHEA:uint = CORCHEA/3;
		public static const TRECILLO_FUSA:uint = SEMI_CORCHEA/3;
		public static const TRECILLO_SEMI_FUSA:uint = FUSA/3;
	
		public static const TICK_BASE:uint = SEMI_FUSA;
		
		public function NoteSymbol() 
		{
			
		}
		
	}

}