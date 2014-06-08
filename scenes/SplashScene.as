package scenes {
	
	// Import project stuff
	import scenes.MenuScene;
	
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

		public static var SPLASH_DELAY:Number = 3.0;
		
		private var _delayedCall:DelayedCall;
		private var _splashDelayOver:Boolean;
		
		public function SplashScene() {
			super();
			_splashDelayOver = false;			
		}

		override public function init():void {
			super.init();

			nextScene = Game.INSTANCE.menuScene;
			
			// Load splash screen
			var loader:Loader = new Loader();
			loader.load ( new URLRequest ("assets/x3/splashscreen_x3.png") );
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
			sound.play();

			// Set splash delay
			_delayedCall = new DelayedCall(splashDelay, SplashScene.SPLASH_DELAY);
			_delayedCall.repeatCount = 1;
			Starling.juggler.add(_delayedCall);		
		}
		
		override public function destroy():void { 
			super.destroy();
			Starling.juggler.remove(_delayedCall);	
		}
		
		override public function update(timeDelta:Number):void { 
			super.update(timeDelta);
			
			if (Game.INSTANCE.doneLoading && _splashDelayOver)
			{
				destroy();
			}
			
		}
		
		private function splashDelay():void {
			_splashDelayOver = true;
		}
		
	}
	
}
