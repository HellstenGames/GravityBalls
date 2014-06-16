package scenes {
	
	// Import starling stuff
	import starling.display.Sprite;
	import starling.core.Starling;
	
	// Import project stuff
	import objects.Entity;
	import objects.Background;
	import buttons.PlayButton;
	import buttons.SandboxButton;
	import buttons.ExitButton;
	import managers.ProjectileManager;
	import managers.SunManager;
	import objects.Projectile;
	import objects.Sun;
	
	
	public class MenuScene extends Scene {

		public static var MENU_BUTTON_OFFSET:int = 125;
		public static var MAX_PROJECTILES:int = 25;
		public static var MAX_SUNS:int = 3;
		private static var MAX_SHOOT:Number = 30;
		private static var MIN_SHOOT:Number = 25;
		private static var OUT_OF_BOUNDS:Number = 100;
		private static var SPAWN_BOUNDARY:Number = 25;
		
		public var playButton:PlayButton, sandboxButton:SandboxButton, exitButton:ExitButton;
		public var background:Sprite;
		
		public var projectileManager:ProjectileManager;
		public var sunManager:SunManager;
		
		// Layers
		public var backgroundLayer:Sprite;
		
		public function MenuScene()
		{
			super();
		}

		override public function init():void
		{		
			super.init();
			
			backgroundLayer = new Sprite();
			addChild(backgroundLayer);
			
			// Create/Add background
			background = new Background();
			backgroundLayer.addChild(background);
			
			// Create buttons
			playButton = new PlayButton(this);
			playButton.cx = Starling.current.stage.stageWidth / 2 - MENU_BUTTON_OFFSET;
			playButton.cy = Starling.current.stage.stageHeight / 2;
			sandboxButton = new SandboxButton(this);
			sandboxButton.cx = Starling.current.stage.stageWidth / 2;
			sandboxButton.cy = Starling.current.stage.stageHeight / 2;			
			exitButton = new ExitButton(this);
			exitButton.cx = Starling.current.stage.stageWidth / 2 + MENU_BUTTON_OFFSET;
			exitButton.cy = Starling.current.stage.stageHeight / 2;			
			// Add buttons
			addEntity(playButton);
			addEntity(sandboxButton);
			addEntity(exitButton);
			
			// Create Managers
			projectileManager = new ProjectileManager(backgroundLayer, MAX_PROJECTILES);
			projectileManager.setBoundary(-OUT_OF_BOUNDS, -OUT_OF_BOUNDS, 
				Starling.current.stage.stageWidth + OUT_OF_BOUNDS,
				Starling.current.stage.stageHeight + OUT_OF_BOUNDS);

			sunManager = new SunManager(backgroundLayer, projectileManager, MAX_PROJECTILES);
			sunManager.setBoundary(-OUT_OF_BOUNDS, -OUT_OF_BOUNDS, 
				Starling.current.stage.stageWidth + OUT_OF_BOUNDS,
				Starling.current.stage.stageHeight + OUT_OF_BOUNDS);
			sunManager.gravitate = true;	
			
		}
		
		override public function update(timeDelta:Number):void 
		{ 
			super.update(timeDelta);
			projectileManager.update(timeDelta);
			sunManager.update(timeDelta);
			
			// Prepare to shoot projectiles and suns
			var randomSide:int;
			var startXPosition:Number, startYPosition:Number;
			var shootXSpeed:Number, shootYSpeed:Number;

			// Create projectiles
			if (projectileManager.projectileCount < MAX_PROJECTILES) {

				randomSide = 4 * Math.random();

				// Spawn random projectiles + suns
				if (randomSide == 0) {
					startXPosition = -SPAWN_BOUNDARY;
					startYPosition = Math.random() * Starling.current.stage.stageWidth;
					shootYSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
					shootXSpeed = Math.random() * (MAX_SHOOT - MIN_SHOOT) + MIN_SHOOT;
				} else if (randomSide == 1) {
					startXPosition = Math.random() * Starling.current.stage.stageWidth;
					startYPosition = -SPAWN_BOUNDARY;
					shootYSpeed = Math.random() * (MAX_SHOOT - MIN_SHOOT) + MIN_SHOOT;
					shootXSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
				} else if (randomSide == 2) {
					startXPosition = Starling.current.nativeStage.stageWidth + SPAWN_BOUNDARY;
					startYPosition = Math.random() *  Starling.current.stage.stageHeight;	
					shootXSpeed = -Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;	
					shootYSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;			
				} else {
					startXPosition = Math.random() * Starling.current.stage.stageWidth;
					startYPosition = Starling.current.stage.stageHeight + SPAWN_BOUNDARY;
					shootXSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
					shootYSpeed = -Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
				}

				// Get random color
				var random_color:int = Math.random() * Projectile.COLORS.length;
				projectileManager.addProjectile(startXPosition, startYPosition, shootXSpeed, shootYSpeed, Projectile.COLORS[random_color]);


			}

			// Create suns
			if (sunManager.sunCount < MAX_SUNS) {

				randomSide = 4 * Math.random();

				// Spawn random projectiles + suns
				if (randomSide == 0) {
					startXPosition = -SPAWN_BOUNDARY;
					startYPosition = Math.random() * Starling.current.stage.stageWidth;
					shootYSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
					shootXSpeed = Math.random() * (MAX_SHOOT - MIN_SHOOT) + MIN_SHOOT;
				} else if (randomSide == 1) {
					startXPosition = Math.random() * Starling.current.stage.stageWidth;
					startYPosition = -SPAWN_BOUNDARY;
					shootYSpeed = Math.random() * (MAX_SHOOT - MIN_SHOOT) + MIN_SHOOT;
					shootXSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
				} else if (randomSide == 2) {
					startXPosition = Starling.current.nativeStage.stageWidth + SPAWN_BOUNDARY;
					startYPosition = Math.random() *  Starling.current.stage.stageHeight;	
					shootXSpeed = -Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;	
					shootYSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;		
				} else {
					startXPosition = Math.random() * Starling.current.stage.stageWidth;
					startYPosition = Starling.current.stage.stageHeight + SPAWN_BOUNDARY;
					shootXSpeed = Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
					shootYSpeed = -Math.random() * (MAX_SHOOT + MIN_SHOOT) - MIN_SHOOT;
				}

				sunManager.addSun(startXPosition, startYPosition, shootXSpeed, shootYSpeed);
			}			
		}
		
	}
	
}
