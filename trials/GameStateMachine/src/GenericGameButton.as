package 
{
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.text.TextField;

	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class GenericGameButton extends Sprite 
	{
		private var simpleButton:SimpleButton;
		private var x0:Number;
		private var y0:Number;
		private var _bname:String;
		
		public function GenericGameButton (name:String, x0:Number, y0:Number )
		{
			this._bname = name;
			this.x0 = x0;
			this.y0 = y0;
			//create buttons
			if (stage) init(); //WARNING!!! This is necessary to be sure about dimensions
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, this.init);

			var simpleUpstateText:TextField =  new TextField();
			var simpleHoverText:TextField = new TextField(); 
			var simpleDownText:TextField = new TextField(); 
			simpleUpstateText.backgroundColor = 0x00000A;
			simpleHoverText.backgroundColor = 0x000A00;
			simpleDownText.backgroundColor = 0x02310A;
			simpleDownText.text = simpleHoverText.text = simpleUpstateText.text = _bname;
			simpleHoverText.textColor = 0xff0000;
			simpleDownText.textColor = 0xff7700;
			simpleButton = new SimpleButton();
			simpleButton.x = x0  - simpleButton.width /2;;
			simpleButton.y = y0 - simpleButton.height/2 - 50;
			simpleButton.upState = simpleUpstateText;
			simpleButton.overState = simpleHoverText;
			simpleButton.downState = simpleDownText;
			simpleButton.hitTestState = simpleHoverText;
			addChild(simpleButton);
		}
		
		public function get bname():String 
		{
			return _bname;
		}
	}
	
}