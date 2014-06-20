
package 
{
	
	// Import project stuff
	import scenes.*;
	
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

		// Game Sprites/Objects
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
				scene.update(delta / 1000);
			} else {
				removeChild(scene);
				scene = scene.nextScene;
				
				if (scene == null)
				{
					// Leave application
					NativeApplication.nativeApplication.exit();
					removeEventListener(Event.ENTER_FRAME, update);	
				}
				else 
				{
					scene.init();
					addChild(scene);
				}			
			}

		}

		private function onLoadComplete():void 
		{
			doneLoading = true;
		}
		
	}

}