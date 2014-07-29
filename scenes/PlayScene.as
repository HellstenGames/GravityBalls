package scenes {
	
	// Import starling stuff
	import starling.display.Sprite;
	import starling.core.Starling;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
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
	import objects.DeathCounter;
	
	// Import flash stuff
	import flash.media.SoundChannel;
	import flash.geom.Point;
	
	import managers.TrailManager;
	import managers.AsteroidManager;
	import managers.WallManager;
	
	/* Admob extension */
	import com.brinkbit.admob.AdMobAd;
	import com.brinkbit.admob.constants.AdMobAdType;
	import com.brinkbit.admob.constants.AdMobAdPosition;
	import com.brinkbit.admob.event.AdMobEvent;

	public class PlayScene extends Scene {

		// Constants
		public static var MAX_PROJECTILES:int = 25;
		public static var MAX_SUNS:int = 10;
		public static var MAX_BLACKHOLES:int = 10;
		public static var SCORE_OFFSETX:int = 0, SCORE_OFFSETY:int = 10;
		public static var SCORE_WIDTH:int = 100;
		public static var SCORE_HEIGHT:int = 25;
		public static var MAX_LIVES:int = 3;
		
		public static var FONT_SIZE:int = 14;
		public static var FONT_COLOR:uint = Color.WHITE;
		public static var FONT_TYPE:String = "Arial";
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
		//public var livesCounter:LivesCounter;
		public var deathCounter:DeathCounter;
		
		// Layers
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
			scoreText.x = SCORE_OFFSETX;
			scoreText.y = SCORE_OFFSETY;
			textLayer.addChild(scoreText);
			
			/*
			livesCounter = new LivesCounter(MAX_LIVES, player);
			livesCounter.x = Starling.current.stage.stageWidth - livesCounter.width - LivesCounter.LIVES_OFFSET * 2;
			livesCounter.y = SCORE_OFFSET;
			textLayer.addChild(livesCounter);
			*/
			deathCounter = new DeathCounter();
			textLayer.addChild(deathCounter);
			
			_scoreCount = 0;
			_themeChannel = AssetResources.playTheme.play();
			
			Constants.PLAY_SCENE_BANNER.showAd();		
			
			/* Add scene touch event */
			addEventListener(TouchEvent.TOUCH, _onSceneTouch);
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
			Constants.PLAY_SCENE_BANNER.hideAd();	
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
		
		private function _moveScene(touch:Touch):void
		{
			var currentPos:Point  = touch.getLocation(this);
			var previousPos:Point = touch.getPreviousLocation(this);
	
			/* Move Scene */
			x += currentPos.x - previousPos.x;
			y += currentPos.y - previousPos.y;
			
			var dir:int = Physics.boundaryCollision(x, y, width, height, 0, 0, width, height);
			if (dir == Physics.DIR_LEFT)
			{
				x = 0;
			}
			else if (dir == Physics.DIR_TOP)
			{
				y = 0;
			}
			else if (dir == Physics.DIR_BOTTOM)
			{
				y = height - Constants.CAMERA_HEIGHT;
			}
			else if (dir == Physics.DIR_RIGHT)
			{
				x = width - Constants.CAMERA_WIDTH;
			}
			
		}
		
		private function _zoomScene(touch1:Touch, touch2:Touch):void
		{
				
			var touch1CurrentPos:Point  = touch1.getLocation(this);
			var touch1PreviousPos:Point = touch1.getPreviousLocation(this);				
			var touch2CurrentPos:Point  = touch2.getLocation(this);
			var touch2PreviousPos:Point = touch2.getPreviousLocation(this);	
				
			/* Determine which is left or right pos */
			var leftPosCurrent:Point, leftPosPrevious:Point, rightPosCurrent:Point, rightPosPrevious:Point;
				
			if (touch1CurrentPos.x < touch2CurrentPos.x) 
			{
				leftPosCurrent = touch1CurrentPos;
				leftPosPrevious = touch1PreviousPos;
				rightPosCurrent = touch2CurrentPos;
				rightPosPrevious = touch2PreviousPos;
			}
			else
			{
				leftPosCurrent = touch2CurrentPos;
				leftPosPrevious = touch2PreviousPos;
				rightPosCurrent = touch1CurrentPos;
				rightPosPrevious = touch1PreviousPos;
			}
				
				
			/* Get directions */
			var leftTouchDelta:Number, rightTouchDelta:Number;
				
			leftTouchDelta = leftPosCurrent.x - leftPosPrevious.x;
			rightTouchDelta = rightPosCurrent.x - rightPosPrevious.x;
			
			if (leftTouchDelta < 0 && rightTouchDelta > 0)
			{
				scaleX = scaleY -= Constants.ZOOM_SCALE_AMOUNT;
				if (scaleX < Constants.ZOOM_MIN) 
				{
					scaleX = scaleY = Constants.ZOOM_MIN;
				}
			}
			else if (leftTouchDelta > 0 && rightTouchDelta < 0)
			{
				scaleX = scaleY += Constants.ZOOM_SCALE_AMOUNT; 
				if (scaleX > Constants.ZOOM_MAX)
				{
					scaleX = scaleY = Constants.ZOOM_MAX;
				}
			}
			
		}
		
		private function _onSceneTouch(event:TouchEvent):void
		{
			
			var touches:Vector.<Touch> = event.getTouches(this, TouchPhase.MOVED);
			
			if (touches.length == 1) /* Single finger touch */
			{
				_moveScene(touches[0]);
			}
			else if (touches.length == 2) /* Two finger touch */
			{
				//_zoomScene(touches[0], touches[1]);		
			}
			
		}
		
	}
	
}
