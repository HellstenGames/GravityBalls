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
	
	public class FocusButton extends Entity {

		public static var DELAY_PERIOD:Number = 0.1;
		
		protected var _scene:*;
		protected var _delayedCall:DelayedCall;
		
		public var focused:Boolean;
		private var imageOn:Image;
		private var imageOff:Image;
		
		public function FocusButton(scene:*)  
		{
			_scene = scene;
			focused = true;
			
			// Create back sprite
			imageOn = new Image(AssetResources.buttons["focus_on"]);
			imageOn.visible = true;
			imageOff = new Image(AssetResources.buttons["focus_off"])
			imageOff.visible = false;
			addChild(imageOn);
			addChild(imageOff);

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
			
			var currentCX:Number = cx;
			var currentCY:Number = cy;

			x = currentCX - width / 2;
			y = currentCY - height / 2;

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
			focused = focused ? false : true;
			imageOn.visible = focused ? true : false;
			imageOff.visible = focused ? false : true;
		}
				
		
	}
	
}
