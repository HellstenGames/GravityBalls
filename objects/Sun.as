package objects {
	import starling.display.Image;
	
	public class Sun extends Entity {
	
		public var mass:Number;
		
		public function Sun() 
		{
			super();
			
			mass = 5.0*10e+3;
			
			addChild(new Image(AssetResources.sunTexture));
			
		}

	}
	
}
