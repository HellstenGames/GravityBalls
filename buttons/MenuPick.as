package buttons {
	import starling.display.Image;
	import objects.Entity;
	public class MenuPick extends Entity {

		public static var ROTATION_SPEED:Number = 0.05;

		public function MenuPick() 
		{
			super();
			addChild(new Image(AssetResources.menuPickTexture));
			alignPivot();
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			rotation += ROTATION_SPEED;
		}
		

	}
	
}
