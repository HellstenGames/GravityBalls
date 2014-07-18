package objects {

	// Import starling stuff
	import starling.display.Sprite;
	
	// Import rectangle for backboard
	import graphics.Rectangle;
	
	public class OptionRollOut extends Entity {

		public static var BACKBOARD_WIDTH:int = 35;
		public static var BACKBOARD_HEIGHT:int = 100;
		
		private var _backboard:Sprite;
		
		public function OptionRollOut() 
		{
			super();
			_backboard = new Sprite();
			_backboard.addChild(new Rectangle(0, 0, BACKBOARD_WIDTH, BACKBOARD_HEIGHT));
			addChild(_backboard);
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}

	}
	
}
