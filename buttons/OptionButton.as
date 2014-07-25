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
	import starling.display.DisplayObject;
	
	public class OptionButton extends Entity {

		public static var ROTATION_SPEED:Number = 8;
		public static var TOUCH_SCALE_AMOUNT:Number = 1.25;
		public static var DELAY_PERIOD:Number = 0.1;
		public static var BACK_ARROW_SCALE:Number = 0.6;
		public static var X_OFFSET:Number = 3;
		public static var Y_OFFSET:Number = 2;
		public static var ROLL_OUT_SPEED:Number = 3;
		public static var ROLL_OUT_SCALE_SPEED:Number = 0.05;
		public static var ROLL_OUT_SCALE_MAX:Number = -1.0;
		public static var ROLL_OUT_SCALE_MIN:Number = 0.0;
		public static var ROLL_OUT_ALPHA:Number = 0.4;
		
		public static var ROLL_OUT_MIN_HEIGHT:Number = 1;
		public static var ROLL_OUT_MAX_HEIGHT:Number = 73;
		
		protected var _optionRollOut:OptionRollOut;
		protected var _scene:Scene;
		protected var _backSprite:Sprite;
		protected var _backArrowSprite:Sprite;
		protected var _delayedCall:DelayedCall;
		
		protected var _rollUp:Boolean, _rollDown:Boolean;
		protected var _isRolledUp:Boolean, _isRolledDown:Boolean;
		
		public function OptionButton(optionRollOut:OptionRollOut) 
		{
			_optionRollOut = optionRollOut;
			_optionRollOut.backboard.alpha = ROLL_OUT_ALPHA;
			
			_rollUp = _rollDown = false 
			
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

			if (_rollUp)
			{
				_doRollUp();
			}
			if (_rollDown)
			{
				_doRollDown();
			}
			
		}		
		
		private function _doRollUp():void
		{
			// Roll Buttons up
			_rollUpButtons();
			if (_optionRollOut.backboard.height < ROLL_OUT_MAX_HEIGHT)
			{
				_optionRollOut.backboard.height += ROLL_OUT_SPEED;
				_optionRollOut.backboard.y -= ROLL_OUT_SPEED;
			}
			else
			{
				_optionRollOut.backboard.scaleY = ROLL_OUT_MAX_HEIGHT;
				_optionRollOut.backboard.y = -ROLL_OUT_MAX_HEIGHT;
				_rollUp = false;
			}	
			_backSprite.rotation += deg2rad(ROTATION_SPEED);
		}
		private function _doRollDown():void
		{
			// Roll Buttons Down
			_rollDownButtons();		
			if (_optionRollOut.backboard.height > ROLL_OUT_MIN_HEIGHT)
			{
				if (_optionRollOut.backboard.height - ROLL_OUT_SPEED < 0) 
				{
					_optionRollOut.backboard.height = 0;  
				}
				else
				{
					_optionRollOut.backboard.height -= ROLL_OUT_SPEED;
				}
				_optionRollOut.backboard.y += ROLL_OUT_SPEED;
			}
			else
			{
				_optionRollOut.backboard.height = ROLL_OUT_MIN_HEIGHT;
				_optionRollOut.backboard.y = 0;
				_rollDown = false;
			}				
			_backSprite.rotation -= deg2rad(ROTATION_SPEED);	
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
			_optionRollOut.visible = true;
			if (_rollUp || _optionRollOut.backboard.height == ROLL_OUT_MAX_HEIGHT)
			{
				_rollDown = true;
				_rollUp = false;
			}
			else if (_rollDown || _optionRollOut.backboard.height == ROLL_OUT_MIN_HEIGHT)
			{
				_rollUp = true;
				_rollDown = false;
			}
			else
			{
				_rollUp = true;
			}
		}
		
		private function _rollUpButtons():void
		{
			var blength:int = _optionRollOut.buttonsList.length;
			var button:Entity, lastButton:Entity;
			var isRollUp:Boolean = false;
			for (var i:int = blength - 1; i >= 0; --i)
			{
				button = _optionRollOut.buttonsList[i];
				
				if (i != blength - 1)
				{
					lastButton = _optionRollOut.buttonsList[i+1];
					if (lastButton.cy + lastButton.height + OptionRollOut.BUTTONS_OFFSET / 4 < button.cy)
					{
						button.cy -= ROLL_OUT_SPEED;
					}
				} 
				else
				{
					button.cy -= ROLL_OUT_SPEED;
				}
			}
			
		}
		private function _rollDownButtons():void
		{
			var blength:int = _optionRollOut.buttonsList.length;
			var button:Entity, lastButton:Entity;
			var isRollDown:Boolean = false;
			for (var i:int = blength - 1; i >= 0; --i)
			{
				button = _optionRollOut.buttonsList[i];
				
				if (button.cy >= OptionRollOut.BUTTONS_OFFSET)
					continue;
		
				/* Roll buttons down */
				if (i != blength - 1)
				{
					lastButton = _optionRollOut.buttonsList[i+1];
					if (lastButton.cy + lastButton.height + OptionRollOut.BUTTONS_OFFSET / 4  > button.cy)
					{
						button.cy += ROLL_OUT_SPEED;
					}
				} 
				else
				{
					button.cy += ROLL_OUT_SPEED;
				}
			}
			
		}
		
	}
	
	
}
