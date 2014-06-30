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
	import managers.TrailManager;
	
	import objects.Background;
	import objects.Player;
	import objects.Arrow;
	import utils.LevelLoader;
	import graphics.Line;
	import objects.LivesCounter;
	import objects.Projectile;
	
	// Import flash stuff
	import flash.media.SoundChannel;
	import managers.TrailManager;
	import managers.AsteroidManager;
	import managers.WallManager;
	
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
		
		public static var START_LEVEL:int = 1;
		
		// Managers
		public var projectileManager:ProjectileManager;
		public var sunManager:SunManager;
		public var blackholeManager:BlackholeManager;
		public var playerManager:PlayerManager;
		public var starManager:StarManager;
		public var textManager:TextManager;
		public var trailManager:TrailManager;
		public var asteroidManager:AsteroidManager;
		public var wallManager:WallManager;
		
		// Objects
		public var player:Player;
		public var background:Sprite;
		public var arrow:Arrow;
		
		// Texts
		public var scoreText:TextField;
		public var livesCounter:LivesCounter;
		
		// Layers
		public var backgroundLayer:Sprite;
		public var playLayer:Sprite;
		public var textLayer:Sprite;
		public var trailLayer:Sprite;
		
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
			trailLayer = new Sprite();
			addChild(trailLayer);				
			playLayer = new Sprite();
			addChild(playLayer);													
			textLayer = new Sprite();
			addChild(textLayer);
			
			// Create/Add background
			background = new Background();
			backgroundLayer.addChild(background);
		
			// Create other stuff
			player = new Player();
			arrow = new Arrow(Arrow.ARROW_BLUE);
			arrow.visible = false;
			playLayer.addChild(arrow);
			
			// Create Managers
			textManager = new TextManager(textLayer);
			projectileManager = new ProjectileManager(playLayer, MAX_PROJECTILES);
			sunManager = new SunManager(playLayer, projectileManager, MAX_PROJECTILES);
			blackholeManager = new BlackholeManager(playLayer, projectileManager, MAX_BLACKHOLES);
			playerManager = new PlayerManager(playLayer, player, this);
			starManager = new StarManager(playLayer);
			trailManager = new TrailManager(trailLayer);
			asteroidManager = new AsteroidManager(playLayer);
			wallManager = new WallManager(playLayer);
			
			// Load Level
			_level = START_LEVEL;
			LevelLoader.load_level(AssetResources.levels[_level], this);			
			
			// Create/add other objects
			scoreText  = new TextField(SCORE_WIDTH, SCORE_HEIGHT, "Score: 0", FONT_TYPE, FONT_SIZE, FONT_COLOR, FONT_ISBOLD);
			scoreText.x = SCORE_OFFSET;
			scoreText.y = SCORE_OFFSET;
			textLayer.addChild(scoreText);
			
			livesCounter = new LivesCounter(MAX_LIVES, player);
			livesCounter.x = Starling.current.stage.stageWidth - livesCounter.width - LivesCounter.LIVES_OFFSET * 2;
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
			trailManager.update(timeDelta);
			asteroidManager.update(timeDelta);
			wallManager.update(timeDelta);
			
			// Fade the level out
			if (fadedOut)
			{
				nextLevel();
				fadeIn();
			} 

			// If player is being touched, show the arrow
			if (player.beingTouched)
			{
				// Rotate arrow accordingly
				var angle:Number = Math.atan2(player.began.y - player.currentPos.y, player.began.x - player.currentPos.x) + Math.PI;
				if (angle % Math.PI == 0)
					angle = 0;
					
				arrow.image.rotation = angle;
				// Get radius of player
				var pradius:Number = player.width;
	
				var bottom:Number = Math.sin(angle) * pradius;
				var right:Number = Math.cos(angle) * pradius;
				arrow.cx = player.cx + arrow.width / 2 - right;
				arrow.cy = player.cy + arrow.height / 2 - bottom;
				arrow.visible = true;						
				
			}
			else
			{
				arrow.visible = false;
			}
			
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
			playerManager.resetPlayer();
		}
		
		public function clearLevel():void
		{
			projectileManager.removeAll();
			sunManager.removeAll();
			blackholeManager.removeAll();
			starManager.removeAll();
			textManager.removeAll();
			trailManager.removeAll();
			asteroidManager.removeAll();
			wallManager.removeAll();
		}
	}
	
}
