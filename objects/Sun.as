package objects  {
	
	// Import project stuff
	import components.gbPhysicsComponent;
	import components.gbGraphicsComponent;
	
	public class Sun extends GameObject {

		public static var DEFAULT_MASS:Number = 2.0*10e+3;
		public var mass:Number
		
		public function Sun(cx:Number=0, cy:Number=0, dx:Number=0, dy:Number=0) 
		{
			super(null, new gbPhysicsComponent(), new gbGraphicsComponent());
			
			mass = DEFAULT_MASS;
			
			x = cx - width / 2;
			y = cy - height / 2;
		}
		
		override public function update(timeDelta:Number):void 
		{
			super.update(timeDelta);
		}
		
	}
	
}
