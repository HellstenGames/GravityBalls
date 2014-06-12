package scenes {
	
	// Import project stuff
	import objects.Projectile;
	import objects.BlackHole;
	import objects.Sun;
	
	import components.gbInputComponent;
	import components.gbGraphicsComponent;
	import components.gbPhysicsComponent;
	
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.events.Touch;
	import starling.core.Starling;
	
	import flash.geom.Point;
	import managers.ProjectileManager;
	import managers.SunManager;
	import objects.BackgroundImage;
	import objects.PlayButton;
	import objects.ExitButton;
	import starling.display.Sprite;

	//import scenes.PlayScene;
	import starling.display.Image;

	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	
	import objects.SandboxButton;
	import objects.GameObject;
	
	public class PlayScene extends Scene 
	{

		private static var MAX_NUM_PROJECTILES:int = 25;
		private static var MAX_NUM_SUNS:int = 3;
		private static var MAX_SHOOT:Number = 30;
		private static var MIN_SHOOT:Number = 25;
		private static var OUT_OF_BOUNDS:Number = 100;
		private static var SPAWN_BOUNDARY:Number = 25;
		private static var BACKGROUND_ALPHA:Number = 1.0;
		private static var MENU_SPACE_RATIO:Number = 1.5;
		
		private var _backgroundLayer:Sprite;
		private var _menuLayer:Sprite;
		
		private var _backgroundImage:BackgroundImage;

		public var projectileManager:ProjectileManager;
		public var sunManager:SunManager;
		
		private var themeChannel:SoundChannel;
		
		public function PlayScene() 
		{
			super(new gbInputComponent(), new gbPhysicsComponent(), new gbGraphicsComponent());
		}
		
		override public function init():void
		{		
			super.init();


			// Create and position menu objects
			_backgroundImage = new BackgroundImage();

			// Set up layers
			_backgroundLayer = new Sprite();
			addChild(_backgroundLayer);
			_menuLayer = new Sprite();
			addChild(_menuLayer);
			
			// Add to layers
			_backgroundLayer.addChild(_backgroundImage);

			// Create managers
			projectileManager = new ProjectileManager(_backgroundLayer, MAX_NUM_PROJECTILES);
			sunManager = new SunManager(_backgroundLayer, MAX_NUM_SUNS);
			sunManager.projectileManager = projectileManager;
			
			// Create managers and set their boundaries
			sunManager.gravitate = true;
			//_projectileManager.gravitate = true;
			
			themeChannel = AssetResources.playTheme.play();		
		}

		override public function destroy():void
		{
			super.destroy();
			themeChannel.stop();
		}
		
		override public function update(timeDelta:Number):void 
		{ 
			super.update(timeDelta);
			
			projectileManager.update(timeDelta);
			sunManager.update(timeDelta);
	
		}

	}
	
}
