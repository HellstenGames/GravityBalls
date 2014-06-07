package buttons  {
	
	// Import project stuff
	import objects.GameEntity;
	
	// Import starling stuff
	import starling.core.Starling;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.events.Touch;
	import starling.animation.DelayedCall;
	
	// Import flash stuff
	import flash.geom.Point;

	public class Button extends GameEntity {

		public static var DELAY_PERIOD:Number = 0.01;
		
		// Field Variables
		protected var _cx:Number, _cy:Number;
		protected var _delayedCall:DelayedCall;
		
		public function Button(cx:Number, cy:Number) {
			super();

			_cx = cx;
			_cy = cy;

			addEventListener(TouchEvent.TOUCH, onTouch); 
		}

		protected function onTouch(event:TouchEvent):void
		{
	
			var touchBagan:Touch = event.getTouch(this, TouchPhase.BEGAN);
			var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
			var touchMoved:Touch = event.getTouch(this, TouchPhase.MOVED);

			x = _cx - width / 2;
			y = _cy - height / 2;
			
			// If touched trigger call back
			if (touchEnded) 
			{
				// Make sure button "looks" like its being pressed
				var endPos:Point = touchEnded.getLocation(this);
				if (endPos.x >= 0 && endPos.y >= 0 && endPos.x <= this.width && endPos.y <= this.height) 
				{
					
					_delayedCall = new DelayedCall(touchCallBack, Button.DELAY_PERIOD);
					_delayedCall.repeatCount = 1;
					Starling.juggler.add(_delayedCall);				
				}
			}
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
		protected function touchCallBack():void 
		{

		}
		
		public function adjustCentered():void {
			x = _cx - width / 2;
			y = _cy - height / 2;
		}
		
		// ========================================================================================================================================================================== 
		// Properties
		// ========================================================================================================================================================================== 
		public function set cx(value:Number):void 
		{
			_cx = value;
			x = _cx - width / 2;		
		}
		public function set cy(value:Number):void 
		{
			_cy = value;
			y = _cy - height / 2;	
		}
		
		public function get cx():Number 
		{
			return _cx;
		}
		
		public function get cy():Number 
		{
			return _cy;
		}
		
	}
	
}
