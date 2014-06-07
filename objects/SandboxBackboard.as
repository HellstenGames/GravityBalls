package objects {
	
	// Import project stuff
	import graphics.Line;
	import graphics.Rectangle;
	
	// Import starling stuff
	import starling.display.Sprite;
	import starling.utils.Color;
	import starling.core.Starling;
	
	public class SandboxBackboard extends Sprite {

		public static const BACKBOARD_WIDTH:uint = 75;
		public static const BLACKBOARD_COLOR:uint = 0x000033;
		
		private var _backboard:Sprite;
		private var _line:Sprite;
		
		public function SandboxBackboard(xPos:Number, yPos:Number) {
			super();
			_backboard = new Rectangle(0, 0, BACKBOARD_WIDTH, Starling.current.stage.stageHeight, BLACKBOARD_COLOR);
			addChild(_backboard);
			_line = new Line(BACKBOARD_WIDTH, 0, BACKBOARD_WIDTH, Starling.current.stage.stageHeight, Color.AQUA, 0.25);
			addChild(_line);
			
			x = xPos;
			y = yPos;
		}

	}
	
}
