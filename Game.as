
package 
{
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import scenes.SplashScene;
	import scenes.MenuScene;
	import scenes.PlayScene;
	import scenes.SandboxScene;
	import scenes.Scene;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.display3D.textures.Texture;
	import starling.display.Image;
	
	
	public class Game extends Sprite
	{

		public static var INSTANCE:Game;
		
		
		private var _lastTime:Number;
		public var doneLoading:Boolean;
		
		// Game Sprites/Objects
		public var splashImage:Sprite;

		
		// Game Sounds/Themes/Music
		public var splashTheme:Sound, menuTheme:Sound, playTheme:Sound, sandboxTheme:Sound;
		public var sunCollisionSound:Sound, projectileCollisionSound:Sound, 
				   pointCollisionSound:Sound, blackHoleCollisionSound:Sound;
		
		// Game Textures
		public var splashTextures:Array, backgroundTextures:Array;
		public var blueProjectileTextures:Array, greenProjectileTextures:Array, redProjectileTextures:Array;
		public var sunTextures:Array, blackHoleTextures:Array;
		public var resetButtonTexture:Texture, contractButtonTexture:Texture;
		
		// Game Scenes
		public var splashScene:SplashScene;
		public var menuScene:MenuScene;
		public var playScene:PlayScene;
		public var sandboxScene:SandboxScene;
		public var scene:Scene;
		
		public function Game()
		{
			Game.INSTANCE = this;
			doneLoading = false;
			
			// Load resources
			AssetResources.init();
			
			splashScene = new SplashScene();
			menuScene = new MenuScene();
			playScene = new PlayScene();
			sandboxScene = new SandboxScene();
			scene = splashScene;
			
			AssetResources.ASSETS_MANAGER.loadQueue(function(ratio:Number):void
			{
				trace("Loading assets, progress:", ratio);
				
				if (ratio == 1.0)
				{
					doneLoading = true;
					
					// Set up themes
					Game.INSTANCE.splashTheme = AssetResources.ASSETS_MANAGER.getSound("splashtheme");
					Game.INSTANCE.menuTheme = AssetResources.ASSETS_MANAGER.getSound("menutheme");
					Game.INSTANCE.playTheme = AssetResources.ASSETS_MANAGER.getSound("playtheme");
					Game.INSTANCE.sandboxTheme = AssetResources.ASSETS_MANAGER.getSound("soundboxtheme");
					
					// Set up sound effects
					Game.INSTANCE.sunCollisionSound = AssetResources.ASSETS_MANAGER.getSound("sun_collision");
					Game.INSTANCE.projectileCollisionSound = AssetResources.ASSETS_MANAGER.getSound("projectile_collision");
					Game.INSTANCE.pointCollisionSound = AssetResources.ASSETS_MANAGER.getSound("point_collision");
					Game.INSTANCE.blackHoleCollisionSound = AssetResources.ASSETS_MANAGER.getSound("black_hole_collision");

					// Set up textures
					Game.INSTANCE.splashTextures.push(AssetResources.ASSETS_MANAGER.getTexture("splashscreen_x1"));
					Game.INSTANCE.splashTextures.push(AssetResources.ASSETS_MANAGER.getTexture("splashscreen_x2"));
					Game.INSTANCE.splashTextures.push(AssetResources.ASSETS_MANAGER.getTexture("splashscreen_x3"));
					
					Game.INSTANCE.backgroundTextures.push(AssetResources.ASSETS_MANAGER.getTexture("background_x1"));
					Game.INSTANCE.backgroundTextures.push(AssetResources.ASSETS_MANAGER.getTexture("sbackground_x2"));
					Game.INSTANCE.backgroundTextures.push(AssetResources.ASSETS_MANAGER.getTexture("background_x3"));
					
					Game.INSTANCE.blueProjectileTextures.push(AssetResources.ASSETS_MANAGER.getTexture("blue_projectile_x1"));
					Game.INSTANCE.blueProjectileTextures.push(AssetResources.ASSETS_MANAGER.getTexture("blue_projectile_x2"));
					Game.INSTANCE.blueProjectileTextures.push(AssetResources.ASSETS_MANAGER.getTexture("blue_projectile_x3"));
					
					Game.INSTANCE.greenProjectileTextures.push(AssetResources.ASSETS_MANAGER.getTexture("green_projectile_x1"));
					Game.INSTANCE.greenProjectileTextures.push(AssetResources.ASSETS_MANAGER.getTexture("green_projectile_x2"));
					Game.INSTANCE.greenProjectileTextures.push(AssetResources.ASSETS_MANAGER.getTexture("green_projectile_x3"));
					
					Game.INSTANCE.redProjectileTextures.push(AssetResources.ASSETS_MANAGER.getTexture("red_projectile_x1"));
					Game.INSTANCE.redProjectileTextures.push(AssetResources.ASSETS_MANAGER.getTexture("red_projectile_x2"));
					Game.INSTANCE.redProjectileTextures.push(AssetResources.ASSETS_MANAGER.getTexture("red_projectile_x3"));
					
					Game.INSTANCE.sunTextures.push(AssetResources.ASSETS_MANAGER.getTexture("sun_x1"));
					Game.INSTANCE.sunTextures.push(AssetResources.ASSETS_MANAGER.getTexture("sun_x2"));
					Game.INSTANCE.sunTextures.push(AssetResources.ASSETS_MANAGER.getTexture("sun_x3"));
					
					Game.INSTANCE.resetButtonTexture = AssetResources.ASSETS_MANAGER.getTexture("reset_button");
					Game.INSTANCE.contractButtonTexture = AssetResources.ASSETS_MANAGER.getTexture("contract_button");
					
					
					// Set up scenes			
					Game.INSTANCE.addEventListener(Event.ENTER_FRAME, update);
				}
				
				
			});
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			_lastTime = new Date().getTime();
	
		}

		public function init(event:Event):void
		{
			scene.init();
			addChild(scene);
		}

		public function update(event:Event):void 
		{

			var now:Number = new Date().getTime();
			var delta:Number = now - _lastTime;
			_lastTime = now;
			
			if (!scene.isDone) {
				scene.update(delta/1000);
			} else {
				removeChild(scene);
				scene = scene.nextScene;
				scene.init();
				addChild(scene);
			}

		}
	}

}