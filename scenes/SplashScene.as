package scenes {
	
	// Import project stuff

	
	// Import starling stuff
	import starling.display.Image;
	import starling.core.Starling;
	import starling.animation.DelayedCall;
	import starling.textures.Texture;
	
	// Import flash stuff
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.media.Sound;
	

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
			// Load splash screen
			var loader:Loader = new Loader();
			var sf:String = String(Starling.contentScaleFactor);
			trace("assets/x3/splashscreen_x" + String(Starling.contentScaleFactor) + ".png");
			loader.load ( new URLRequest ("assets/x"+sf+"/splashscreen.png") );
			loader.contentLoaderInfo.addEventListener ( Event.COMPLETE, onComplete );				
		}
		
		private function onComplete( e:Event ):void
		{
			var scalingFactor:int = Math.round(Starling.contentScaleFactor);
			var loadedBitmap:Bitmap = e.currentTarget.loader.content as Bitmap;
			addChild(new Image(Texture.fromBitmap ( loadedBitmap, true, false, scalingFactor)));

			// Load Sound
			var sound:Sound = new Sound();    
			sound.load( new URLRequest ("assets/sfx/splashtheme.mp3") );
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
