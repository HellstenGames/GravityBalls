package scenes {
	
	// Import starling stuff
	import starling.display.Sprite;
	import starling.core.Starling;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	// Import project stuff
	import objects.Entity;
	import objects.MenuBackground;
	import buttons.PlayButton;
	import buttons.SandboxButton;
	import buttons.ExitButton;
	import managers.ProjectileManager;
	import managers.SunManager;
	import objects.Projectile;
	import objects.Sun;
	
	// Import flash stuff
	import flash.media.SoundChannel;
	import buttons.MenuPick;
	
	import starling.display.BlendMode;
	import flash.geom.Point;
	import screens.CreditScreen;
	
	import utils.ObjectLoader;
	import screens.LevelSelectScreen;
	
	// BRINKBIT ADS
	/*
	import com.brinkbit.admob.AdMobAd;
	import com.brinkbit.admob.constants.AdMobAdPosition;
	import com.brinkbit.admob.constants.AdMobAdType;
	*/
	
	public class MenuScene extends Scene {

		public static var MENU_BUTTON_OFFSET:int = 125;
		public static var MAX_PROJECTILES:int = 16;
		public static var MAX_SUNS:int = 2;
		public static var MAX_SHOOT:Number = 30;
		public static var MIN_SHOOT:Number = 25;
		public static var OUT_OF_BOUNDS:Number = 100;
		public static var SPAWN_BOUNDARY:Number = 25;
		public static var NUM_MENU_SCREENS:Number = 3;
		
		public static var FADE_OUT_SPEED:Number = 0.02;
		public static var FADE_IN_SPEED:Number = 0.02;
		
		public var playButton:PlayButton, sandboxButton:SandboxButton, exitButton:ExitButton;
		public var background:Sprite;
		
		public var projectileManager:ProjectileManager;
		public var sunManager:SunManager;
		
		// Layers
		public var backgroundLayer:Sprite;
		
		private var _themeChannel:SoundChannel;

		private var menuPick:MenuPick;
		

		// Menu Screens
		private var _creditScreen:CreditScreen;
		private var _levelSelectScreen1:LevelSelectScreen;
		
		// Touch Points
		private var _firstPoint:Point;
		private var _lastPoint:Point;
		private var _currentPoint:Point;
		private var _endPoint:Point;
		
		
		public function MenuScene()
		{
			super();
		}

		override public function init():void
		{		
			super.init();
			
			// Set touch points
			_firstPoint = new Point(0, 0);
			_lastPoint = new Point(0, 0);
			_currentPoint = new Point(0, 0);
			_endPoint = new Point(0, 0);
			
			backgroundLayer = new Sprite();
			addChild(backgroundLayer);
			
			// Create/Add background
			_creditScreen = new CreditScreen();
			_creditScreen.x = 0;
			backgroundLayer.addChild(_creditScreen);
			
			_levelSelectScreen1 = ObjectLoader.load_select_screen(AssetResources.levelScreen1);
			_levelSelectScreen1.x = Starling.current.stage.stageWidth;
			backgroundLayer.addChild(_levelSelectScreen1);
			
			background = new MenuBackground();
			background.x = Starling.current.stage.stageWidth * 2;
			backgroundLayer.addChild(background);
			_setMenuScreen(2);
			
			// Create buttons
			/*
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
			*/
			
			this.blendMode = BlendMode.AUTO;
			
			// Add menu picks
			/*
			menuPick = new MenuPick(1);
			menuPick.x = 100;
			menuPick.y = 100;
			addEntity(menuPick);
			menuPick = new MenuPick(2);
			menuPick.x = 200;
			menuPick.y = 100;
			addEntity(menuPick);
			menuPick = new MenuPick(3);
			menuPick.x = 300;
			menuPick.y = 100;
			addEntity(menuPick);
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
			
			_themeChannel = AssetResources.menuTheme.play();
			
			// BRINKBIT ADS
			/*
			var banner:AdMobAd = new AdMobAd(AdMobAdType.BANNER, "pub-2753474656261978");
			banner.showAd();
			banner.verticalGravity = AdMobAdPosition.CENTER;
			*/
			
			this.addEventListener(TouchEvent.TOUCH, onTouch);
		}

		override public function update(timeDelta:Number):void 
		{ 
			super.update(timeDelta);
			projectileManager.update(timeDelta);
			sunManager.update(timeDelta);
			
			// Update screens
			_levelSelectScreen1.update(timeDelta);
			
			// Prepare to shoot projectiles and suns
			var randomSide:int;
			var startXPosition:Number, startYPosition:Number;
			var shootXSpeed:Number, shootYSpeed:Number;
/*
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
			*/

			// if faded out destroy scene
			if (fadedOut) {
				destroy();
				fadeIn();
			}
			
			_menuScrollCheck();
			
		}
		
		override public function destroy():void
		{
			super.destroy();
			_themeChannel.stop();
		}
		
		private function _setMenuScreen(i:int):void
		{
			backgroundLayer.x -= (i-1) * Starling.current.stage.stageWidth;
		}
		
		private function _menuScrollCheck():void
		{
			if (backgroundLayer.x > 0) { 
				backgroundLayer.x = 0;
			} else if (backgroundLayer.x < -(NUM_MENU_SCREENS - 1) * Starling.current.stage.stageWidth) {
				backgroundLayer.x = -(NUM_MENU_SCREENS - 1) * Starling.current.stage.stageWidth;
			} 
			backgroundLayer.x -= _currentPoint.x - _lastPoint.x;
		}
		
		private function onTouch(event:TouchEvent):void
		{
			
			var touchBagan:Touch = event.getTouch(this, TouchPhase.BEGAN);
			var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
			var touchMoved:Touch = event.getTouch(this, TouchPhase.MOVED);
			
			if (touchBagan)
			{
				_firstPoint.x = touchBagan.globalX;
				_firstPoint.y = touchBagan.globalY;
				_lastPoint.x = _firstPoint.x;
				_lastPoint.y = _firstPoint.y;
				_currentPoint.x = _firstPoint.x;
				_currentPoint.y = _firstPoint.y;					
			}
			
			if (touchMoved)
			{
				_lastPoint.x = _currentPoint.x;
				_lastPoint.y = _currentPoint.y;				
				_currentPoint.x = touchMoved.globalX;
				_currentPoint.y = touchMoved.globalY;	
			}
			
			if (touchEnded)
			{
				_endPoint.x = touchEnded.globalX;
				_endPoint.y = touchEnded.globalY;	
				_lastPoint.x = _endPoint.x;
				_lastPoint.y = _endPoint.y;
				_currentPoint.x = _endPoint.x;
				_currentPoint.y = _endPoint.y;				
			}
			
		}
				
	}
	
}
