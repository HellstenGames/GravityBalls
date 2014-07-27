package buttons {
	
	import objects.Entity;

	// import starling stuff
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	
	// Import flash stuff
	import flash.geom.Point;
	
	import scenes.Scene;
	import scenes.CreditScene;
	
	import utils.SceneLoader;
	
	public class CreditButton extends Entity {

		public static var DELAY_PERIOD:Number = 0.1;
		
		protected var _delayedCall:DelayedCall;
		protected var _scene:Scene;
		
		public function CreditButton(scene:Scene) 
		{
			_scene = scene;
			addChild(new Image(AssetResources.creditButtonTexture));	
			addEventListener(TouchEvent.TOUCH, onTouch);
		}

		private function onTouch(event:TouchEvent):void
		{
			// Scale button if touched
			var touchBagan:Touch = event.getTouch(this, TouchPhase.BEGAN);
			var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
			var touchMoved:Touch = event.getTouch(this, TouchPhase.MOVED);
			var touchHovered:Touch = event.getTouch(this, TouchPhase.HOVER);

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
		
		protected function _touchCallBack():void 
		{
			_scene.nextScene = AssetResources.creditScene;
			_scene.destroy();
		}
			
		
	}
	
}
