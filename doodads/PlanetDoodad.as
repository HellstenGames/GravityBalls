package doodads {
	
	// Import project stuff
	import objects.Entity;
	import starling.display.Image;
	
	public class PlanetDoodad extends Entity {

		public static var ROTATION_SPEED:Number = 0.001;
		
		private var _planetImage:Image;
		
		public function PlanetDoodad() 
		{
			super();
			_planetImage = new Image(AssetResources.planetDoodadTexture);
			addChild(_planetImage);
			_planetImage.alignPivot();
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			rotation += ROTATION_SPEED;
		}
		
	}
	
}
