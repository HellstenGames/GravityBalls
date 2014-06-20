package objects {
	import starling.display.Image;
	
	public class BlackHole extends Entity {
	
		public var mass:Number;
		
		public function BlackHole() 
		{
			super();
			
			mass = 5.0*10e+3;
			
			addChild(new Image(AssetResources.blackHoleTexture));
			
		}

	}
	
}
	