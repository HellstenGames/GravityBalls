package scenes {
	
	// Import starling stuff
	import starling.display.Sprite;
	import starling.core.Starling;
	
	// Import project stuff
	import managers.ProjectileManager;
	import managers.SunManager;
	import objects.Background;
	
	public class PlayScene extends Scene {

		public static var MAX_PROJECTILES:int = 25;
		public static var MAX_SUNS:int = 3;
		
		public var projectileManager:ProjectileManager;
		public var sunManager:SunManager;
		
		public var background:Sprite;
		
		// Layers
		public var backgroundLayer:Sprite;
		
		public function PlayScene()
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
			
			// Create Managers
			projectileManager = new ProjectileManager(backgroundLayer, MAX_PROJECTILES);
			sunManager = new SunManager(backgroundLayer, projectileManager, MAX_PROJECTILES);
		}

		override public function update(timeDelta:Number):void 
		{ 
			super.update(timeDelta);
			
			// Update Managers
			projectileManager.update(timeDelta);
			sunManager.update(timeDelta);
			
		}
		
	}
	
}
