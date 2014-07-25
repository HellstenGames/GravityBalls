﻿package  {
	
	public class Constants 
	{
	
		public static var STAR_SCORE:int = 50;

		public static var DEATH_SUN_MESSAGES:Array = new Array("Ouch!", "ARghhhh!", "Incinerated!", "Toasty...", "Burn Baby!",
					"Burn!", "Eat it!", "You suck...", "WOW!", "Haha!", "LMAO!", "ROFL!", "Terrible...", "NOOOO!", "HELP!");
		
		public static var WIN_MESSAGES:Array = new Array("Zonk!", "WIN!", "Ohhh Yeah!", "Nice!", "WOOT!", 
					"Congrats!", "Impressive!", "Amazing!", "Sexy!", "Awesome!", "Cool!", "Wicked!", "Sick!", "Blackness...");
		
		public static var DEATH_ASTEROID_MESSAGES:Array = new Array("Splat!", "Smack!", "Boom!", "Crash!", "Slam!");
		public static var WALL_MESSAGES:Array = new Array("Bounce!", "Weee!", "Woah!", "Ding!");
		
		public static function spitRandomMessage(messages:Array):String
		{
			var rand:int = Math.random() * messages.length;
			return messages[rand];
		}
	}
	
}
