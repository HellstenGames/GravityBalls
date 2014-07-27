package scenes {
	
	// Starling stuff
	import starling.display.Sprite;
	import starling.core.Starling;
	
	// Objects
	import objects.StartBackground;
	import objects.Projectile;
	import objects.Sun;
	import objects.StartTitle;
	import objects.OptionRollOut;
	import objects.BetaTitle;
	
	import doodads.PlanetDoodad;
	
	// Managers
	import managers.ProjectileManager;
	import managers.SunManager;
	
	// Buttons
	import buttons.PlayButton;
	import buttons.ExitButton;
	import buttons.OptionButton;
	
	// Brinkbit Admob
	import com.brinkbit.admob.AdMobAd;
	import com.brinkbit.admob.constants.AdMobAdType;
	
	
	// Admob
//	import so.cuo.platform.admob.Admob;
//	import so.cuo.platform.admob.AdmobPosition;
	
	public class StartScene extends Scene {

		public static var MAX_PROJECTILES:int = 16;
		public static var MAX_SUNS:int = 2;
		public static var MAX_SHOOT:Number = 30;
		public static var MIN_SHOOT:Number = 25;
		public static var OUT_OF_BOUNDS:Number = 100;
		public static var SPAWN_BOUNDARY:Number = 25;
		
		// Layers
		public var doodadLayer:Sprite;
		public var topLayer:Sprite;
		
		// Objects/Sprites/Buttons
		public var playButton:PlayButton;
		public var exitButton:ExitButton;
		public var optionButton:OptionButton;
		public var startTitle:StartTitle;
		public var betaTitle:BetaTitle;
		public var optionRollOut:OptionRollOut;
		
		public var planetDoodad:PlanetDoodad, sunDoodad:PlanetDoodad;
		
		// Managers
		public var projectileManager:ProjectileManager;
		public var sunManager:SunManager;

		
		public function StartScene() 
		{
			super();
			nextScene = new MenuScene();
		}

		override public function init():void
		{		
			super.init();

			// Add background layer sprites/entities
			backgroundLayer = new Sprite();
			addChild(backgroundLayer);
			backgroundLayer.addChild(new StartBackground());
			
			doodadLayer = new Sprite();
			addChild(doodadLayer);
			
			topLayer = new Sprite();
			addChild(topLayer);
			
			// Create option roll out 
			optionRollOut = new OptionRollOut(this);
			optionRollOut.cx = Starling.current.stage.stageWidth - 35;
			optionRollOut.cy = Starling.current.stage.stageHeight - 35;
			addEntity(optionRollOut);
			topLayer.addChild(optionRollOut);
			
			// Add Play Button
			playButton = new PlayButton(this);
			playButton.cx = Starling.current.stage.stageWidth / 2;
			playButton.cy = Starling.current.stage.stageHeight / 2 + 25;
			playButton.trackOriginalCenter();
			addEntity(playButton);
			topLayer.addChild(playButton);
			
			// Add exit button
			exitButton = new ExitButton(this);
			exitButton.cx = 35;
			exitButton.cy = Starling.current.stage.stageHeight - 35;
			addEntity(exitButton);
			topLayer.addChild(exitButton);
			
			// Add option button
			optionButton = new OptionButton(optionRollOut);
			optionButton.cx = Starling.current.stage.stageWidth - 35;
			optionButton.cy = Starling.current.stage.stageHeight - 35;
			addEntity(optionButton);
			topLayer.addChild(optionButton);
			
			// Create start title
			startTitle = new StartTitle();
			startTitle.cx = Starling.current.stage.stageWidth / 2;
			startTitle.y = 40;
			startTitle.trackOriginalCenter();
			addEntity(startTitle);
			topLayer.addChild(startTitle);
			
			// Create beta title
			betaTitle = new BetaTitle();
			betaTitle.cx = Starling.current.stage.stageWidth / 2;
			betaTitle.y = 80;
			betaTitle.trackOriginalCenter();
			addEntity(betaTitle);
			topLayer.addChild(betaTitle);
			
			// Create doodads
			/*
			planetDoodad = new PlanetDoodad();
			planetDoodad.cx = 200;
			planetDoodad.cy = 100;
			addEntity(planetDoodad);
			doodadLayer.addChild(planetDoodad);
		
			sunDoodad = new PlanetDoodad();
			sunDoodad.cx = 500;
			sunDoodad.cy = 400;
			addEntity(sunDoodad);
			doodadLayer.addChild(sunDoodad);
			*/
			
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
		
			
			// Play start theme
			themeChannel = AssetResources.menuTheme.play();
			
			// Create banner
			//var banner:AdMobAd = new AdMobAd(AdMobAdType.BANNER, Constants.PUBLISHER_ID);
			//banner.showAd();
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
			if (projectileManager.projectileCount < MAX_PROJECTILES) 
			{
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
			if (sunManager.sunCount < MAX_SUNS) 
			{
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
		
		override public function destroy():void
		{
			super.destroy();
			themeChannel.stop();
		}
		
	}
	
}
