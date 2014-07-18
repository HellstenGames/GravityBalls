package buttons {
	
	// Import entities
	import objects.Entity;
	
	// Import starling stuff
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	
	// Import flash stuff
	import flash.geom.Point;
	import scenes.Scene;
	
	public class LevelSelection extends Entity {

		public static var ROTATION_SPEED:Number = 0.025;
		public static var DELAY_PERIOD:Number = 0.1;
		
		private var _number:int;
		
		protected var _backgroundImage:Image;
		protected var _textField:TextField;
		protected var _delayedCall:DelayedCall;
		protected var _scene:Scene;
		
		public function LevelSelection(scene:Scene, number:int) 
		{
			super();
			_scene = scene;
			_backgroundImage = new Image(AssetResources.menuPickTexture)
			addChild(_backgroundImage);
			_backgroundImage.alignPivot();
			_number = number;

			// Create text field for number
			_textField = new TextField(_backgroundImage.width, _backgroundImage.height, _number.toString(), "Arial", 12, Color.WHITE);	
			trace(_textField.textBounds.width, _textField.textBounds.height);
			_textField.x -= _backgroundImage.width / 2 - _textField.textBounds.width / 4;
			_textField.y -= _backgroundImage.height / 2 - _textField.textBounds.height / 4;
			addChild(_textField);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			_backgroundImage.rotation += ROTATION_SPEED;
		}
		
		public function get number():int { return _number; }
		
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
			_scene.destroy();
		}
		
	}
	
}
