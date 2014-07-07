package scenes {

	// Import Sprites/Objects
	import objects.Background;
	import objects.SandboxMenu;
	
	// Import Managers
	import managers.ProjectileManager;
	import managers.PlayerManager;
	
	// Import starling stuff
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.display.Sprite;
	import flash.geom.Point;
	
	public class SandboxScene extends Scene {

		// Sprites/Entities/Objects
		private var _background:Sprite;
		private var _menu:SandboxMenu;
		
		// Layers
		private var _backgroundLayer:Sprite;
		private var _menuLayer:Sprite;
		private var _playLayer:Sprite;
		
		// Managers
		private var _projectileManager:ProjectileManager;
		private var _playerManager:PlayerManager;
		
		// Other
		private var _beganPoint:Point;
		private var _endPoint:Point;
		
		public function SandboxScene() 
		{
			super();
		}

		override public function init():void
		{		
			super.init();
			
			// Create/Add Layers
			_backgroundLayer = new Sprite();
			addChild(_backgroundLayer);	
			_playLayer = new Sprite();
			addChild(_playLayer);			
			_menuLayer = new Sprite();
			addChild(_menuLayer);
			
			// Create/Add background
			_background = new Background();
			_backgroundLayer.addChild(_background);		
			
			// Create Menu
			_menu = new SandboxMenu();
			_menu.x = 0;
			_menu.y = 0;
			_menuLayer.addChild(_menu);
			addEntity(_menu);
			
			// Create managers
			_projectileManager = new ProjectileManager(_playLayer);
			
			// Event listeners
			_backgroundLayer.addEventListener(TouchEvent.TOUCH, onTouch);
			
			// Other
			_beganPoint = new Point(0, 0);
			_endPoint = new Point(0, 0);
		}
		
		override public function update(timeDelta:Number):void 
		{ 
			super.update(timeDelta);
			// Update Managers
			_projectileManager.update(timeDelta);
			
			_background.x -= 0.1;
		}
		
		// Touch Callback functions
		private function onTouch(event:TouchEvent):void
		{
			
			var touchBegan:Touch = event.getTouch(this, TouchPhase.BEGAN);
			var touchEnd:Touch = event.getTouch(this, TouchPhase.ENDED);
			
			if (touchBegan)
			{
				_beganPoint.x = touchBegan.globalX;
				_beganPoint.y = touchBegan.globalY;
			}
			if (touchEnd)
			{
				_endPoint.x = touchEnd.globalX;
				_endPoint.y = touchEnd.globalY;
				// Create projectile
				_projectileManager.addProjectile(_beganPoint.x, _beganPoint.y, _beganPoint.x - _endPoint.x, _beganPoint.y - _endPoint.y);
			}
			
		}
		
	}
	
}
