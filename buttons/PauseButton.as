package buttons {
	
	// Import project stuff
	import buttons.MenuButton;
	import scenes.Scene;
	import scenes.PlayScene;
	import objects.Entity;
	
	// Import starling stuff
	import starling.display.Image;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.display.Sprite;
	import starling.utils.deg2rad;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	
	// Import flash stuff
	import flash.geom.Point;
	
	public class PauseButton extends Entity {

		public static var DELAY_PERIOD:Number = 0.25;
		
		protected var _scene:*;
		protected var _backSprite:Sprite;
		protected var _delayedCall:DelayedCall;
		
		public function PauseButton(scene:*)  
		{
			_scene = scene;
				
			// Create back sprite
			_backSprite = new Sprite();
			addChild(_backSprite);
			_backSprite.addChild(new Image(AssetResources.buttons["pause"]));

			addEventListener(TouchEvent.TOUCH, onTouch);
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);			
		}		

		private function onTouch(event:TouchEvent):void
		{
			var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);

			// If touched ended trigger call back
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
			if (_scene.paused)
			{
				_scene.resume();
			}
			else
			{
				_scene.pause();
			}
		}
				
		
	}
	
}
