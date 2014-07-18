package objects {
	
	// Import project stuff
	import objects.Entity;
	import starling.display.Image;
	
	public class MenuBackground extends Entity {

		public function MenuBackground() 
		{
			super();
			
			addChild(new Image(AssetResources.menuScreenTexture));
			
		}

	}
	
}
