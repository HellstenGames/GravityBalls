package objects {

	// Import starling stuff
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.display.DisplayObject;
	import starling.utils.Color;
	
	// Import flash stuff
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Player extends Projectile {

		public static var TOUCH_SCALE_AMOUNT:Number = 2.0;
		public static var SHOOT_RATIO:Number = 3.0;
		public static var PADDING_RATIO:Number = 2.0;
		public static var SHOOT_SPEED:Number = 150;
		
		public var began:Point, currentPos:Point;
		private var _padding:Number;
		
		public var released:Boolean;
		public var died:Boolean;
		public var beingTouched:Boolean;
		
		// Cursor positions
		
		public function Player(cx:Number=0, cy:Number=0, color:String="blue") 
		{
			super(color);
			x = cx - width / 2;
			y = cy - width / 2;
			released = false;
			addEventListener(TouchEvent.TOUCH, onTouch);
			padding = width * PADDING_RATIO;
		}

		public function getColorCode():uint
		{
			return COLOR_CODES[COLORS.indexOf(color)];
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
					began = touchBagan.getLocation(this);
					currentPos = began;
					beingTouched = true;
				}
								
				if (touchEnded)
				{					
					currentPos = touchEnded.getLocation(this);
					dx = (began.x - currentPos.x) * SHOOT_RATIO;
					dy = (began.y - currentPos.y) * SHOOT_RATIO;
					/*
					// Make it fixed for now
					var angle:Number = Math.atan2(began.y - currentPos.y, began.x - currentPos.x);
					trace(angle);
					*/
					dx = dx;
					dy = dy;

					released = true;
					beingTouched = false;
				}
				
				if (touchMoved)
				{
					currentPos = touchMoved.getLocation(this);
				}
			
			}
			
		}
	
			public function get padding():Number { return _padding; }
			public function set padding(value:Number):void { _padding = value; }
		
			public override function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject 
			{
				// on a touch test, invisible or untouchable objects cause the test to fail
				if (forTouch && (!visible || !touchable)) return null;
				 
				var theBounds:Rectangle = getBounds(this);
				theBounds.inflate(_padding, _padding);
				 
				if (theBounds.containsPoint(localPoint)) return this;
				return null;
			}			
			
	}
	
}
