package objects {
	import starling.display.Image;
	
	public class Projectile extends Entity {

		public static var COLORS:Array = new Array("blue", "green", "red");
		
		public var mass:Number;
		
		private var _image:Image;

		public function Projectile(color:String="blue") 
		{
			super();
			
			mass = 1.0;
			
			_image = getImage(color);
			addChild(_image);

		}

		public function set color(setValue:String):void {
			removeChild(_image);
			_image = getImage(setValue);
			addChild(_image);
		}
		
		private function getImage(color:String):Image
		{
			if (color == "blue") {
				return new Image(AssetResources.blueProjectileTexture);
			} else if (color == "green") {
				return new Image(AssetResources.greenProjectileTexture);
			} else { // default is blue
				return new Image(AssetResources.redProjectileTexture);
			}
		}
	}
	
}
