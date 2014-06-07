package  {
	// Import starling stuff
	import starling.utils.AssetManager;
	
	// Import flash stuff
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.filesystem.File;
	
	
	public class AssetResources {

		public static var ASSETS_MANAGER:AssetManager;

		public static function init():void
		{
			// Set up assets manager
			ASSETS_MANAGER = new AssetManager();
			ASSETS_MANAGER.verbose = true;
			
			// Load assets/textures/sounds/etc using asset manager
			ASSETS_MANAGER.enqueue(Assets);
			
			var appDir:File = File.applicationDirectory;
			ASSETS_MANAGER.enqueue(appDir.resolvePath("assets/"));
			
		}
		
	}
	
}
