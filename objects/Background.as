package objects {
	
	// Import project stuff
	import objects.Entity;
	import starling.display.Image;
	
	public class Background extends Entity {

		public function Background() 
		{
			super();
			
			addChild(new Image(AssetResources.menuScreenTexture));
			
		}

	}
	
}
