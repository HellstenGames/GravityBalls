package scenes {
	import starling.core.Starling;
	import starling.animation.DelayedCall;
	import objects.SplashImage;
	
	import scenes.MenuScene;
	
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class SplashScene extends Scene {

		public static var SPLASH_DELAY:Number = 3.0;
		
		private var delayedCall:DelayedCall;
		public var themeChannel:SoundChannel;
		
		public function SplashScene() {
			super();
			

		}

		override public function init():void {
			super.init();
			
			nextScene = new MenuScene();
			
			delayedCall = new DelayedCall(splashDelay, SplashScene.SPLASH_DELAY);
			delayedCall.repeatCount = 1;
			Starling.juggler.add(delayedCall);	
			
		//	themeChannel = Assets.assets.playSound("splashtheme");
			themeChannel = Assets.splashSound.play();
			var transform:SoundTransform = new SoundTransform(0.25, 0.5);
			themeChannel.soundTransform = transform;
			
		}
		
		override public function destroy():void { 
			super.destroy();
			Starling.juggler.remove(delayedCall);	
			themeChannel.stop();
		}
		
		override public function update(timeDelta:Number):void { 
			super.update(timeDelta);
		}
		
		private function splashDelay():void {
			destroy();
		}
		
	}
	
}
