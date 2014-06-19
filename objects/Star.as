package objects {
	import starling.display.Image;
	import starling.utils.deg2rad;
	
	public class Star extends Entity {
	
		public static var SCALE_SPEED:Number = 0.01;
		public static var SCALE_MAX:Number = 1;
		public static var SCALE_MIN:Number = 0.5;
		
		public var scales:Boolean;
		
		public var originalCX:Number, originalCY:Number;
		
		public function Star() 
		{
			super();
			
			addChild(new Image(AssetResources.starTexture));
			scales = false;
			
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);

			cx = originalCX;
			cy = originalCY;
	
			// Scale star, keep it within max and min scales
			scaleX = scaleY += scales ? SCALE_SPEED : -SCALE_SPEED;
			scales = (scaleX >= SCALE_MAX) ? false : (scaleX <= SCALE_MIN) ? true : scales;
		}

	}
	
}
