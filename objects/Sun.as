package objects {
	import starling.display.Image;
	
	public class Sun extends Entity {
	
		public var mass:Number;
		
		public function Sun() 
		{
			super();
			
			mass = Constants.kSunMass;
			
			addChild(new Image(AssetResources.sunTexture));
			
		}

	}
	
}
