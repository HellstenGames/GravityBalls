package buttons {
	
	// Import starling stuff
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	
	// Import project stuff
	import objects.Entity;
	import scenes.Scene;

	// Import starling stuff
	import starling.utils.deg2rad;
	import starling.display.Sprite;
	
	// Import flash stuff
	import flash.geom.Point;

	
	public class MenuButton extends Entity {

		public static var TOUCH_SCALE_AMOUNT:Number = 1.25;
		public static var DELAY_PERIOD:Number = 0.25;
		public static var ROTATION_SPEED:Number = 1;
		
		protected var _scene:Scene;
		protected var _delayedCall:DelayedCall;
		protected var _ballSprite:Sprite;
		
		public function MenuButton(scene:Scene)
		{
			super();
			_scene = scene;
			addEventListener(TouchEvent.TOUCH, onTouch);
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);	
			
			// Rotate ball sprite
			_ballSprite.rotation += deg2rad(ROTATION_SPEED);

		}		
		
		private function onTouch(event:TouchEvent):void
		{
			// Scale button if touched
			var touchBagan:Touch = event.getTouch(this, TouchPhase.BEGAN);
			var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
			var touchMoved:Touch = event.getTouch(this, TouchPhase.MOVED);
			
			var currentCX:Number = cx;
			var currentCY:Number = cy;
			
			scaleX = scaleY = touchBagan || touchMoved ? TOUCH_SCALE_AMOUNT : 1;

			x = currentCX - width / 2;
			y = currentCY - height / 2;

			// If touched trigger call back
			if (touchEnded) 
			{
				// Make sure button "looks" like its being pressed
				var endPos:Point = touchEnded.getLocation(this);
				if (endPos.x >= 0 && endPos.y >= 0 && endPos.x <= width && endPos.y <= height) 
				{

					_delayedCall = new DelayedCall(_touchCallBack, DELAY_PERIOD);
					_delayedCall.repeatCount = 1;
					Starling.juggler.add(_delayedCall);	
			
				}
			}
		}
		
		protected function _touchCallBack():void {
			_scene.destroy();
		}
		
	}

		
}
