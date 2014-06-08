package objects  {
	
	// Import project stuff
	import scenes.Scene;
	
	// Import starling stuff
	import starling.core.Starling;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.events.Touch;
	import starling.animation.DelayedCall;
	
	// Import flash stuff
	import flash.media.Sound;
	import flash.geom.Point;

	public class MenuButton extends GameEntity {

		public static var TOUCH_SCALE_AMOUNT:Number = 1.25;
		public static var DELAY_PERIOD:Number = 0.25;
		
		// Field Variables
		protected var _scene:Scene;
		protected var _cx:Number, _cy:Number;
		protected var _delayedCall:DelayedCall;
		protected var _touchCallbackSound:Sound;
		
		public function MenuButton(scene:Scene, cx:Number, cy:Number) {
			super();
			
			_scene = scene;
			_cx = cx;
			_cy = cy;
			
			// Default sound effect
			_touchCallbackSound = Game.INSTANCE.blackHoleCollisionSound;
			
			addEventListener(TouchEvent.TOUCH, onTouch); 
		}

		protected function onTouch(event:TouchEvent):void
		{
			// Scale button if touched
			var touchBagan:Touch = event.getTouch(this, TouchPhase.BEGAN);
			var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
			var touchMoved:Touch = event.getTouch(this, TouchPhase.MOVED);
			scaleX = scaleY = touchBagan || touchMoved ? TOUCH_SCALE_AMOUNT : 1;
			
			x = _cx - width / 2;
			y = _cy - height / 2;
			
			// If touched trigger call back
			if (touchEnded) 
			{
				// Make sure button "looks" like its being pressed
				var endPos:Point = touchEnded.getLocation(this);
				if (endPos.x >= 0 && endPos.y >= 0 && endPos.x <= this.width && endPos.y <= this.height) 
				{
					
					_delayedCall = new DelayedCall(touchCallBack, MenuButton.DELAY_PERIOD);
					_delayedCall.repeatCount = 1;
					Starling.juggler.add(_delayedCall);	
					
					_touchCallbackSound.play();					
				}
			}
			
		}
		
		protected function touchCallBack():void {
			_scene.destroy();
		}
		
		// ========================================================================================================================================================================== 
		// Properties
		// ========================================================================================================================================================================== 
		public function set cx(value:Number):void {
			_cx = value;
			x = _cx - width / 2;		
		}
		public function set cy(value:Number):void {
			_cy = value;
			y = _cy - height / 2;	
		}
		
		public function get cx():Number {
			return _cx;

		}
		
		public function get cy():Number {
			return _cy;
		}
		
	}
	
}
