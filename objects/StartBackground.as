package objects {
	
	// Import project stuff
	import objects.Entity;
	import starling.display.Image;
	
	public class StartBackground extends Entity {

		public function StartBackground() 
		{
			addChild(new Image(AssetResources.menuScreenTexture));
		}

	}
	
}
