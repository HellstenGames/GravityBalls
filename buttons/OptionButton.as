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
	import starling.utils.deg2rad;
	
	// Import flash stuff
	import flash.geom.Point;
	
	// Import object stuff
	import objects.OptionRollOut;
	
	public class OptionButton extends Entity {

		public static var ROTATION_SPEED:Number = 8;
		public static var TOUCH_SCALE_AMOUNT:Number = 1.25;
		public static var DELAY_PERIOD:Number = 0.1;
		public static var BACK_ARROW_SCALE:Number = 0.6;
		public static var X_OFFSET:Number = 3;
		public static var Y_OFFSET:Number = 2;
		public static var ROLL_OUT_SPEED:Number = 5.5;
		public static var ROLL_OUT_SCALE_SPEED:Number = 0.05;
		public static var ROLL_OUT_ALPHA:Number = 0.4;
		
		protected var _optionRollOut:OptionRollOut;
		protected var _scene:Scene;
		protected var _backSprite:Sprite;
		protected var _backArrowSprite:Sprite;
		protected var _delayedCall:DelayedCall;
		
		public var _rollUpDown:Boolean;
		
		public function OptionButton(optionRollOut:OptionRollOut) 
		{
			_optionRollOut = optionRollOut;
			_optionRollOut.alpha = ROLL_OUT_ALPHA;
			
			_rollUpDown = false;
			
			_backSprite = new Sprite();
			_backSprite.addChild(new Image(AssetResources.optionBallTexture));
			addChild(_backSprite);
			_backSprite.alignPivot();
			_backSprite.x += _backSprite.width / 2;
			_backSprite.y += _backSprite.height / 2;
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			if (_rollUpDown)
			{
				
				if (_optionRollOut.scaleY < 1.0)
				{
					_optionRollOut.scaleY += ROLL_OUT_SCALE_SPEED;
					_optionRollOut.y -= ROLL_OUT_SPEED;
					_backSprite.rotation += deg2rad(ROTATION_SPEED);
				}
				
			}
			else
			{
				
				if (_optionRollOut.scaleY > 0)
				{
					_optionRollOut.scaleY -= ROLL_OUT_SCALE_SPEED;
					_optionRollOut.y += ROLL_OUT_SPEED;
					_backSprite.rotation -= deg2rad(ROTATION_SPEED);
				}
				
			}
			
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
		
		protected function _touchCallBack():void 
		{
			_rollUpDown = _rollUpDown ? false : true;
		}
			
		
	}
	
}
