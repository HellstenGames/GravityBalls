package scenes {
	
	// Import project stuff

	
	// Import starling stuff
	import starling.display.Image;
	import starling.core.Starling;
	import starling.animation.DelayedCall;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	// Import flash stuff
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.system.LoaderContext;
	import flash.system.ImageDecodingPolicy;
	
	import starling.text.TextField;
	import flash.filesystem.File;
	
	public class SplashScene extends Scene {

		public static var SPLASH_DELAY:Number = 1.0;
		
		private var _delayedCall:DelayedCall;
		private var _splashDelayComplete:Boolean;
		
		public function SplashScene() 
		{
			super();
			nextScene = new MenuScene();
		}

		override public function init():void
		{		
			super.init();
			_splashDelayComplete = false;

			var sf:String = String(Math.round(Starling.contentScaleFactor));
			var appDir:File = File.applicationDirectory;

			// Load splash screen
			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
			var loader:Loader = new Loader();
			loader.load ( new URLRequest (appDir.resolvePath("assets/x" + sf + "/splashscreen.png").url) , loaderContext);
			loader.contentLoaderInfo.addEventListener ( Event.COMPLETE, onComplete );	
	
		}
		
		private function onComplete( e:Event ):void
		{
			var scalingFactor:int = Math.round(Starling.contentScaleFactor);
			var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;
			addChild(new Image(Texture.fromBitmap ( loadedBitmap, true, false, scalingFactor)));

			// Load Sound
			var appDir:File = File.applicationDirectory;
			var sound:Sound = new Sound();    
			sound.load( new URLRequest (appDir.resolvePath("assets/sfx/splashtheme.mp3").url) );
			/*
			var soundChannel:SoundChannel = sound.play();
			var transform:SoundTransform = new SoundTransform(0.25, 0.5);
			soundChannel.soundTransform = transform;
			*/
			
			// Set splash delay
			_delayedCall = new DelayedCall(splashDelay, SplashScene.SPLASH_DELAY);
			_delayedCall.repeatCount = 1;
			Starling.juggler.add(_delayedCall);		
		}

		override public function destroy():void 
		{
			super.destroy();
		}
		
		override public function update(timeDelta:Number):void 
		{ 
			super.update(timeDelta);
			
			if (_splashDelayComplete && Game.INSTANCE.doneLoading)
				destroy();

		}
		
		public function splashDelay():void
		{
			_splashDelayComplete = true;
		}
		
		
	}
	
}
