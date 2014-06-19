package objects {
	
	
	// Import starling stuff
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	// Import flash stuff
	import flash.geom.Point;
	
	public class Player extends Projectile {

		public static var TOUCH_SCALE_AMOUNT:Number = 2.0;
		public static var SHOOT_RATIO:Number = 3.0;

		private var _began:Point;

		public var released:Boolean;
		public var died:Boolean;
		
		public function Player(cx:Number=0, cy:Number=0, color:String="blue") 
		{
			super(color);
			x = cx - width / 2;
			y = cy - width / 2;
			released = false;
			addEventListener(TouchEvent.TOUCH, onTouch);
		}

		private function onTouch(event:TouchEvent):void
		{
			if (!released)
			{
				// Get touch beginning and ending
				var touchBagan:Touch = event.getTouch(this, TouchPhase.BEGAN);
				var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
				var touchMoved:Touch = event.getTouch(this, TouchPhase.MOVED);
				
				// Scale player to make it more visible
				var currentCX:Number = cx;
				var currentCY:Number = cy;
				scaleX = scaleY = touchBagan || touchMoved ? TOUCH_SCALE_AMOUNT : 1;
				x = currentCX - width / 2;
				y = currentCY - height / 2;
				
				if (touchBagan)
				{
					_began = touchBagan.getLocation(this);
				}
				
				if (touchEnded)
				{
					var currentPos:Point = touchEnded.getLocation(this);
					dx = (_began.x - currentPos.x) * SHOOT_RATIO;
					dy = (_began.y - currentPos.y) * SHOOT_RATIO;
					released = true;
				}
			
			}
		}
		
	}
	
}
