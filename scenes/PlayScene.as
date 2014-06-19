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
	import managers.TextManager;
	import objects.Background;
	import objects.Player;
	import utils.LevelLoader;
	import graphics.Line;
	import objects.LivesCounter;
	
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
		public static var MAX_LIVES:int = 3;
		
		public static var FONT_SIZE:int = 16;
		public static var FONT_COLOR:uint = Color.SILVER;
		public static var FONT_TYPE:String = "Verdana";
		public static var FONT_ISBOLD:Boolean = true;
		
		// Managers
		public var projectileManager:ProjectileManager;
		public var sunManager:SunManager;
		public var blackholeManager:BlackholeManager;
		public var playerManager:PlayerManager;
		public var starManager:StarManager;
		public var textManager:TextManager;
		
		// Objects
		public var player:Player;
		public var background:Sprite;
		
		// Texts
		public var scoreText:TextField;
		public var livesCounter:LivesCounter;
		
		// Layers
		public var backgroundLayer:Sprite;
		public var textLayer:Sprite;
		
		private var _themeChannel:SoundChannel;
		private var _level:int;
		private var _scoreCount:int;
		
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
		
			// Create other stuff
			player = new Player();
			
			// Create Managers
			projectileManager = new ProjectileManager(backgroundLayer, MAX_PROJECTILES);
			sunManager = new SunManager(backgroundLayer, projectileManager, MAX_PROJECTILES);
			blackholeManager = new BlackholeManager(backgroundLayer, projectileManager, MAX_BLACKHOLES);
			playerManager = new PlayerManager(backgroundLayer, player, this);
			starManager = new StarManager(backgroundLayer);
			textManager = new TextManager(textLayer);
			
			// Load Level
			_level = 1;
			LevelLoader.load_level(AssetResources.levels[_level], this);			
			
			// Create/add other objects
			scoreText  = new TextField(SCORE_WIDTH, SCORE_HEIGHT, "Score: 0", FONT_TYPE, FONT_SIZE, FONT_COLOR, FONT_ISBOLD);
			scoreText.x = SCORE_OFFSET;
			scoreText.y = SCORE_OFFSET;
			textLayer.addChild(scoreText);
			
			livesCounter = new LivesCounter(MAX_LIVES, player);
			livesCounter.x = Starling.current.nativeStage.stageWidth - livesCounter.width - LivesCounter.LIVES_OFFSET * 2;
			livesCounter.y = SCORE_OFFSET;
			textLayer.addChild(livesCounter);
			
			_scoreCount = 0;
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
			textManager.update(timeDelta);
		}
		
		override public function destroy():void
		{
			super.destroy();
			_themeChannel.stop();
		}		
		
		public function set scoreCounter(value:int):void
		{		
			_scoreCount = value;
			scoreText.text = "Score: " + _scoreCount;
		}
		
		public function get scoreCounter():int
		{
			return _scoreCount;
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
			textManager.removeAll();
		}
	}
	
}
