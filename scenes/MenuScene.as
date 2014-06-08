package scenes {
	import objects.Projectile;
	import objects.BlackHole;
	import objects.Sun;
	
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

	import scenes.PlayScene;
	import starling.display.Image;

	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import objects.SandboxButton;
	
	public class MenuScene extends Scene {

		private static var MAX_NUM_PROJECTILES:int = 20;
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
		
		private var _projectileManager:ProjectileManager;
		private var _sunManager:SunManager;
		
		private var _themeChannel:SoundChannel;
		
		public function MenuScene() {
			super();
			
			nextScene = new PlayScene();
			
		}
		
		override public function init():void {
			super.init();

			_backgroundLayer = new Sprite();
			_backgroundLayer.alpha = BACKGROUND_ALPHA;
			addChild(_backgroundLayer);
			
			_menuLayer = new Sprite();
			addChild(_menuLayer);
			
			_backgroundImage = new BackgroundImage();
			_backgroundLayer.addChild(_backgroundImage);
			
			// Create managers and set their boundaries
			_sunManager = new SunManager(_backgroundLayer, MAX_NUM_SUNS);
			_sunManager.setBoundary(-OUT_OF_BOUNDS, -OUT_OF_BOUNDS, 
				Starling.current.nativeStage.stageWidth + OUT_OF_BOUNDS,
				Starling.current.nativeStage.stageHeight + OUT_OF_BOUNDS);
			_sunManager.gravitate = true;
			
			_projectileManager = new ProjectileManager(_backgroundLayer, MAX_NUM_PROJECTILES);
			_projectileManager.setBoundary(-OUT_OF_BOUNDS, -OUT_OF_BOUNDS, 
				Starling.current.nativeStage.stageWidth + OUT_OF_BOUNDS,
				Starling.current.nativeStage.stageHeight + OUT_OF_BOUNDS);
			//_projectileManager.gravitate = true;
			
			
			/* Set menu buttons. */
			trace(Starling.current.nativeStage.stageWidth);
			_playButton = new PlayButton(this, 240, 160);
			_playButton.cx -= _playButton.width * MENU_SPACE_RATIO;
			_menuLayer.addChild(_playButton);
			
			_sandBoxButton = new SandboxButton(this, 240, 160);
			_menuLayer.addChild(_sandBoxButton);
			
			_exitButton = new ExitButton(this, 240, 160);
			_exitButton.cx += _exitButton.width * MENU_SPACE_RATIO;
			_menuLayer.addChild(_exitButton);
			

			
			// Play Theme
			//_themeChannel = Assets.menuSound.play();	
			//var transform:SoundTransform = new SoundTransform(1, 0.5);
			//_themeChannel.soundTransform = transform;
		}
		
		override public function destroy():void {
			super.destroy();
			_themeChannel.stop();
		}

		override public function update(timeDelta:Number):void { 
			
			// Update Menu Items
			_playButton.update(timeDelta);
			_exitButton.update(timeDelta);
			_sandBoxButton.update(timeDelta);
			
			_projectileManager.update(timeDelta);
			_sunManager.update(timeDelta);
			_sunManager.applyProjectileManager(_projectileManager);
			
			var randomSide:int;
			var startXPosition:Number, startYPosition:Number;
			var shootXSpeed:Number, shootYSpeed:Number;
			
			// Create projectiles
			if (_projectileManager.projectileCount < MAX_NUM_PROJECTILES) {
				
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
				_projectileManager.addProjectile(startXPosition, startYPosition, shootXSpeed, shootYSpeed, Projectile.COLORS[random_color]);
				
	
			}
			
			// Create suns
			if (_sunManager.sunCount < MAX_NUM_SUNS) {
				
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

				_sunManager.addSun(startXPosition, startYPosition, shootXSpeed, shootYSpeed);
			}
	
		}

	}
	
}
