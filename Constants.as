package  {
	
	import com.brinkbit.admob.AdMobAd;
	
	public class Constants 
	{
	
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

		public static var kMapBoundaryBuffer:int = 100;

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
