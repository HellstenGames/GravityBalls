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
	
	public class PlayButton extends Entity {

		public static var TOUCH_SCALE_AMOUNT:Number = 1.25;
		public static var DELAY_PERIOD:Number = 0.25;
		public static var X_OFFSET:Number = 3;
		public static var Y_OFFSET:Number = 2;
		
		protected var _scene:Scene;
		protected var _backSprite:Sprite, _playArrowSprite:Sprite;
		protected var _delayedCall:DelayedCall;
		
		public function PlayButton(scene:Scene)  
		{
			_scene = scene;
				
			// Create back sprite
			_backSprite = new Sprite();
			addChild(_backSprite);
			_backSprite.addChild(new Image(AssetResources.playBallTexture));
			
			// Create play arrow
			_playArrowSprite = new Sprite();
			_playArrowSprite.addChild(new Image(AssetResources.playArrowTexture));
			_playArrowSprite.x = _backSprite.width / 2 - _playArrowSprite.width / 2 + X_OFFSET;
			_playArrowSprite.y = _backSprite.height / 2 - _playArrowSprite.height / 2 + Y_OFFSET;
			addChild(_playArrowSprite);
	
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
			
			scaleX = scaleY = touchBagan || touchHovered ? TOUCH_SCALE_AMOUNT : 1;

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
			_scene.destroy();
		}
				
		
	}
	
}
