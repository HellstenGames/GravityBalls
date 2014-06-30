package objects  {
	
	import starling.display.Image;
	
	public class Arrow extends Entity {
		
		// Arrow Types 
		public static var ARROW_RED:uint = 0;
		public static var ARROW_GREEN:uint = 1;
		public static var ARROW_BLUE:uint = 2;
		
		public var image:Image;
		
		public function Arrow(type:uint=0) 
		{
			super();
			changeImage(type);	
		}

		public function changeImage(type:uint=0):void
		{
			removeChild(image);
			image = new Image(AssetResources.arrowTextures[type]);
			image.alignPivot();
			addChild(image);
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
	}
	
}
