package scenes {
	
	// Import starling stuff
	import starling.display.Sprite;
	import starling.core.Starling;
	import starling.text.TextField;
	import starling.utils.Color;
	
	// Import project stuff
	import managers.ProjectileManager;
	import managers.SunManager;
	import managers.PlayerManager;
	import managers.BlackholeManager;
	import managers.StarManager;
	import objects.Background;
	import objects.Player;
	import utils.LevelLoader;
	import graphics.Line;
	
	// Import flash stuff
	import flash.media.SoundChannel;
	
	public class PlayScene extends Scene {

		// Constants
		public static var MAX_PROJECTILES:int = 25;
		public static var MAX_SUNS:int = 10;
		public static var MAX_BLACKHOLES:int = 10;
		public static var SCORE_OFFSET:int = 10;
		public static var SCORE_WIDTH:int = 100;
		public static var SCORE_HEIGHT:int = 25;
		
		public static var FONT_SIZE:int = 16;
		public static var FONT_COLOR:uint = Color.SILVER;
		public static var FONT_TYPE:String = "Arial";
		public static var FONT_ISBOLD:Boolean = true;
		
		// Managers
		public var projectileManager:ProjectileManager;
		public var sunManager:SunManager;
		public var blackholeManager:BlackholeManager;
		public var playerManager:PlayerManager;
		public var starManager:StarManager;
		
		// Objects
		public var player:Player;
		public var background:Sprite;
		
		// Texts
		public var deathText:TextField;
		
		// Layers
		public var backgroundLayer:Sprite;
		public var textLayer:Sprite;
		
		private var _themeChannel:SoundChannel;
		private var _level:int;
		private var _deathCount:int;
		
		public function PlayScene()
		{
			super();
		}

		override public function init():void
		{		
			super.init();
			
			// Create/Add Layers
			backgroundLayer = new Sprite();
			addChild(backgroundLayer);
			textLayer = new Sprite();
			addChild(textLayer);
			
			// Create/Add background
			background = new Background();
			backgroundLayer.addChild(background);
			
			// Create/add other objects
			deathText  = new TextField(SCORE_WIDTH, SCORE_HEIGHT, "Deaths: 0", FONT_TYPE, FONT_SIZE, FONT_COLOR, FONT_ISBOLD);
			deathText.x = Starling.current.stage.stageWidth - SCORE_WIDTH - SCORE_OFFSET;
			deathText.y = SCORE_OFFSET;
			textLayer.addChild(deathText);

			// Create Managers
			projectileManager = new ProjectileManager(backgroundLayer, MAX_PROJECTILES);
			sunManager = new SunManager(backgroundLayer, projectileManager, MAX_PROJECTILES);
			blackholeManager = new BlackholeManager(backgroundLayer, projectileManager, MAX_BLACKHOLES);
			playerManager = new PlayerManager(backgroundLayer, this);
			starManager = new StarManager(backgroundLayer);
			// Load Level
			_level = 1;
			LevelLoader.load_level(AssetResources.levels[_level], this);			
			
			_deathCount = 0;
			_themeChannel = AssetResources.playTheme.play();
		}

		override public function update(timeDelta:Number):void 
		{ 
			super.update(timeDelta);
			
			// Update Managers
			projectileManager.update(timeDelta);
			sunManager.update(timeDelta);
			blackholeManager.update(timeDelta);
			playerManager.update(timeDelta);
			starManager.update(timeDelta);
		}
		
		override public function destroy():void
		{
			super.destroy();
			_themeChannel.stop();
		}		
		
		public function set deathCount(value:int):void
		{		
			_deathCount = value;
			deathText.text = "Deaths: " + _deathCount;
		}
		
		public function get deathCount():int
		{
			return _deathCount;
		}
		
		public function nextLevel():void
		{
			_level ++;
			if (_level > AssetResources.NUM_OF_LEVELS)
			{
				nextScene = new SplashScene();
				destroy();	
			}
			else{
				clearLevel();
				LevelLoader.load_level(AssetResources.levels[_level], this);		
				_themeChannel.stop();
				_themeChannel = AssetResources.playTheme.play();
			}
		}
		
		public function clearLevel():void
		{
			projectileManager.removeAll();
			sunManager.removeAll();
			blackholeManager.removeAll();
			starManager.removeAll();
			playerManager.removePlayer();
		}
	}
	
}
