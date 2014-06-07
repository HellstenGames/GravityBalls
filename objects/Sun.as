package objects  {
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Image;
	
	public class Sun extends GameEntity {

		public static var DEFAULT_MASS:Number = 2.0*10e+3;
		public var mass:Number
		
		private var _image:Image;
		
		public function Sun(cx:Number=0, cy:Number=0, dx:Number=0, dy:Number=0) {
			super();
			
			mass = DEFAULT_MASS;
			
			_image = getCorrectImage();
			addChild(_image);

			_dx = dx;
			_dy = dy;
			
			x = cx - _image.width/2;
			y = cy - _image.height/2;
		}
		
		private function getCorrectImage():Image {
            // Get the scaling factor (1, 2, 3 etc)
            var scalingFactor:int = Math.round(Starling.contentScaleFactor);
            
            if (scalingFactor == 1) {
				return new Image(Assets.sun1xTexture);
            } 
            else if (scalingFactor == 2) {
				return new Image(Assets.sun2xTexture);
            } 
            else {
				return new Image(Assets.sun3xTexture);
            }
            // If you have a 4x version of the graphics, here is the place to add some code..
        }
		
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
		}
		
	}
	
}
