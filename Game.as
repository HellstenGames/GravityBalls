
package 
{
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	
	import scenes.SplashScene;
	import scenes.MenuScene;
	import scenes.PlayScene;
	import scenes.SandboxScene;
	
	public class Game extends Sprite
	{

		public static var INSTANCE:Game;
		
		public var current_scene:Scene;
		private var _lastTime:Number;
		
		// Game Objects
		public var splashImage:Sprite;

		
		// Game Scenes
		public var splashScene:Sprite;
		public var menuScene:Sprite;
		public var playScene:Sprite;
		public var splashScene:Sprite;
		
		public function Game()
		{
			Game.INSTANCE = this;
			
			// Load resources
			AssetResources.init();
			Assets.init();
			doneLoading = false;
			
			AssetResources.ASSETS_MANAGER.loadQueue(function(ratio:Number):void
			{
				trace("Loading assets, progress:", ratio);
			 
				if (ratio == 1.0)
				{
					Game.INSTANCE.addEventListener(Event.ENTER_FRAME, update);
					
					// Set up game scenes layer
					
					Game.INSTANCE.splashImage
				}
				
				
			});
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			current_scene = new SplashScene();
			_lastTime = new Date().getTime();
	
		}

		public function init(event:Event):void
		{
			current_scene.init();
			addChild(current_scene);
		}

		public function update(event:Event):void 
		{

			var now:Number = new Date().getTime();
			var delta:Number = now - _lastTime;
			_lastTime = now;
			
			if (!current_scene.isDone) {
				current_scene.update(delta/1000);
			} else {
				removeChild(current_scene);
				current_scene = current_scene.nextScene;
				current_scene.init();
				addChild(current_scene);
			}

		}
	}

}