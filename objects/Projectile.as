package objects  {
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Image;
	
	public class Projectile extends GameEntity {

		public static var COLORS:Array = new Array("blue", "green", "red");
		public static var DEFAULT_MASS:Number = 1.0;
		public static var ROTATION_SPEED:Number = 0.10;
		
		public var mass:Number;
		
		private var _image:Image;
		private var _color:String;
		
		public function Projectile(cx:Number=0, cy:Number=0, dx:Number=0, dy:Number=0, color:String="blue") {
			super();
			
			mass = DEFAULT_MASS;
			
			// Get projectile image based on color and scaling factor
			_color = color;
			_image = getCorrectImage();
			addChild(_image);

			_dx = dx;
			_dy = dy;
			x = cx - width / 2;
			y = cy - height / 2;
			
			//alignPivot();
			//_rotationSpeed = (-Projectile.ROTATION_SPEED + (Projectile.ROTATION_SPEED - (-Projectile.ROTATION_SPEED)) * Math.random());
			

		}

		private function getCorrectImage():Image {
            // Get the scaling factor (1, 2, 3 etc)
            var scalingFactor:int = Math.round(Starling.contentScaleFactor);
            
			if (_color == "red")
			{
				return new Image(Game.INSTANCE.redProjectileTextures[scalingFactor]);
			}
			else if (_color == "green")
			{
				return new Image(Game.INSTANCE.greenProjectileTextures[scalingFactor]);
			}
			else
			{
				return new Image(Game.INSTANCE.blueProjectileTextures[scalingFactor]);
			}

        }
		
		public function set color(setValue:String):void {
			_color = setValue;
			removeChild(_image);
			_image = getCorrectImage();
			addChild(_image);
		}
		
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
		}
	}
	
}
