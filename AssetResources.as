package  {
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
	import scenes.CreditScene;
	
	import utils.SceneLoader;

	/* Admob extension */
	import com.brinkbit.admob.AdMobAd;
	import com.brinkbit.admob.constants.AdMobAdType;
	import com.brinkbit.admob.constants.AdMobAdPosition;
	import com.brinkbit.admob.event.AdMobEvent;
	
	public class AssetResources {

		// Constants
		public static var NUM_OF_LEVELS:uint = 15;
		
		private static var ASSETS_MANAGER:AssetManager;
		private static var CALL_BACK:Function;
		
		public static var splashTheme:Sound, menuTheme:Sound, playTheme:Sound, sandboxTheme:Sound;
		public static var sunCollisionSound:Sound, projectileCollisionSound:Sound, 
						  pointCollisionSound:Sound, blackHoleCollisionSound:Sound;
		
		public static var splashTexture:Texture, backgroundTexture:Texture, nebulaTexture:Texture, loadTexture:Texture;
		public static var blueProjectileTexture:Texture, greenProjectileTexture:Texture, redProjectileTexture:Texture, 
						  brownProjectileTexture:Texture, yellowProjectileTexture:Texture, cyanProjectileTexture:Texture,
						  whiteProjectileTexture:Texture;

		public static var sunTexture:Texture, blackHoleTexture:Texture;
		public static var resetButtonTexture:Texture, cbTexture:Texture, pbTexture:Texture, ebTexture:Texture;
		public static var exitBallTexture:Texture, playBallTexture:Texture, sandboxBallTexture:Texture;
		public static var exitTextTexture:Texture, playTextTexture:Texture, sandboxTextTexture:Texture, backBallTexture:Texture, optionBallTexture:Texture;
		public static var starTexture:Texture, trailTexture:Texture, asteroidTexture:Texture;
		public static var arrowTextures:Array;	
		public static var menuPickTexture:Texture, menuScreenTexture:Texture;	
		
		public static var soundButtonTexture:Texture, creditButtonTexture:Texture, muteButtonTexture:Texture;
		
		public static var levels:Array;
		public static var creditScreen:Object, levelScreen1:Object, levelScreen2:Object, levelScreen3:Object, adScreen:Object;
		
		public static var blackPentagonTexture:Texture;
		public static var startTitleTexture:Texture, betaTitleTexture:Texture, playArrowTexture:Texture;
		
		/* Sounds/Themes */
		public static var themes:Object;
		/* Sprites/Graphics */
		public static var backgrounds:Object;
		public static var buttons:Object;
		
		// Doodads
		public static var planetDoodadTexture:Texture;
		
		/* Scenes */
		public static var creditScene:CreditScene;
		
		/* Fonts */
		public static var creditFNT_Texture:Texture;
		public static var creditXML:XML;
		
		[Embed(source="assets/fonts/credit.xml", mimeType="application/octet-stream")]
		public static const CreditFontXML:Class;

		public static var popupFNT_Texture:Texture;
		public static var popupXML:XML;
		
		[Embed(source="assets/fonts/popup.xml", mimeType="application/octet-stream")]
		public static const PopupFontXML:Class;
		
		public static var blueFNT_Texture:Texture;
		public static var blueXML:XML;
		
		[Embed(source="assets/fonts/blue.xml", mimeType="application/octet-stream")]
		public static const BlueFontXML:Class;
		
		public static function setOnLoadComplete(f:Function)
		{
			AssetResources.CALL_BACK = f;
		}
		
		public static function init():void
		{
			/* Set up admob ads */
			Constants.START_SCENE_BANNER = new AdMobAd(AdMobAdType.BANNER, Constants.START_SCENE_BANNER_ID);
			Constants.START_SCENE_BANNER.verticalGravity = AdMobAdPosition.BOTTOM;
			Constants.PLAY_SCENE_BANNER = new AdMobAd(AdMobAdType.BANNER, Constants.PLAY_SCENE_BANNER_ID);
			Constants.PLAY_SCENE_BANNER.verticalGravity = AdMobAdPosition.TOP;
			
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
			ASSETS_MANAGER.enqueue(appDir.resolvePath("assets/scenes"));
			
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
					
					AssetResources.themes = new Object();
					AssetResources.themes["orbit"] = AssetResources.ASSETS_MANAGER.getSound("orbit");
					AssetResources.themes["pulse"] = AssetResources.ASSETS_MANAGER.getSound("pulse");
					
					/* Set up background sprites */
					AssetResources.backgrounds = new Object();
					AssetResources.backgrounds["menuscreen"] = AssetResources.ASSETS_MANAGER.getTexture("menuscreen_x" + sf);
					
					/* Set up button sprites */
					AssetResources.buttons = new Object();
					AssetResources.buttons["blue_background"] = AssetResources.ASSETS_MANAGER.getTexture("backgroundbutton_blue_x" + sf);
					AssetResources.buttons["red_background"] = AssetResources.ASSETS_MANAGER.getTexture("backgroundbutton_red_x" + sf);
					AssetResources.buttons["blue_sound"] = AssetResources.ASSETS_MANAGER.getTexture("soundbutton_blue_x" + sf);
					AssetResources.buttons["red_sound"] = AssetResources.ASSETS_MANAGER.getTexture("soundbutton_red_x" + sf);
					AssetResources.buttons["blue_credit"] = AssetResources.ASSETS_MANAGER.getTexture("creditbutton_blue_x" + sf);
					
					// Set up sound effects

					AssetResources.sunCollisionSound = AssetResources.ASSETS_MANAGER.getSound("sun_collision");
					AssetResources.projectileCollisionSound = AssetResources.ASSETS_MANAGER.getSound("projectile_collision");
					AssetResources.pointCollisionSound = AssetResources.ASSETS_MANAGER.getSound("point_collision");
					AssetResources.blackHoleCollisionSound = AssetResources.ASSETS_MANAGER.getSound("black_hole_collision");

					// Set up textures
					AssetResources.splashTexture = AssetResources.ASSETS_MANAGER.getTexture("splashscreen_x" + sf);
					AssetResources.loadTexture = AssetResources.ASSETS_MANAGER.getTexture("loadscreen_x" + sf);
					AssetResources.backgroundTexture = AssetResources.ASSETS_MANAGER.getTexture("background_x" + sf);
					AssetResources.nebulaTexture = AssetResources.ASSETS_MANAGER.getTexture("spacebackground_x" + sf);
					
					AssetResources.blueProjectileTexture = AssetResources.ASSETS_MANAGER.getTexture("blue_projectile_x" + sf);
					AssetResources.greenProjectileTexture = AssetResources.ASSETS_MANAGER.getTexture("green_projectile_x" + sf);
					AssetResources.redProjectileTexture = AssetResources.ASSETS_MANAGER.getTexture("red_projectile_x" + sf);
					AssetResources.brownProjectileTexture = AssetResources.ASSETS_MANAGER.getTexture("brown_projectile_x" + sf);
					AssetResources.yellowProjectileTexture = AssetResources.ASSETS_MANAGER.getTexture("yellow_projectile_x" + sf);
					AssetResources.cyanProjectileTexture = AssetResources.ASSETS_MANAGER.getTexture("cyan_projectile_x" + sf);
					AssetResources.whiteProjectileTexture = AssetResources.ASSETS_MANAGER.getTexture("white_projectile_x" + sf);
					
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
					AssetResources.muteButtonTexture = AssetResources.ASSETS_MANAGER.getTexture("mutebutton_x" + sf);
					
					// Menu Screens
					AssetResources.creditScreen = AssetResources.ASSETS_MANAGER.getObject("credit_screen");
					AssetResources.levelScreen1 = AssetResources.ASSETS_MANAGER.getObject("level_screen_1");
					AssetResources.levelScreen2 = AssetResources.ASSETS_MANAGER.getObject("level_screen_2");
					AssetResources.levelScreen3 = AssetResources.ASSETS_MANAGER.getObject("level_screen_3");
					AssetResources.adScreen = AssetResources.ASSETS_MANAGER.getObject("ad_screen");
					
					AssetResources.blackPentagonTexture = AssetResources.ASSETS_MANAGER.getTexture("blackpentagon_x" + sf);
		
					/* Scenes */
					AssetResources.creditScene = SceneLoader.loadCreditScene(AssetResources.ASSETS_MANAGER.getObject("creditscene"));
					
					// Load fonts
					AssetResources.creditFNT_Texture = AssetResources.ASSETS_MANAGER.getTexture("credit_fnt");
					AssetResources.creditXML = XML(new CreditFontXML());
					TextField.registerBitmapFont(new BitmapFont(AssetResources.creditFNT_Texture, AssetResources.creditXML));
					
					AssetResources.popupFNT_Texture = AssetResources.ASSETS_MANAGER.getTexture("popup_fnt");
					AssetResources.popupXML = XML(new PopupFontXML());
					TextField.registerBitmapFont(new BitmapFont(AssetResources.popupFNT_Texture, AssetResources.popupXML));
					
					AssetResources.blueFNT_Texture = AssetResources.ASSETS_MANAGER.getTexture("blue_fnt");
					AssetResources.blueXML = XML(new BlueFontXML());
					TextField.registerBitmapFont(new BitmapFont(AssetResources.blueFNT_Texture, AssetResources.blueXML));
					
					// Start scene assets
					AssetResources.startTitleTexture = AssetResources.ASSETS_MANAGER.getTexture("menutitle_x" + sf);
					AssetResources.betaTitleTexture = AssetResources.ASSETS_MANAGER.getTexture("beta_x" + sf);	
					AssetResources.playArrowTexture = AssetResources.ASSETS_MANAGER.getTexture("play_arrow_x" + sf);
					
					// Doodad assets
					AssetResources.planetDoodadTexture = AssetResources.ASSETS_MANAGER.getTexture("planetdoodad_x" + sf);
					
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
