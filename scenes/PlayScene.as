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
	
	import utils.LevelLoader;
	import graphics.Line;
	
	import objects.Background;
	import objects.Player;
	import objects.Arrow;

	import objects.LivesCounter;
	import objects.Projectile;
	import objects.DeathCounter;
	import objects.OptionRollOut;
	
	import buttons.SuicideButton;
	import buttons.FocusButton;
	
	import text.DeathTimer;
	import text.StarsLeftText;
	import text.HereText;
	
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
		public static var FONT_TYPE:String = "white";
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
		public var optionRollOut:OptionRollOut;
		public var suicideButton:SuicideButton;
		public var focusButton:FocusButton;
		
		// Texts
		public var scoreText:TextField;
		public var starsLeftText:StarsLeftText;
		public var deathCounter:DeathCounter;
		public var deathTimer:DeathTimer;
		public var hereText:HereText;
		
		// Layers
		public var playLayer:Sprite;
		public var playBackgroundLayer:Sprite;
		
		public var textLayer:Sprite;
		public var trailLayer:Sprite;
		public var topLayer:Sprite;
		
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
			
			playLayer = new Sprite();
			addChild(playLayer);
			playBackgroundLayer = new Sprite();	
			playLayer.addChild(playBackgroundLayer);
			trailLayer = new Sprite();
			playLayer.addChild(trailLayer);
			
			textLayer = new Sprite();
			addChild(textLayer);	
			
			topLayer = new Sprite();
			addChild(topLayer);
			
			// Create/Add background
			background = new Background();
			backgroundLayer.addChild(background);
		
			// Create other stuff
			player = new Player();
			
			// Create Managers
			textManager = new TextManager(playLayer);
			projectileManager = new ProjectileManager(playLayer, MAX_PROJECTILES);
			sunManager = new SunManager(playLayer, projectileManager, MAX_PROJECTILES);
			blackholeManager = new BlackholeManager(playLayer, projectileManager, MAX_BLACKHOLES);
			playerManager = new PlayerManager(playLayer, player, this);
			starManager = new StarManager(playLayer, this);
			asteroidManager = new AsteroidManager(playLayer);
			wallManager = new WallManager(playLayer);
			trailManager = new TrailManager(trailLayer);
			
			// Load Level
			_level = START_LEVEL;
			LevelLoader.load_level(AssetResources.levels[_level], this);			
			
			playerManager.setBoundary(-Constants.kMapBoundaryBuffer, -Constants.kMapBoundaryBuffer, 
									  Constants.kMapWidth + Constants.kMapBoundaryBuffer, Constants.kMapHeight + Constants.kMapBoundaryBuffer);
									  
			// Create/add other objects
		
			scoreText  = new TextField(SCORE_WIDTH, SCORE_HEIGHT, "Score: 0", FONT_TYPE, FONT_SIZE, FONT_COLOR, FONT_ISBOLD);
			scoreText.x = SCORE_OFFSETX;
			scoreText.y = SCORE_OFFSETY;
			textLayer.addChild(scoreText);
		
			starsLeftText = new StarsLeftText(starManager.stars.length);
			textLayer.addChild(starsLeftText);
			
			deathTimer = new DeathTimer();
			addEntity(deathTimer);
			textLayer.addChild(deathTimer);

			/* Add here text */
			hereText = new HereText(player);
			hereText.show();
			addEntity(hereText);
			playLayer.addChild(hereText);
			
			/*
			livesCounter = new LivesCounter(MAX_LIVES, player);
			livesCounter.x = Starling.current.stage.stageWidth - livesCounter.width - LivesCounter.LIVES_OFFSET * 2;
			livesCounter.y = SCORE_OFFSET;
			textLayer.addChild(livesCounter);
			*/
			deathCounter = new DeathCounter();
			textLayer.addChild(deathCounter);
			
			/* Add to top layer */
			suicideButton = new SuicideButton(this);
			suicideButton.cx = Constants.kebPositionCX;
			suicideButton.cy = Constants.kebPositionCY;
			topLayer.addChild(suicideButton);
			
			/* Add Focus Button */
			focusButton = new FocusButton(this);
			focusButton.cx = Constants.kfbPositionCX;
			focusButton.cy = Constants.kfbPositionCY;
			topLayer.addChild(focusButton);
			
			_scoreCount = 0;
			_themeChannel = AssetResources.playTheme.play(0, int.MAX_VALUE); /* Loop main theme */
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
				starsLeftText.maxLeft = starManager.stars.length;
				starsLeftText.starsLeft = starManager.stars.length;
				playerManager.setBoundary(-Constants.kMapBoundaryBuffer, -Constants.kMapBoundaryBuffer, 
									  Constants.kMapWidth + Constants.kMapBoundaryBuffer, Constants.kMapHeight + Constants.kMapBoundaryBuffer);				
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
		
		public function keepMapInBoundary(layer:Sprite):void
		{
			var dirs:Array = Physics.boundaryCollision(layer.x, layer.y, Constants.kCameraWidth, Constants.kCameraHeight, 0, 0, Constants.kMapWidth, Constants.kMapHeight, false);
			var dirlength:int = dirs.length;
			for (var i:int = dirs.length - 1; i >= 0; --i)
			{
				if (dirs[i] == Physics.DIR_LEFT)
				{
					layer.x = 0;
				} 
				else if (dirs[i] == Physics.DIR_TOP)
				{
					layer.y = 0;
				}
				else if (dirs[i] == Physics.DIR_RIGHT)
				{
					layer.x = Constants.kCameraWidth - Constants.kMapWidth;
				}
				else if (dirs[i] == Physics.DIR_BOTTOM)
				{
					layer.y = Constants.kCameraHeight - Constants.kMapHeight;
				}
			}	
		}
		
		private function _touchMoveMap(touch:Touch, layer:Sprite):void
		{
			var currentPos:Point  = touch.getLocation(this);
			var previousPos:Point = touch.getPreviousLocation(this);
	
			/* Move Scene */
			layer.x += (currentPos.x - previousPos.x) * Constants.SCENE_MOVE_RATIO;
			layer.y += (currentPos.y - previousPos.y) * Constants.SCENE_MOVE_RATIO;
			
			keepMapInBoundary(layer);

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
			
			if (!player.beingTouched)
			{
				var touches:Vector.<Touch> = event.getTouches(this, TouchPhase.MOVED);
				
				if (touches.length == 1) /* Single finger touch */
				{
					_touchMoveMap(touches[0], playLayer);
				}
				else if (touches.length == 2) /* Two finger touch */
				{
					//_zoomScene(touches[0], touches[1]);		
				}
			}
			
		}
		
	}
	
}
