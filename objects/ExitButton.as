﻿package objects {
	// Import project stuff
	import scenes.Scene;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.events.Touch;
	import scenes.SplashScene;
	
	import flash.desktop.NativeApplication;  

	
	public class ExitButton extends MenuButton {

		public function ExitButton(scene:Scene, cx:Number, cy:Number) {
			super(scene, cx, cy);
			
			var spriteClip:MovieClip = getCorrectBallImage();
			Starling.juggler.add(spriteClip);
			addChild(spriteClip);
			
			var textClip:MovieClip = getCorrectTextImage();
			textClip.x = spriteClip.width / 2 - textClip.width / 2;
			textClip.y = spriteClip.height / 2 - textClip.height / 2;
			Starling.juggler.add(textClip);
			addChild(textClip);
			
			// Center Button
			x = _cx - width / 2;
			y = _cy - height / 2;
			
		}

		private function getCorrectBallImage():MovieClip {
            // Get the scaling factor (1, 2, 3 etc)
            var scalingFactor:int = Math.round(Starling.contentScaleFactor);
            if (scalingFactor == 1) {
				return new MovieClip(Assets.mpAtlasMenu.getTextures("exit_ball_1x"), 1);
            } 
            else if (scalingFactor == 2) {
                return new MovieClip(Assets.mpAtlasMenu.getTextures("exit_ball_2x"), 1);
            } 
            else {
                return new MovieClip(Assets.mpAtlasMenu.getTextures("exit_ball_3x"), 1);
            }
            // If you have a 4x version of the graphics, here is the place to add some code..
        }
		
		private function getCorrectTextImage():MovieClip {
            // Get the scaling factor (1, 2, 3 etc)
            var scalingFactor:int = Math.round(Starling.contentScaleFactor);
            if (scalingFactor == 1) {
				return new MovieClip(Assets.mpAtlasMenu.getTextures("exittext_1x"), 1);
            } 
            else if (scalingFactor == 2) {
                return new MovieClip(Assets.mpAtlasMenu.getTextures("exittext_2x"), 1);
            } 
            else {
                return new MovieClip(Assets.mpAtlasMenu.getTextures("exittext_3x"), 1);
            }
            // If you have a 4x version of the graphics, here is the place to add some code..
        }
		
		override protected function onTouch(event:TouchEvent):void
		{
			super.onTouch(event);
		}

		override protected function touchCallBack():void 
		{
			super.touchCallBack();
			NativeApplication.nativeApplication.exit();
		}
		
		override public function update(timeDelta:Number):void 
		{
			super.update(timeDelta);
		}

		
	}
	
}
