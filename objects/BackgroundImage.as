package objects {
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Image;
	
	public class BackgroundImage extends GameEntity  {

		private var _image:Image;
		
		public function BackgroundImage() {
			super();
			
			_image = getCorrectImage();
			addChild(_image);
			
			x = y = 0;
		}

		private function getCorrectImage():Image {
            // Get the scaling factor (1, 2, 3 etc)
            var scalingFactor:int = Math.round(Starling.contentScaleFactor);
            if (scalingFactor == 1) {
				return new Image(Assets.background1xTexture);
            } 
            else if (scalingFactor == 2) {
                return new Image(Assets.background2xTexture);
            } 
            else {
                return new Image(Assets.background3xTexture);
            }
            // If you have a 4x version of the graphics, here is the place to add some code..
        }
		
	}
	
}
