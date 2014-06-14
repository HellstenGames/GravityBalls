package components {

	// Import starling stuff
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.events.Touch;
	import starling.core.Starling;
	import starling.animation.DelayedCall;
	import starling.display.DisplayObject;
	
	// Import project stuff
	import objects.MenuButton;
	import objects.PlayButton;
	import objects.ExitButton;
	import objects.SandboxButton;
	import scenes.*;
	import objects.Projectile;
	
	// Import flash stuff
	import flash.geom.Point;
	import graphics.Line;
	
	
	public class gbInputComponent extends InputComponent {

		public static var TOUCH_SCALE_AMOUNT_MENU_BUTTON:Number = 1.25;
		public static var TOUCH_MENU_BUTTON_DELAY = 0.25;
		
		public function gbInputComponent() 
		{
			super();
		}
		
		override public function init(gameObject:*):void
		{
			super.init(gameObject);
			if (gameObject is PlayButton || gameObject is SandboxButton || gameObject is ExitButton)
			{
				gameObject.addEventListener(TouchEvent.TOUCH, onMenuButtonTouch); 
			} 		
		}
		
		override public function update(gameObject:*):void
		{
		}

		private function onMenuButtonTouch(event:TouchEvent):void
		{
			var menuButton:MenuButton = event.currentTarget as MenuButton;
		
			// Scale button if touched
			var touchBagan:Touch = event.getTouch(menuButton, TouchPhase.BEGAN);
			var touchEnded:Touch = event.getTouch(menuButton, TouchPhase.ENDED);
			var touchMoved:Touch = event.getTouch(menuButton, TouchPhase.MOVED);
			
			var cx:Number = menuButton.x + menuButton.width / 2;
			var cy:Number = menuButton.y + menuButton.height / 2;
			menuButton.scaleX = menuButton.scaleY = touchBagan || touchMoved ? TOUCH_SCALE_AMOUNT_MENU_BUTTON : 1;

			menuButton.x = cx - menuButton.width / 2;
			menuButton.y = cy - menuButton.height / 2;

			// If touched trigger call back
			if (touchEnded) 
			{
				// Make sure button "looks" like its being pressed
				var endPos:Point = touchEnded.getLocation(menuButton);
				if (endPos.x >= 0 && endPos.y >= 0 && endPos.x <= menuButton.width && endPos.y <= menuButton.height) 
				{
					Game.INSTANCE.scene.nextScene = menuButton.linkedScene;
					AssetResources.blackHoleCollisionSound.play();
					var menuDelay:DelayedCall = new DelayedCall(menuButtonDelay, TOUCH_MENU_BUTTON_DELAY);
					menuDelay.repeatCount = 1;
					Starling.juggler.add(menuDelay);									
				}
			}

		}
		
		private function menuButtonDelay():void
		{
			Game.INSTANCE.scene.destroy();
		}
		
		
		var beginPos:Point = new Point(0, 0), endPos:Point = new Point(0, 0), movingPos:Point = new Point(0, 0);
		var line:Line;
		var col:uint;
		
		private function onBackgroundTouch(event:TouchEvent):void
		{
			var dObj:DisplayObject = event.currentTarget as DisplayObject;
			var touchBegan:Touch = event.getTouch(dObj, TouchPhase.BEGAN);
			var touchEnded:Touch = event.getTouch(dObj, TouchPhase.ENDED);
			var touchMoving:Touch = event.getTouch(dObj, TouchPhase.MOVED);
			var touchHover:Touch = event.getTouch(dObj, TouchPhase.HOVER);

			if (touchBegan)
			{
				beginPos = touchBegan.getLocation(dObj);
			}

			if (touchEnded) 
			{
				endPos = touchEnded.getLocation(dObj);
				col = Math.floor(Math.random() * Projectile.COLORS.length);
				projectileManager.addProjectile(beginPos.x, beginPos.y, (beginPos.x-endPos.x)*3, (beginPos.y-endPos.y)*2, Projectile.COLORS[col]);
				removeChild(line);
			}

			if (touchMoving)
			{
				removeChild(line);
				movingPos = touchMoving.getLocation(dObj);
				line = new Line(beginPos.x, beginPos.y, movingPos.x, movingPos.y, 
					((Projectile.COLORS[col] == "blue") ? Color.BLUE : ((Projectile.COLORS[col] == "red") ? Color.RED : Color.GREEN)));
				addChild(line);				
			}

			if (touchHover)
			{
				var hoverPos:Point = touchHover.getLocation(this);
			}
		}
		
	}
	
}
