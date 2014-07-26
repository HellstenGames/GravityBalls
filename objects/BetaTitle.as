package objects {
	
	// Import project stuff
	import objects.Entity;
	import starling.display.Image;
	
	public class BetaTitle extends Entity  {
		
		public function BetaTitle() 
		{
			super();
			addChild(new Image(AssetResources.betaTitleTexture));
		}

		
	}
	
}
