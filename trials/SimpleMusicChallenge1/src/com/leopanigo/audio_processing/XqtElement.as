package com.leopanigo.audio_processing 
{
	/**
	 * ...
	 * @author Leo Panigo
	 * An element that is usefull only for calculating the approximation to the constant Q transform
	 */
	public class XqtElement 
	{
		
		public var noteName:String; //
		public var noteFreq:Number; // frequency of this element
		public var pos:uint; //position in the HPS vector
		public var span:uint;
		public var initPos:uint; //pos - span 
		public var endPos:uint; //pos+span+1
		public var value:Number; //value after the sum calculation, the result of the approximation
	}

}