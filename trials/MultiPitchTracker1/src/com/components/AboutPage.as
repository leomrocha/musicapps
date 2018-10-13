package com.components 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Leo Panigo
	 */
	public class AboutPage extends Sprite 
	{
		private var _w:Number, _h:Number;
		
		private var copyrightTxt:String = "©2012 (Leo Panigo) Leonardo Manuel Rocha  ";
		private var copyrightField:TextField;
		
		private var nameTxt:String = "Leo's Voice Trainer";
		private var nameField:TextField;
		
		private var versionTxt:String = " Version 0.3";
		private var versionField:TextField;
		
		private var logo:Sprite;
		
		private var descriptionTxt:String = "Leo's Voice Trainer is a simple application to track your voice and be able to see where and what mistake you did in entonation. This applicatin will continue growing. You can help making comments and leaving oppinions of what you will like added or modified in the app";
		private var descriptionField:TextField;
		
		private var licensingTxt:String = "© Leonardo M. Rocha (Leo Panigo)";
		private var licensingLink:String = "http://leopanigo.net/VoiceTrainerLicensing";
		private var licensingField:TextField;
		
		private var endUserRightsTxt:String = "";
		private var endUserRightsLink:String = "http://leopanigo.net/VoiceTrainerEndUserRights";
		private var endUserRightsField:TextField;
		
		private var privacyPolicyTxt:String = "";
		private var privacyPolicyLink:String = "http://leopanigo.net/VoiceTrainerEndUserRights";
		private var privacyPolicyField:TextField;
		
		public function AboutPage(w:Number = 640 , h:Number = 50) 
		{
			
			_w = w;
			_h = h;
			
			
				//text
				nameField = new TextField();
				nameField.wordWrap = true;
				//nameField.maxChars = 5;
				nameField.text = nameTxt;
				nameField.width = _w * 0.3;
				nameField.height = 20;
				nameField.x = _w * 0.5 - nameField.width / 2;
				nameField.y = _h * 0.1; 
				nameField.selectable = false;
				nameField.textColor = 0xFF6666;
				nameField.autoSize = TextFieldAutoSize.CENTER;
				addChild(nameField);
				
				versionField = new TextField();
				versionField.wordWrap = true;
				//nameField.maxChars = 5;
				versionField.text = versionTxt;
				versionField.width = _w * 0.3;
				versionField.height = 20;
				versionField.x = _w * 0.5 - nameField.width / 2;
				versionField.y = _h * 0.2; 
				versionField.selectable = false;
				versionField.textColor = 0xFFFF66;
				versionField.autoSize = TextFieldAutoSize.CENTER;
				addChild(versionField);
			
				descriptionField = new TextField();
				descriptionField.wordWrap = true;
				//nameField.maxChars = 5;
				descriptionField.text = descriptionTxt;
				descriptionField.width = _w * 0.8;
				descriptionField.height = 60;
				descriptionField.x = _w * 0.2;
				descriptionField.y = _h * 0.3; 
				descriptionField.selectable = false;
				descriptionField.textColor = 0xFFFF66;
				descriptionField.autoSize = TextFieldAutoSize.CENTER;
				addChild(descriptionField);
				
				copyrightField = new TextField();
				copyrightField.wordWrap = true;
				copyrightField.text = copyrightTxt;
				copyrightField.width = _w * 0.8;
				copyrightField.height = 20;
				copyrightField.x = _w * 0.3;
				copyrightField.y = 600;// _h * 0.9; 
				copyrightField.selectable = false;
				copyrightField.textColor = 0xBB9966;
				copyrightField.autoSize = TextFieldAutoSize.CENTER;
				addChild(copyrightField);
				
				
		}
		
	}

}