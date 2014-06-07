package objects {
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Image;
	
	public class SplashImage extends GameEntity {

		private var _image:Image;
		
		public function SplashImage() {
			super();
			
			_image = getCorrectImage();
			addChild(_image);
			
			// Center Splash Image
			x = y = 0;
		}

		private function getCorrectImage():Image {
            // Get the scaling factor (1, 2, 3 etc)
            var scalingFactor:int = Math.round(Starling.contentScaleFactor);
            if (scalingFactor == 1) {
				return new Image(Assets.splashscreen1xTexture);
            } 
            else if (scalingFactor == 2) {
                return new Image(Assets.splashscreen2xTexture);
            } 
            else {
                return new Image(Assets.splashscreen3xTexture);
            }
            // If you have a 4x version of the graphics, here is the place to add some code..
        }
		
	}
	
}
