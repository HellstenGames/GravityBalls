﻿package  {
	
	import com.brinkbit.admob.AdMobAd;
	
	public class Constants 
	{
		public static var k_UpdatePerSecond:Number = 60;
		public static var k_UpdateTickPerFrame:Number = 1.0 / Constants.k_UpdatePerSecond;
		public static var k_DelayPeroid:Number = 0.25;
		
		public static var kFacebookShareLink = "https://www.facebook.com/pages/Gravity-Balls/546802842111874";
		
		/* Here Text Constants */
		public static var HT_TEXT:String = "Hold Me!";
		public static var HT_TEXT_AFTER:String = "Pull Me!";
		public static var HT_WIDTH:Number = 100;
		public static var HT_HEIGHT:Number = 15;
		public static var HT_FONTSIZE:int = 12;
		public static var HT_FONTTYPE:String = "popup";
		public static var HT_SCALE_MAX:Number = 1.25;
		public static var HT_SCALE_MIN:Number = 1.0;
		public static var HT_SCALE_SPEED:Number = 0.0025;
		
		/* Death Timer Constants */
		public static var DT_MAX_TIME:Number = 15;
		
		/* Pause Button Constants */
		public static var kpbPositionCX:Number = 25;
		public static var kpbPositionCY:Number = 295;
		
		/* Explode Button Constants */
		public static var kebPositionCX:Number = 115;
		public static var kebPositionCY:Number = 295;
		
		/* Focus Button Constants */
		public static var kfbPositionCX:Number = 70;
		public static var kfbPositionCY:Number = 295;
		
		/* Player Constants */
		public static var kPlayerNumBits:Number = 30;
		public static var kPlayerBitDXMax:Number = 200;
		public static var kPlayerBitDXMin:Number = -200;
		public static var kPlayerBitDYMax:Number = 200;
		public static var kPlayerBitDYMin:Number = -200;
		
		/* Bits Constants */
		public static var kBitFadeAwaySpeed:Number = 0.005;
		public static var kBitInertiaFactor:Number = 0.5;
		public static var kBitSize:Number = 2;
		public static var kBitMass:Number = 1.0;
		
		/* Sun Constants */
		public static var kSunMass:Number = 7.5*10e+3;
		
		/* Other Constants */
		public static var kFirstLevel:Number = 1;
		
		/** Position Constants **/
		
		
		/* Death Timer */
		public static var PS_DT_OFFSETX:Number = 0;
		public static var PS_DT_OFFSETY:Number = -20;
	
		/* Here Text */
		public static var PS_HT_OFFSETX:Number = 0;
		public static var PS_HT_OFFSETY:Number = -20;
		
		public static var START_SCENE_BANNER_ID:String = "ca-app-pub-2753474656261978/6802326443";
		public static var PLAY_SCENE_BANNER_ID:String = "ca-app-pub-2753474656261978/9755792842";
		public static var PLAY_SCENE_BANNER:AdMobAd, START_SCENE_BANNER:AdMobAd;
		
		public static var SCENE_MOVE_RATIO:Number = 1.0;
		public static var ZOOM_SCALE_AMOUNT:Number = 0.025;
		public static var ZOOM_MIN:Number = 0.1;
		public static var ZOOM_MAX:Number = 1.0;
		
		public static var kCameraWidth:int = 480;
		public static var kCameraHeight:int = 320;
		public static var kMapWidth:int = 0;
		public static var kMapHeight:int = 0;

		public static var kMapBoundaryBuffer:int = 50;

		public static var STAR_SCORE:int = 50;

		public static var DEATH_SUN_MESSAGES:Array = new Array("Ouch!", "ARghhhh!", "Incinerated!", "Toasty...", "Burn Baby!",
					"Burn!", "Eat it!", "You suck...", "WOW!", "Haha!", "LMAO!", "ROFL!", "Terrible...", "NOOOO!", "HELP!", "It burns!", "Horrible...", "WHAT!", "OMG!",
					"No way...", "WTF!", "Yep", "It hurts!", "I'm melting!", "STOP!", "Save me!", "Please", "The pain!",
					"Did you win?", "Death", "Die!", "Derp");
		
		public static var WIN_MESSAGES:Array = new Array("Zonk!", "WIN!", "Ohhh Yeah!", "Nice!", "WOOT!", 
					"Congrats!", "Impressive!", "Amazing!", "Sexy!", "Awesome!", "Cool!", "Wicked!", "Sick!", "Blackness...");
		
		public static var DEATH_ASTEROID_MESSAGES:Array = new Array("Splat!", "Smack!", "Boom!", "Crash!", "Slam!");
		public static var WALL_MESSAGES:Array = new Array("Bounce!", "Weee!", "Woah!", "Ding!");
		
		
		/* Credit Scene Constants */
		public static var k_BackButtonX:Number = 5;
		public static var k_BackButtonY:Number = 275;
		
		/* Play Scene Constants */
		public static var k_PauseOverlayX:Number = -100;
		public static var k_PauseOverlayY:Number = 0;
		public static var k_PauseOverlayWidth:Number = 100;
		public static var k_PauseOverlayHeight:Number = 320;
		public static var k_PauseOverlayInitRollSpeed:Number = 0;
		public static var k_PauseOverlayAcceleration:Number = 0.25;
		public static var k_PauseOverlayAlpha:Number = 1.0;
		public static var k_PauseOverlayColor:Number = 0xAABBAA;
		public static var k_PauseOverlayLineThickness:Number = 3.0;
		public static var k_PauseOverlayLineColor:Number = 0xCCCCCC;

		public static var k_DimLayerAlpha:Number = 0.25;
		public static var k_DimLayerWidth:Number = 480;
		public static var k_DimLayerHeight:Number = 320;
		
		public static var k_DeathTimerColor:Number = 0xFFFFFF;
		public static var k_DeathTimerDangerColor:Number = 0xFF0000;
		public static var k_DeathTimerDangerLimit:Number = 5.0;
		public static var k_DeathTimerNormalFontSize:Number = 14;
		public static var k_DeathTimerMaxDangerFontSize:Number = 40;
		public static var k_DeathTimerMinDangerFontSize:Number = 5;
		public static var k_DeathTimerMaxTime:Number = 10;
		
		public static function spitRandomMessage(messages:Array):String
		{
			var rand:int = Math.random() * messages.length;
			return messages[rand];
		}
	}
	
}
