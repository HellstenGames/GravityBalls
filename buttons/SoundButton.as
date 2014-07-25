﻿package buttons {
	
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
	import flash.media.SoundTransform;
	
	public class SoundButton extends Entity {

		public static var DELAY_PERIOD:Number = 0.1;
		public static var VOLUME_CHANGE_SPEED:Number = 0.025;
		
		protected var _delayedCall:DelayedCall;
		protected var _scene:Scene;
		
		protected var _trans:SoundTransform; 
		protected var _fadeOutSound:Boolean, _fadeInSound:Boolean;
		
		public function SoundButton(scene:Scene) 
		{
			_scene = scene;
			_fadeOutSound = false;
			_fadeInSound = false;
			addChild(new Image(AssetResources.soundButtonTexture));	
			addEventListener(TouchEvent.TOUCH, onTouch);
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			if (_fadeOutSound)
			{
				_trans.volume -= VOLUME_CHANGE_SPEED;
				_scene.themeChannel.soundTransform = _trans;
				if (_trans.volume <= 0.0)
				{
					_trans.volume = 0.0;
					_fadeOutSound = false;
				}
			}
			if (_fadeInSound)
			{
				_trans.volume += VOLUME_CHANGE_SPEED;
				_scene.themeChannel.soundTransform = _trans;
				if (_trans.volume >= 1.0)
				{
					_trans.volume = 1.0;
					_fadeInSound = false;
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
			_trans = _scene.themeChannel.soundTransform;
			if (_fadeInSound || _trans.volume == 1.0)
			{
				_fadeInSound = false;
				_fadeOutSound = true;
			}
			else if (_fadeOutSound || _trans.volume == 0.0)
			{
				_fadeInSound = true;
				_fadeOutSound = false;
			} else {
				_fadeOutSound = true;
			}
		}
			
		
	}
	
}
