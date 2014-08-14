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
		
		private var m_scene:*;
		private var m_sprite:Sprite, m_sprite_grey:Sprite;
		private var m_delayCall:DelayedCall;
		
		public function PauseButton(scene:*)  
		{
			m_scene = scene;
				
			/* Create sprites */
			m_sprite = new Sprite();
			addChild(m_sprite);
			m_sprite.addChild(new Image(AssetResources.buttons["pause"]));
			m_sprite.visible = true;
			
			m_sprite_grey = new Sprite();
			addChild(m_sprite_grey);
			m_sprite_grey.addChild(new Image(AssetResources.buttons["pause_grey"]));
			m_sprite_grey.visible = false;
			
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
			
			if (!m_scene.paused)
			{
				m_scene.pause();
				Toggle();
			}
			
		}
				
		public function Toggle():void
		{
			m_sprite_grey.visible = m_sprite_grey.visible ? false : true;
			m_sprite.visible = m_sprite.visible ? false : true;
		}
		
	}
	
}
