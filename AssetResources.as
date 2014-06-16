package  {
	// Import starling stuff
	import starling.utils.AssetManager;
	import starling.core.Starling;
	import starling.textures.Texture;
	import starling.display.Image;
	
	// Import flash stuff
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.filesystem.File;
	
	public class AssetResources {

		// Constants
		public static var NUM_OF_LEVELS:uint = 2;
		
		private static var ASSETS_MANAGER:AssetManager;
		private static var CALL_BACK:Function;
		
		public static var splashTheme:Sound, menuTheme:Sound, playTheme:Sound, sandboxTheme:Sound;
		public static var sunCollisionSound:Sound, projectileCollisionSound:Sound, 
						  pointCollisionSound:Sound, blackHoleCollisionSound:Sound;
		
		public static var splashTexture:Texture, backgroundTexture:Texture;
		public static var blueProjectileTexture:Texture, greenProjectileTexture:Texture, redProjectileTexture:Texture;
		public static var sunTexture:Texture, blackHoleTexture:Texture;
		public static var resetButtonTexture:Texture, contractButtonTexture:Texture;
		public static var exitBallTexture:Texture, playBallTexture:Texture, sandboxBallTexture:Texture;
		public static var exitTextTexture:Texture, playTextTexture:Texture, sandboxTextTexture:Texture;
		
		public static var levels:Array;
		
		public static function setOnLoadComplete(f:Function)
		{
			AssetResources.CALL_BACK = f;
		}
		
		public static function init():void
		{
			// Set up assets manager
			ASSETS_MANAGER = new AssetManager(Starling.contentScaleFactor);
			ASSETS_MANAGER.verbose = true;
			
			// Load assets/textures/sounds/etc using asset manager
			var appDir:File = File.applicationDirectory;
			ASSETS_MANAGER.enqueue(appDir.resolvePath("assets/x" + String(Starling.contentScaleFactor)));
			ASSETS_MANAGER.enqueue(appDir.resolvePath("assets/sfx"));
			ASSETS_MANAGER.enqueue(appDir.resolvePath("assets/gfx"));
			ASSETS_MANAGER.enqueue(appDir.resolvePath("assets/levels"));
			
			ASSETS_MANAGER.loadQueue(function(ratio:Number):void
			{
				trace("Loading assets, progress:", ratio);
				
				if (ratio == 1.0)
				{
					var sf:String = String(Starling.contentScaleFactor);
					
					// Set up themes
					AssetResources.splashTheme = AssetResources.ASSETS_MANAGER.getSound("splashtheme");
					AssetResources.menuTheme = AssetResources.ASSETS_MANAGER.getSound("menutheme");
					AssetResources.playTheme = AssetResources.ASSETS_MANAGER.getSound("playtheme");
					AssetResources.sandboxTheme = AssetResources.ASSETS_MANAGER.getSound("soundboxtheme");
					
					// Set up sound effects
					AssetResources.sunCollisionSound = AssetResources.ASSETS_MANAGER.getSound("sun_collision");
					AssetResources.projectileCollisionSound = AssetResources.ASSETS_MANAGER.getSound("projectile_collision");
					AssetResources.pointCollisionSound = AssetResources.ASSETS_MANAGER.getSound("point_collision");
					AssetResources.blackHoleCollisionSound = AssetResources.ASSETS_MANAGER.getSound("black_hole_collision");

					// Set up textures
					AssetResources.splashTexture = AssetResources.ASSETS_MANAGER.getTexture("splashscreen_x" + sf);
					AssetResources.backgroundTexture = AssetResources.ASSETS_MANAGER.getTexture("background_x" + sf);
					AssetResources.blueProjectileTexture = AssetResources.ASSETS_MANAGER.getTexture("blue_projectile_x" + sf);
					AssetResources.greenProjectileTexture = AssetResources.ASSETS_MANAGER.getTexture("green_projectile_x" + sf);
					AssetResources.redProjectileTexture = AssetResources.ASSETS_MANAGER.getTexture("red_projectile_x" + sf);
					AssetResources.sunTexture = AssetResources.ASSETS_MANAGER.getTexture("sun_x" + sf);
					AssetResources.blackHoleTexture = AssetResources.ASSETS_MANAGER.getTexture("sun_x" + sf);
					
					AssetResources.exitBallTexture = AssetResources.ASSETS_MANAGER.getTexture("exit_ball_x" + sf);
					AssetResources.playBallTexture = AssetResources.ASSETS_MANAGER.getTexture("play_ball_x" + sf);
					AssetResources.sandboxBallTexture = AssetResources.ASSETS_MANAGER.getTexture("sandbox_ball_x" + sf);
					
					AssetResources.exitTextTexture = AssetResources.ASSETS_MANAGER.getTexture("exit_text_x" + sf);
					AssetResources.playTextTexture = AssetResources.ASSETS_MANAGER.getTexture("play_text_x" + sf);
					AssetResources.sandboxTextTexture = AssetResources.ASSETS_MANAGER.getTexture("sandbox_text_x" + sf);

					AssetResources.resetButtonTexture = AssetResources.ASSETS_MANAGER.getTexture("reset_button");
					AssetResources.contractButtonTexture = AssetResources.ASSETS_MANAGER.getTexture("contract_button");
					
					// Set up levels
					AssetResources.levels = new Array(NUM_OF_LEVELS);
					for (var lcount:int = NUM_OF_LEVELS; lcount > 0; --lcount)
					{
						AssetResources.levels[lcount] = AssetResources.ASSETS_MANAGER.getObject("level" + lcount);
					}
					
					AssetResources.CALL_BACK();
									
				}
				
			});
			
			
		}
		
	}
	
}
