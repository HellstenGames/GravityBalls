package buttons  {
	
	// Import project stuff
	import buttons.MenuButton;
	import scenes.Scene;
	import objects.Entity;
	
	// Import starling stuff
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	
	// Import flash stuff
	import flash.geom.Point;
	import flash.desktop.NativeApplication;
	
	public class ExitButton extends Entity {

		public static var TOUCH_SCALE_AMOUNT:Number = 1.25;
		public static var DELAY_PERIOD:Number = 0.25;
		public static var BACK_ARROW_SCALE:Number = 0.6;
		public static var X_OFFSET:Number = 3;
		public static var Y_OFFSET:Number = 2;
		
		protected var _scene:Scene;
		protected var _backSprite:Sprite;
		protected var _backArrowSprite:Sprite;
		protected var _delayedCall:DelayedCall;
		
		public function ExitButton(scene:Scene) 
		{
			_scene = scene;
			
			_backSprite = new Sprite();
			_backSprite.addChild(new Image(AssetResources.backBallTexture));
			addChild(_backSprite);
			
			// Create back arrow (using play arrow but flipped)
			_backArrowSprite = new Sprite();
			_backArrowSprite.addChild(new Image(AssetResources.playArrowTexture));
			_backArrowSprite.scaleX = _backArrowSprite.scaleY *= BACK_ARROW_SCALE;
			_backArrowSprite.scaleX = -_backArrowSprite.scaleX;
			_backArrowSprite.x = _backSprite.width / 2 + X_OFFSET + _backArrowSprite.width / 4;
			_backArrowSprite.y = _backSprite.height / 2 - _backArrowSprite.height / 2 + Y_OFFSET;
			addChild(_backArrowSprite);
			
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
			//NativeApplication.nativeApplication.exit();
		}
			
		
	}
	
}
