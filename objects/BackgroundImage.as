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
			return new Image(Game.INSTANCE.backgroundTextures[scalingFactor]);
        }
		
	}
	
}
