package objects {
	import starling.display.Image;
	
	public class Asteroid extends Entity {
	
		public static var ROTATION_MAX:Number = 0.09;
		public static var ROTATION_MIN:Number = -0.09;
		
		public var mass:Number;
		
		public var startCX:Number, startCY:Number, startDX:Number, startDY:Number;
		public var rotationSpeed:Number;
		
		public function Asteroid() 
		{
			super();

			mass = 1.0;
			addChild(new Image(AssetResources.asteroidTexture));
			alignPivot();
			rotationSpeed = 0.0;
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			rotation += rotationSpeed;
		}

	}
	
}
