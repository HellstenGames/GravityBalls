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
	import graphics.Rectangle;


	public class SplashScene extends Scene {

		public static var SPLASH_DELAY:Number = 1.0;
		public static var LOAD_DOT_SIZE:Number = 4;
		public static var LOAD_DOT_SPACE:Number = 4;
		public static var LOAD_DOT_TOP:Number = 305;
		public static var LOAD_DOTS_LEFT:Number = 450;
		public static var LOAD_DOT_DELAY:Number = 0.5;
		
		private var _delayedCall:DelayedCall;
		private var _splashDelayComplete:Boolean;
		
		// Images
		private var _splashImage:Image;
		private var _loadImage:Image;
		
		// Loading dots
		private var _loadDots:Array;
		private var _loadDotCounter:Number;
		
		public function SplashScene() 
		{
			super();
			nextScene = new StartScene();
			_loadDots = null;
			_loadDotCounter = 0;
		}

		override public function init():void
		{		
			super.init();
			_splashDelayComplete = true;

			var sf:String = String(Math.round(Starling.contentScaleFactor));
			var appDir:File = File.applicationDirectory;

			// Load splash screen
			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
			var loader:Loader = new Loader();
			loader.load ( new URLRequest (appDir.resolvePath("assets/x" + sf + "/loadscreen.png").url) , loaderContext);
			loader.contentLoaderInfo.addEventListener ( Event.COMPLETE, onComplete );	

		}
		
		private function onComplete( e:Event ):void
		{
			var scalingFactor:int = Math.round(Starling.contentScaleFactor);
			var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;
			_loadImage = new Image(Texture.fromBitmap ( loadedBitmap, true, false, scalingFactor));
			addChild(_loadImage);
			
			_loadDots = [];
			for (var i:int = 0; i < 3; ++i)
			{
				_loadDots[i] = new Rectangle(LOAD_DOTS_LEFT + i * LOAD_DOT_SIZE + i * LOAD_DOT_SPACE, LOAD_DOT_TOP, LOAD_DOT_SIZE, LOAD_DOT_SIZE, Color.WHITE);
				_loadDots[i].visible = false;
				trace(_loadDots[i].x, _loadDots[i].y);
				addChild(_loadDots[i]);
			}
			
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
			{
				fadeOut();
				if (fadedOut) {
					destroy();
					fadeIn();
				}
			} 
			else 
			{
				
				if (_loadDots)
				{
					_loadDotCounter += timeDelta;
					if (_loadDotCounter > LOAD_DOT_DELAY)
					{
						_loadDotCounter = 0;
						// Show loading dots
						for (var i:int = 0; i < 3; ++i)
						{			
							if (!_loadDots[i].visible)
							{
								_loadDots[i].visible = true;
								break;
							} 
							else if (i == 2)
							{
								_loadDots[0].visible = true;
								_loadDots[1].visible = false;
								_loadDots[2].visible = false;
							}
						}
					}
				}
				
			}


			
		}
		
		public function splashDelay():void
		{
			_splashDelayComplete = true;
		}
		
		
	}
	
}
