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
	
	public class SandboxScene extends Scene 
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
		private var _playButton:PlayButton, _exitButton:ExitButton, _sandBoxButton:SandboxButton;

		public var projectileManager:ProjectileManager;
		public var sunManager:SunManager;
		
		private var themeChannel:SoundChannel;
		
		public function SandboxScene() 
		{
			super(new gbInputComponent(), new gbPhysicsComponent(), new gbGraphicsComponent());
		}
		
		override public function init():void
		{		
			super.init();


			// Create and position menu objects
			_backgroundImage = new BackgroundImage();
			_playButton = new PlayButton();
			_sandBoxButton = new SandboxButton();
			_exitButton = new ExitButton();
			
			_playButton.x = Starling.current.stage.stageWidth / 2 - _sandBoxButton.width / 2 - _sandBoxButton.width * 1.5;
			_playButton.y = Starling.current.stage.stageHeight / 2 - _playButton.height / 2;

			_sandBoxButton.x = Starling.current.stage.stageWidth / 2 - _sandBoxButton.width / 2;
			_sandBoxButton.y = Starling.current.stage.stageHeight / 2 - _sandBoxButton.height / 2;			

			_exitButton.x = Starling.current.stage.stageWidth / 2 - _sandBoxButton.width / 2 + _sandBoxButton.width * 1.5;
			_exitButton.y = Starling.current.stage.stageHeight / 2 - _exitButton.height / 2;
			
			
			// Set up layers
			_backgroundLayer = new Sprite();
			addChild(_backgroundLayer);
			_menuLayer = new Sprite();
			addChild(_menuLayer);
			
			// Add to layers
			_backgroundLayer.addChild(_backgroundImage);
			
			_menuLayer.addChild(_playButton);
			_menuLayer.addChild(_sandBoxButton);
			_menuLayer.addChild(_exitButton);
			
			// Create managers
			projectileManager = new ProjectileManager(_backgroundLayer, MAX_NUM_PROJECTILES);
			sunManager = new SunManager(_backgroundLayer, MAX_NUM_SUNS);
			sunManager.projectileManager = projectileManager;
			
			// Create managers and set their boundaries
			sunManager.setBoundary(-OUT_OF_BOUNDS, -OUT_OF_BOUNDS, 
				Starling.current.nativeStage.stageWidth + OUT_OF_BOUNDS,
				Starling.current.nativeStage.stageHeight + OUT_OF_BOUNDS);
			sunManager.gravitate = true;

			projectileManager.setBoundary(-OUT_OF_BOUNDS, -OUT_OF_BOUNDS, 
				Starling.current.nativeStage.stageWidth + OUT_OF_BOUNDS,
				Starling.current.nativeStage.stageHeight + OUT_OF_BOUNDS);
			//_projectileManager.gravitate = true;
			
			themeChannel = AssetResources.menuTheme.play();		
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

			// Update Menu Items
			_playButton.update(timeDelta);
			_exitButton.update(timeDelta);
			_sandBoxButton.update(timeDelta);

			var randomSide:int;
			var startXPosition:Number, startYPosition:Number;
			var shootXSpeed:Number, shootYSpeed:Number;
		
			// Create projectiles
			if (projectileManager.projectileCount < MAX_NUM_PROJECTILES) {
				
				randomSide = 4 * Math.random();
				
				// Spawn random projectiles + suns
				if (randomSide == 0) {
					startXPosition = -SPAWN_BOUNDARY;
					startYPosition = Math.random() * Starling.current.nativeStage.stageHeight;
					shootYSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
					shootXSpeed = Math.random() * (MAX_SHOOT - MIN_SHOOT) + MIN_SHOOT;
				} else if (randomSide == 1) {
					startXPosition = Math.random() * Starling.current.nativeStage.stageWidth;
					startYPosition = -SPAWN_BOUNDARY;
					shootYSpeed = Math.random() * (MAX_SHOOT - MIN_SHOOT) + MIN_SHOOT;
					shootXSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
				} else if (randomSide == 2) {
					startXPosition = Starling.current.nativeStage.stageWidth + SPAWN_BOUNDARY;
					startYPosition = Math.random() *  Starling.current.nativeStage.stageHeight;	
					shootXSpeed = -Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;	
					shootYSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;			
				} else {
					startXPosition = Math.random() * Starling.current.nativeStage.stageWidth;
					startYPosition = Starling.current.nativeStage.stageHeight + SPAWN_BOUNDARY;
					shootXSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
					shootYSpeed = -Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
				}

				// Get random color
				var random_color:int = Math.random() * Projectile.COLORS.length;
				projectileManager.addProjectile(startXPosition, startYPosition, shootXSpeed, shootYSpeed, Projectile.COLORS[random_color]);
				
			}
			
			// Create suns
			if (sunManager.sunCount < MAX_NUM_SUNS) {
				
				randomSide = 4 * Math.random();
				
				// Spawn random projectiles + suns
				if (randomSide == 0) {
					startXPosition = -SPAWN_BOUNDARY;
					startYPosition = Math.random() * Starling.current.nativeStage.stageHeight;
					shootYSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
					shootXSpeed = Math.random() * (MAX_SHOOT - MIN_SHOOT) + MIN_SHOOT;
				} else if (randomSide == 1) {
					startXPosition = Math.random() * Starling.current.nativeStage.stageWidth;
					startYPosition = -SPAWN_BOUNDARY;
					shootYSpeed = Math.random() * (MAX_SHOOT - MIN_SHOOT) + MIN_SHOOT;
					shootXSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
				} else if (randomSide == 2) {
					startXPosition = Starling.current.nativeStage.stageWidth + SPAWN_BOUNDARY;
					startYPosition = Math.random() *  Starling.current.nativeStage.stageHeight;	
					shootXSpeed = -Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;	
					shootYSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;		
				} else {
					startXPosition = Math.random() * Starling.current.nativeStage.stageWidth;
					startYPosition = Starling.current.nativeStage.stageHeight + SPAWN_BOUNDARY;
					shootXSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
					shootYSpeed = -Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
				}

				sunManager.addSun(startXPosition, startYPosition, shootXSpeed, shootYSpeed);
			}

	
		}

	}
	
}
