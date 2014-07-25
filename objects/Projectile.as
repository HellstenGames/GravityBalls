package objects {
	import starling.display.Image;
	
	public class Projectile extends Entity {

		public static var COLORS:Array = new Array("red", "green", "blue", "brown", "yellow", "cyan", "white");
		
		public var mass:Number;
		
		private var _image:Image;
		private var _color:String;
		
		public function Projectile(color:String="blue") 
		{
			super();
			_color = color;
			
			mass = 1.0;
			
			_image = getImage(color);
			addChild(_image);

		}

		public function set color(setValue:String):void {
			_color = setValue;
			removeChild(_image);
			_image = getImage(setValue);
			addChild(_image);
		}
		
		public function get color():String
		{
			return _color;
		}
		
		private function getImage(color:String):Image
		{
			if (color == "blue") {
				return new Image(AssetResources.blueProjectileTexture);
			} else if (color == "green") {
				return new Image(AssetResources.greenProjectileTexture);
			} else if (color == "red") {
				return new Image(AssetResources.redProjectileTexture);
			} else if (color == "brown") {
				return new Image(AssetResources.brownProjectileTexture);
			} else if (color == "yellow") {
				return new Image(AssetResources.yellowProjectileTexture);
			} else if (color == "cyan") {
				return new Image(AssetResources.cyanProjectileTexture);
			} else { // white is default
				return new Image(AssetResources.whiteProjectileTexture);
			} 
		}
	}
	
}
