package objects  {
	
	import starling.display.Image;
	
	public class Trail extends Entity {
		
		public static var DISAPPEAR_SPEED:Number = 0.0075;
		
		public function Trail() 
		{
			super();
			addChild(new Image(AssetResources.trailTexture));
		}

		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
	}
	
}
