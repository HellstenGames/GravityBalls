﻿package  {
	// Import starling stuff
	import starling.utils.AssetManager;
	import starling.core.Starling;
	import starling.textures.Texture;
	import starling.display.Image;
	import starling.text.TextField;
	
	// Import flash stuff
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.filesystem.File;
	import starling.text.BitmapFont;
	
	public class AssetResources {

		// Constants
		public static var NUM_OF_LEVELS:uint = 15;
		
		private static var ASSETS_MANAGER:AssetManager;
		private static var CALL_BACK:Function;
		
		public static var splashTheme:Sound, menuTheme:Sound, playTheme:Sound, sandboxTheme:Sound;
		public static var sunCollisionSound:Sound, projectileCollisionSound:Sound, 
						  pointCollisionSound:Sound, blackHoleCollisionSound:Sound;
		
		public static var splashTexture:Texture, backgroundTexture:Texture, nebulaTexture:Texture, loadTexture:Texture;
		public static var blueProjectileTexture:Texture, greenProjectileTexture:Texture, redProjectileTexture:Texture;
		public static var sunTexture:Texture, blackHoleTexture:Texture;
		public static var resetButtonTexture:Texture, cbTexture:Texture, pbTexture:Texture, ebTexture:Texture;
		public static var exitBallTexture:Texture, playBallTexture:Texture, sandboxBallTexture:Texture;
		public static var exitTextTexture:Texture, playTextTexture:Texture, sandboxTextTexture:Texture, backBallTexture:Texture, optionBallTexture:Texture;
		public static var starTexture:Texture, trailTexture:Texture, asteroidTexture:Texture;
		public static var arrowTextures:Array;	
		public static var menuPickTexture:Texture, menuScreenTexture:Texture;	
		
		public static var soundButtonTexture:Texture, creditButtonTexture:Texture;
		
		public static var levels:Array;
		public static var creditScreen:Object, levelScreen1:Object, levelScreen2:Object, levelScreen3:Object, adScreen:Object;
		
		public static var blackPentagonTexture:Texture;
		public static var startTitleTexture:Texture, playArrowTexture:Texture;
		
		// Fonts
		public static var blueLitteraFNT_Texture:Texture;
		public static var blueLitteraXML:XML;
		
		[Embed(source="assets/fonts/bluelittera.xml", mimeType="application/octet-stream")]
		public static const FontXml:Class;

		public static function setOnLoadComplete(f:Function)
		{
			AssetResources.CALL_BACK = f;
		}
		
		public static function init():void
		{
			// Set up assets manager
			ASSETS_MANAGER = new AssetManager(Math.floor(Starling.contentScaleFactor));
			ASSETS_MANAGER.verbose = true;
			
			// Load assets/textures/sounds/etc using asset manager
			var appDir:File = File.applicationDirectory;

			ASSETS_MANAGER.enqueue(appDir.resolvePath("assets/x" + String(Math.floor(Starling.contentScaleFactor))));
			ASSETS_MANAGER.enqueue(appDir.resolvePath("assets/sfx"));
			ASSETS_MANAGER.enqueue(appDir.resolvePath("assets/gfx"));
			ASSETS_MANAGER.enqueue(appDir.resolvePath("assets/fonts"));
			ASSETS_MANAGER.enqueue(appDir.resolvePath("assets/menu"));
			ASSETS_MANAGER.enqueue(appDir.resolvePath("assets/levels"));
			
			ASSETS_MANAGER.loadQueue(function(ratio:Number):void
			{
				trace("Loading assets, progress:", ratio);
				
				if (ratio == 1.0)
				{
					var sf:String = String(Math.floor(Starling.contentScaleFactor));
					
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
					AssetResources.loadTexture = AssetResources.ASSETS_MANAGER.getTexture("loadscreen_x" + sf);
					AssetResources.backgroundTexture = AssetResources.ASSETS_MANAGER.getTexture("background_x" + sf);
					AssetResources.nebulaTexture = AssetResources.ASSETS_MANAGER.getTexture("nebula_x" + sf);
					AssetResources.blueProjectileTexture = AssetResources.ASSETS_MANAGER.getTexture("blue_projectile_x" + sf);
					AssetResources.greenProjectileTexture = AssetResources.ASSETS_MANAGER.getTexture("green_projectile_x" + sf);
					AssetResources.redProjectileTexture = AssetResources.ASSETS_MANAGER.getTexture("red_projectile_x" + sf);
					AssetResources.sunTexture = AssetResources.ASSETS_MANAGER.getTexture("sun_x" + sf);
					AssetResources.blackHoleTexture = AssetResources.ASSETS_MANAGER.getTexture("blackhole_x" + sf);
					AssetResources.starTexture = AssetResources.ASSETS_MANAGER.getTexture("star_x" + sf);
					AssetResources.trailTexture = AssetResources.ASSETS_MANAGER.getTexture("trail_x" + sf);
					AssetResources.asteroidTexture = AssetResources.ASSETS_MANAGER.getTexture("asteroid_x" + sf);


					// Arrow assets
					AssetResources.arrowTextures = [];
					AssetResources.arrowTextures.push(AssetResources.ASSETS_MANAGER.getTexture("arrow_red_x" + sf));
					AssetResources.arrowTextures.push(AssetResources.ASSETS_MANAGER.getTexture("arrow_green_x" + sf));
					AssetResources.arrowTextures.push(AssetResources.ASSETS_MANAGER.getTexture("arrow_blue_x" + sf));
					
					AssetResources.exitBallTexture = AssetResources.ASSETS_MANAGER.getTexture("exit_ball_x" + sf);
					AssetResources.backBallTexture = AssetResources.ASSETS_MANAGER.getTexture("backball_x" + sf);
					AssetResources.playBallTexture = AssetResources.ASSETS_MANAGER.getTexture("playball_x" + sf);
					AssetResources.sandboxBallTexture = AssetResources.ASSETS_MANAGER.getTexture("sandbox_ball_x" + sf);
					AssetResources.optionBallTexture = AssetResources.ASSETS_MANAGER.getTexture("optionball_x" + sf);
					
					AssetResources.exitTextTexture = AssetResources.ASSETS_MANAGER.getTexture("exit_text_x" + sf);
					AssetResources.playTextTexture = AssetResources.ASSETS_MANAGER.getTexture("play_text_x" + sf);
					AssetResources.sandboxTextTexture = AssetResources.ASSETS_MANAGER.getTexture("sandbox_text_x" + sf);

					AssetResources.resetButtonTexture = AssetResources.ASSETS_MANAGER.getTexture("reset_button");
					AssetResources.pbTexture = AssetResources.ASSETS_MANAGER.getTexture("pb_x" + sf);
					AssetResources.cbTexture = AssetResources.ASSETS_MANAGER.getTexture("cb_x" + sf);
					AssetResources.ebTexture = AssetResources.ASSETS_MANAGER.getTexture("eb_x" + sf);
					
					// Menu Assets
					AssetResources.menuPickTexture = AssetResources.ASSETS_MANAGER.getTexture("menupick");
					AssetResources.menuScreenTexture = AssetResources.ASSETS_MANAGER.getTexture("menuscreen_x" + sf);
					AssetResources.soundButtonTexture = AssetResources.ASSETS_MANAGER.getTexture("soundbutton_x" + sf);
					AssetResources.creditButtonTexture = AssetResources.ASSETS_MANAGER.getTexture("creditbutton_x" + sf);
					
					
					// Menu Screens
					AssetResources.creditScreen = AssetResources.ASSETS_MANAGER.getObject("credit_screen");
					AssetResources.levelScreen1 = AssetResources.ASSETS_MANAGER.getObject("level_screen_1");
					AssetResources.levelScreen2 = AssetResources.ASSETS_MANAGER.getObject("level_screen_2");
					AssetResources.levelScreen3 = AssetResources.ASSETS_MANAGER.getObject("level_screen_3");
					AssetResources.adScreen = AssetResources.ASSETS_MANAGER.getObject("ad_screen");
					
					AssetResources.blackPentagonTexture = AssetResources.ASSETS_MANAGER.getTexture("blackpentagon_x" + sf);
		
					// Load fonts
					AssetResources.blueLitteraFNT_Texture = AssetResources.ASSETS_MANAGER.getTexture("bluelittera_fnt");
					AssetResources.blueLitteraXML = XML(new FontXml());
					trace(AssetResources.blueLitteraFNT_Texture, AssetResources.blueLitteraXML);
					TextField.registerBitmapFont(new BitmapFont(AssetResources.blueLitteraFNT_Texture, AssetResources.blueLitteraXML));
					
					// Start scene assets
					AssetResources.startTitleTexture = AssetResources.ASSETS_MANAGER.getTexture("menutitle_x" + sf);
					AssetResources.playArrowTexture = AssetResources.ASSETS_MANAGER.getTexture("play_arrow_x" + sf);
					
					
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
