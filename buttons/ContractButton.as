package buttons {
	import starling.display.Image;
	import objects.Entity;
	public class ContractButton extends Entity {

		public function ContractButton() 
		{
			super();
			addChild(new Image(AssetResources.cbTexture));
		}

	}
	
}
