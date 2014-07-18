package screens {
	
	import objects.Entity;
	import starling.display.Image;
	
	public class LevelSelectScreen extends Entity {

		public function LevelSelectScreen() 
		{
			addChild(new Image(AssetResources.menuScreenTexture));
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
	}
	
}
