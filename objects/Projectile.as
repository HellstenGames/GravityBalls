package objects  {
	
	// Import project stuff
	import components.gbPhysicsComponent;
	import components.gbGraphicsComponent;
	
	public class Projectile extends GameObject 
	{

		public static var COLORS:Array = new Array("blue", "green", "red");
		public static var DEFAULT_MASS:Number = 1.0;
		public static var ROTATION_SPEED:Number = 0.10;
		
		public var mass:Number;
		
		public var color:String;
		
		public function Projectile(cx:Number=0, cy:Number=0, dx:Number=0, dy:Number=0, nColor:String="blue") 
		{
			super(null, new gbPhysicsComponent(), new gbGraphicsComponent());
			
			mass = DEFAULT_MASS;
			
			color = nColor;

			x = cx - width / 2;
			y = cy - height / 2;
		}
		
		
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
		}
	}
	
}
