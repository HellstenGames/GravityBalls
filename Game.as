
package 
{
	
	// Import project stuff
	import scenes.*;

	import managers.ProjectileManager;
	import managers.SunManager;
	
	// Import starling stuff
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.display.Image;
	
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.events.Touch;


	// Import flash stuff
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.display3D.textures.Texture;
	import flash.geom.Point;
	import flash.desktop.NativeApplication;
	
	public class Game extends Sprite
	{

		public static var INSTANCE:Game;
		
		
		private var _lastTime:Number;
		public var doneLoading:Boolean;

		
		public static var MAX_NUM_PROJECTILES:int = 100;
		public static var MAX_NUM_SUNS:int = 10;
		public static var MAX_SHOOT:Number = 30;
		public static var MIN_SHOOT:Number = 25;
		public static var OUT_OF_BOUNDS:Number = 100;
		public static var SPAWN_BOUNDARY:Number = 0;
		public static var BACKGROUND_ALPHA:Number = 1.0;
		public static var MENU_SPACE_RATIO:Number = 1.5;

		public static var TOUCH_SCALE_AMOUNT:Number = 1.25;
		public static var BUTTON_DELAY_PERIOD:Number = 0.25;
		
		// Game Sprites/Objects
		public var splashImage:Sprite;
		
		public var projectileManager:ProjectileManager;
		public var sunManager:SunManager;
		
		public var backgroundLayer:Sprite, menuLayer:Sprite;

		public var playButton:Sprite, exitButton:Sprite, sandboxButton:Sprite;
		
		// Game Scenes
		//public var playScene:PlayScene;
		//public var sandboxScene:SandboxScene;
		public var scene:Scene;
		
		
		public function Game()
		{
			Game.INSTANCE = this;
			doneLoading = false;
			
			//menuScene = new MenuScene();
			//playScene = new PlayScene();
			//sandboxScene = new SandboxScene();
			//scene = splashScene;
			
			/*
			backgroundLayer = new Sprite();			
			menuScene.addChild(backgroundLayer);
			menuLayer = new Sprite();
			menuScene.addChild(menuLayer);
			
			playButton = new Sprite();
			sandboxButton = new Sprite();
			exitButton = new Sprite();
			playButton.addEventListener(TouchEvent.TOUCH, onPlayTouch); 
			exitButton.addEventListener(TouchEvent.TOUCH, onExitTouch); 
			sandboxButton.addEventListener(TouchEvent.TOUCH, onSandboxTouch); 
			*/
			
			// Load resources
			AssetResources.setOnLoadComplete(onLoadComplete);
			AssetResources.init();

	
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);		
			_lastTime = new Date().getTime();
	
		}

		public function init(event:Event):void
		{
			scene = new SplashScene();
			scene.init();
			addChild(scene);
		}

		public function update(event:Event):void 
		{

			var now:Number = new Date().getTime();
			var delta:Number = now - _lastTime;
			_lastTime = now;
			
			if (!scene.isDone) {
				scene.update(delta/1000);
			} else {
				removeChild(scene);
				scene = scene.nextScene;
				
				if (scene == null)
				{
					// Leave application
					NativeApplication.nativeApplication.exit();
					removeEventListener(Event.ENTER_FRAME, update);	
				}
				else {
					scene.init();
					addChild(scene);
				}			
			}

		}
		
		
		private function onLoadComplete():void 
		{
			/* Play Button Sprite */
			/*
			var playBallImage:Image = new Image(AssetResources.playBallTexture);
			var playTextImage:Image = new Image(AssetResources.playTextTexture);

			playTextImage.x = playBallImage.width / 2 - playTextImage.width / 2;
			playTextImage.y = playBallImage.height / 2 - playTextImage.height / 2;
					
			this.playButton.addChild(new Image(AssetResources.playBallTexture));
			this.playButton.addChild(playTextImage);
					
			this.playButton.x = Starling.current.stage.stageWidth / 2 - AssetResources.playButton.width / 2 * 4;
			this.playButton.y = Starling.current.stage.stageHeight / 2 - AssetResources.playButton.height / 2;
			*/
					/* Sandbox Button Sprite */
			/*
					var sandboxBallImage:Image = new Image(AssetResources.sandboxBallTexture);
					var sandboxTextImage:Image = new Image(AssetResources.sandboxTextTexture);

					sandboxTextImage.x = sandboxBallImage.width / 2 - sandboxTextImage.width / 2;
					sandboxTextImage.y = sandboxBallImage.height / 2 - sandboxTextImage.height / 2;
					
					AssetResources.sandboxButton.addChild(new Image(AssetResources.sandboxBallTexture));
					AssetResources.sandboxButton.addChild(sandboxTextImage);
					
					AssetResources.sandboxButton.x = Starling.current.stage.stageWidth / 2 - AssetResources.sandboxButton.width / 2;
					AssetResources.sandboxButton.y = Starling.current.stage.stageHeight / 2 - AssetResources.sandboxButton.height / 2;
			*/
					/* Exit Button Sprite */
					
			/*
					var exitBallImage:Image = new Image(AssetResources.exitBallTexture);
					var exitTextImage:Image = new Image(AssetResources.exitTextTexture);

					exitTextImage.x = exitBallImage.width / 2 - exitTextImage.width / 2;
					exitTextImage.y = exitBallImage.height / 2 - exitTextImage.height / 2;
					
					AssetResources.exitButton.addChild(new Image(AssetResources.exitBallTexture));
					AssetResources.exitButton.addChild(exitTextImage);
					
					AssetResources.exitButton.x = Starling.current.stage.stageWidth / 2 + AssetResources.exitButton.width / 2 * 2;
					AssetResources.exitButton.y = Starling.current.stage.stageHeight / 2 - AssetResources.exitButton.height / 2;
			*/
					
					// Set up layers
					
					/* Background Layer */
				//	AssetResources.backgroundLayer.addChild(new Image(AssetResources.backgroundTexture));
					
					/* Menu Layer */
					/*
					AssetResources.menuLayer.addChild(new Image(AssetResources.backgroundTexture));
					AssetResources.menuLayer.addChild(AssetResources.playButton);
					AssetResources.menuLayer.addChild(AssetResources.sandboxButton);
					AssetResources.menuLayer.addChild(AssetResources.exitButton);
					*/

					// Create managers and set their boundaries
					/*
					AssetResources.projectileManager = new ProjectileManager(backgroundLayer, MAX_NUM_PROJECTILES);
					AssetResources.projectileManager.setBoundary(-OUT_OF_BOUNDS, -OUT_OF_BOUNDS, 
						Starling.current.nativeStage.stageWidth + OUT_OF_BOUNDS,
						Starling.current.nativeStage.stageHeight + OUT_OF_BOUNDS);
					//_projectileManager.gravitate = true;
					
					AssetResources.sunManager = new SunManager(backgroundLayer, MAX_NUM_SUNS);
					AssetResources.sunManager.setBoundary(-OUT_OF_BOUNDS, -OUT_OF_BOUNDS, 
						Starling.current.nativeStage.stageWidth + OUT_OF_BOUNDS,
						Starling.current.nativeStage.stageHeight + OUT_OF_BOUNDS);
					AssetResources.sunManager.gravitate = true;
					AssetResources.sunManager.projectileManager = AssetResources.projectileManager;
			*/
			
			

			doneLoading = true;
			
		}
		
		// =========================================================================================================================================================
		// Touch Events
		// =========================================================================================================================================================
		
		/*
		private function onPlayTouch(event:TouchEvent):void
		{
			// Scale button if touched
			var touchBagan:Touch = event.getTouch(this, TouchPhase.BEGAN);
			var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
			var touchMoved:Touch = event.getTouch(this, TouchPhase.MOVED);
			
			var cx:Number = playButton.width / 2;
			var cy:Number = playButton.height / 2;
			trace(cx, cy);
			playButton.scaleX = playButton.scaleY = touchBagan || touchMoved ? TOUCH_SCALE_AMOUNT : 1;
			
			playButton.x = cx - width / 2;
			playButton.y = cy - height / 2;
			
			// If touched trigger call back
			if (touchEnded) 
			{
				// Make sure button "looks" like its being pressed
				var endPos:Point = touchEnded.getLocation(this);
				if (endPos.x >= 0 && endPos.y >= 0 && endPos.x <= this.width && endPos.y <= this.height) 
				{
					//blackHoleCollisionSound.play();					
				}
			}
		}

		private function onSandboxTouch(event:TouchEvent):void
		{
			
		}
		
		private function onExitTouch(event:TouchEvent):void
		{
			
		}
		*/
	}

}