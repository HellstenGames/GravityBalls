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
	
	public class BackButton extends Entity {

		private var m_curScene:*, m_backScene:*;
		private var m_sprite:Sprite;
		private var m_delayCall:DelayedCall;
		
		public function BackButton(cScene:*, bScene:*) 
		{
			/* Set scenes */
			m_curScene = cScene;
			m_backScene = bScene;
			
			/* Set sprite */
			m_sprite = new Sprite();
			m_sprite.addChild(new Image(AssetResources.buttons["back"]));
			addChild(m_sprite);
			
			/* Create and add touch listener */
			addEventListener(TouchEvent.TOUCH, OnTouchEvent);
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);		
		}		
		
		private function OnTouchEvent(event:TouchEvent):void
		{
			
			var touchEnded:Touch = event.getTouch(this, TouchPhase.ENDED);
			
			if (touchEnded) 
			{
				var endPos:Point = touchEnded.getLocation(this);
				if (Physics.RectCollision(endPos.x, endPos.y, endPos.x, endPos.y, 0, 0, width, height))
				{
					m_delayCall = new DelayedCall(TouchCallBack, Constants.k_DelayPeroid);
					m_delayCall.repeatCount = 1;
					Starling.juggler.add(m_delayCall);	
				}
			}
			
		}
		
		private function TouchCallBack():void 
		{
			/* Go back to last scene */
			m_curScene.nextScene = m_backScene;
			m_curScene.destroy(); 
		}
			
		
	}
	
}
