package components {
	
	// Import starling stuff
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.display.DisplayObject;
	
	// Import project stuff
	import objects.Entity;
	
	// Import flash stuff
	import flash.geom.Point;
	
	public class InputComponent extends Component {
				
		public static var MAX_TOUCHES:uint = 10;
		
		public var isTouched:Boolean, isStationary:Boolean, isMoved:Boolean, isHovered:Boolean, isEnded:Boolean;
		public var previousPos:Point, currentPos:Point;
		public var touches:Array;
		public var touchCount:int;
		
		public function InputComponent() 
		{
			// Set up touches array
			touches = [];
			for (var i:int = MAX_TOUCHES; i >= 0; --i) 
			{
				var touchPoints:Array = [];
				touchPoints.push(new Point(0, 0));
				touchPoints.push(new Point(0, 0));
				touches.push(touchPoints);
			}
		}

		override public function init(entity:*):void
		{
			entity.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override public function changed(entity:*):void
		{			
		}
		
		override public function update(entity:*):void
		{
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var entity:DisplayObject = event.currentTarget as Entity;
			
			// Grab Touch Event Flags
			var touched:Touch = event.getTouch(entity, TouchPhase.BEGAN);
			var stationary:Touch = event.getTouch(entity, TouchPhase.STATIONARY);
			var moved:Touch = event.getTouch(entity, TouchPhase.MOVED);
			var hovered:Touch = event.getTouch(entity, TouchPhase.HOVER);
			var ended:Touch = event.getTouch(entity, TouchPhase.ENDED);
			
			// Set touch event flags
			isTouched = touched ? true : false;
			isStationary = stationary ? true : false;
			isMoved = moved ? true : false;
			isHovered = hovered ? true : false;
			isEnded = ended ? true : false;
			
			// Get multiple touches
			var mTouches:Vector.<Touch> = event.getTouches(entity, TouchPhase.MOVED);
			touchCount = mTouches.length - 1;
			for (var i:int = touchCount; i >= 0; --i)
			{
				var touch:Touch = mTouches[0];
				touches[i][0] = touch.getLocation(entity);
				touches[i][1] = touch.getPreviousLocation(entity);
			}
			
		}
		
	}
	
}
