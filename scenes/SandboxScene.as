package scenes {
	import objects.Projectile;
	import objects.BlackHole;
	import objects.Sun;
	
	
	// Import starling stuff
	import starling.utils.Color;	
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
	import fl.transitions.Fade;
	import graphics.Line;

	// Import project stuff
	import objects.SandboxMenu;
	import buttons.ExpandButton;
	
	
	public class SandboxScene extends Scene {

		private static var MAX_NUM_PROJECTILES:int = 100;
		private static var MAX_NUM_SUNS:int = 100;
		private static var MAX_SHOOT:Number = 25;
		private static var MIN_SHOOT:Number = 5;
		private static var OUT_OF_BOUNDS:Number = 200;
		private static var SPAWN_BOUNDARY:Number = 25;
		
		private var _backgroundLayer:Sprite, _playLayer:Sprite, _topLayer:Sprite;
		private var _menuLayer:Sprite;
		
		
		private var _backgroundImage:BackgroundImage;
		
		public var projectileManager:ProjectileManager;
		public var sunManager:SunManager;
		
		private var _themeChannel:SoundChannel;
		
		private var _sandBoxMenu:SandboxMenu;
		private var _expandButton:ExpandButton;
		
		public function SandboxScene() {
			super();
			
		}
		
		override public function init():void {
			super.init();

			_backgroundLayer = new Sprite();
			addChild(_backgroundLayer);
			_playLayer = new Sprite();
			addChild(_playLayer);
			_topLayer = new Sprite();
			addChild(_topLayer);
			_menuLayer = new Sprite();
			addChild(_menuLayer);
			
			_sandBoxMenu = new SandboxMenu(0, 0);
			_menuLayer.addChild(_sandBoxMenu);
			
			_backgroundImage = new BackgroundImage();
			_backgroundLayer.addChild(_backgroundImage);
			
			_expandButton = new ExpandButton(_sandBoxMenu, 25, 25);
			_topLayer.addChild(_expandButton);
			

			
			// Create managers and set their boundaries
			sunManager = new SunManager(_backgroundLayer, MAX_NUM_SUNS);
			sunManager.setBoundary(-OUT_OF_BOUNDS, -OUT_OF_BOUNDS, 
				Starling.current.nativeStage.stageWidth + OUT_OF_BOUNDS,
				Starling.current.nativeStage.stageHeight + OUT_OF_BOUNDS);
			sunManager.gravitate = true;
			
			projectileManager = new ProjectileManager(_backgroundLayer, MAX_NUM_PROJECTILES);
			projectileManager.setBoundary(-OUT_OF_BOUNDS, -OUT_OF_BOUNDS, 
				Starling.current.nativeStage.stageWidth + OUT_OF_BOUNDS,
				Starling.current.nativeStage.stageHeight + OUT_OF_BOUNDS);
			//_projectileManager.gravitate = true;
			
			Starling.current.nativeStage.addEventListener(TouchEvent.TOUCH, onTouch); 
			_backgroundLayer.addEventListener(TouchEvent.TOUCH, onTouch); 	
			
			// Play Theme
			_themeChannel = Assets.menuSound.play();	
			var transform:SoundTransform = new SoundTransform(1, 0.5);
			_themeChannel.soundTransform = transform;
		}
		
		override public function destroy():void {
			super.destroy();
			Starling.current.nativeStage.removeEventListener(TouchEvent.TOUCH, onTouch); 
			removeEventListener(TouchEvent.TOUCH, onTouch); 
			_themeChannel.stop();
		}

		override public function update(timeDelta:Number):void { 

			_expandButton.update(timeDelta);
			_sandBoxMenu.update(timeDelta);
			projectileManager.update(timeDelta);
			sunManager.update(timeDelta);
			sunManager.applyProjectileManager(projectileManager);

		}
		
		var beginPos:Point = new Point(0, 0), endPos:Point = new Point(0, 0), movingPos:Point = new Point(0, 0);
		var line:Line;
		var col:uint;
		
		private function onTouch(event:TouchEvent):void
		{
			var touchBegan:Touch = event.getTouch(this, TouchPhase.BEGAN);
			var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
			var touchMoving:Touch = event.getTouch(this, TouchPhase.MOVED);
			var touchHover:Touch = event.getTouch(this, TouchPhase.HOVER);
			
			if (touchBegan)
			{
				beginPos = touchBegan.getLocation(this);
			}
			
			if (touchEnded) 
			{
				endPos = touchEnded.getLocation(this);
				col = Math.floor(Math.random() * Projectile.COLORS.length);
				projectileManager.addProjectile(beginPos.x, beginPos.y, (beginPos.x-endPos.x)*3, (beginPos.y-endPos.y)*2, Projectile.COLORS[col]);
				removeChild(line);
			}
			
			if (touchMoving)
			{
				removeChild(line);
				movingPos = touchMoving.getLocation(this);
				line = new Line(beginPos.x, beginPos.y, movingPos.x, movingPos.y, 
					((Projectile.COLORS[col] == "blue") ? Color.BLUE : ((Projectile.COLORS[col] == "red") ? Color.RED : Color.GREEN)));
				addChild(line);				
			}
			
			if (touchHover)
			{
				var hoverPos:Point = touchHover.getLocation(this);
			}

		}
		
	}
	
}
