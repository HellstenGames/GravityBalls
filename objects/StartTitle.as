package objects {
	
	// Import project stuff
	import objects.Entity;
	import starling.display.Image;
	
	public class StartTitle extends Entity {

		public static var MAX_SCALE:Number = 1.1;
		public static var MIN_SCALE:Number = 1.0;
		public static var SCALE_SPEED:Number = 0.001;
		
		private var _scaleUpOrDown:Boolean;
		
		public function StartTitle() 
		{
			super();
			addChild(new Image(AssetResources.startTitleTexture));
			_scaleUpOrDown = true;
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			if (scaleX >= MAX_SCALE)
			{
				_scaleUpOrDown = false;
			}
			else if (scaleX <= MIN_SCALE)
			{
				_scaleUpOrDown = true;
			}

			scaleX = scaleY += _scaleUpOrDown ? SCALE_SPEED : -SCALE_SPEED;
			cx = origCX;
			cy = origCY;
			
		}
	}
	
}
