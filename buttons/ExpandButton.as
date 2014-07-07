package buttons {
	import starling.display.Image;
	import objects.Entity;
	public class ExpandButton extends Entity {

		public function ExpandButton() 
		{
			super();
			addChild(new Image(AssetResources.ebTexture));
		}

	}
	
}
