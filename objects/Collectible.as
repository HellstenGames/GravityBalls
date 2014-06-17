package objects {
	import starling.display.Image;
	
	public class Collectible extends Entity {
	
		public function Collectible() 
		{
			super();
			
			addChild(new Image(AssetResources.redProjectileTexture));
			
		}

	}
	
}
