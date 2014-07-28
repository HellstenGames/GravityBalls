package buttons {
	
	import objects.Entity;
	import scenes.Scene;
	
	// import starling stuff
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.animation.DelayedCall;
	import starling.core.Starling;

	// Import flash stuff
	import flash.geom.Point;

	
	public class BackgroundButton extends Entity {

		public static var DELAY_PERIOD:Number = 0.1;
		
		protected var _delayedCall:DelayedCall;
		protected var _scene:Scene;

		protected var _blueBackground:Image, _redBackground:Image;
		protected var _showBackground:Boolean;
		
		public function BackgroundButton(scene:Scene) 
		{
			_showBackground = true;
			_scene = scene;
			_blueBackground = new Image(AssetResources.buttons["blue_background"]);
			addChild(_blueBackground);	
			_redBackground = new Image(AssetResources.buttons["red_background"]);
			_redBackground.visible = false;
			addChild(_redBackground);
			addEventListener(TouchEvent.TOUCH, onTouch);
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			// Scale button if touched
			var touchBagan:Touch = event.getTouch(this, TouchPhase.BEGAN);
			var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
			var touchMoved:Touch = event.getTouch(this, TouchPhase.MOVED);
			var touchHovered:Touch = event.getTouch(this, TouchPhase.HOVER);

			// If touched ended trigger call back
			if (touchEnded && !_delayedCall)
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
		
		protected function _touchCallBack():void 
		{
			_showBackground = _showBackground ? false : true;
			if (_showBackground)
			{
				_blueBackground.visible = true;
				_redBackground.visible = false;
				_scene.backgroundLayer.visible = true;
			}
			else
			{
				_blueBackground.visible = false;
				_redBackground.visible = true;
				_scene.backgroundLayer.visible = false;
			}
			_delayedCall = null;
		}
			
		
	}
	
}
