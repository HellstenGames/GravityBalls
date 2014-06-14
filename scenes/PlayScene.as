package scenes {
	
	// Import project stuff
	import objects.Projectile;
	import objects.BlackHole;
	import objects.Sun;
	import objects.BackgroundImage;
	import objects.PlayButton;
	import objects.ExitButton;
	import objects.SandboxButton;
	import objects.GameObject;

	import managers.ProjectileManager;
	import managers.SunManager;
	
	import components.gbInputComponent;
	import components.gbGraphicsComponent;
	import components.gbPhysicsComponent;
	
	// Import starling stuff
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.Image;
	
	// Import flash stuff
	import flash.geom.Point;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;


	
	public class PlayScene extends Scene 
	{

		private static var MAX_NUM_PROJECTILES:int = 25;
		private static var MAX_NUM_SUNS:int = 3;
		private static var MAX_SHOOT:Number = 30;
		private static var MIN_SHOOT:Number = 25;

		
		private var _backgroundLayer:Sprite;
		private var _menuLayer:Sprite;
		private var _playLayer:Sprite;
		
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
			_playLayer = new Sprite();
			addChild(_playLayer);			
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
