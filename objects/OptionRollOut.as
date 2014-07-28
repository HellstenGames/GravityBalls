package objects {

	// Import starling stuff
	import starling.display.Sprite;
	import starling.display.DisplayObject;
	
	// Import rectangle for backboard
	import graphics.Rectangle;
	
	// Buttons
	import buttons.SoundButton;
	import buttons.CreditButton;
	import buttons.BackgroundButton;
	
	import scenes.Scene;
	import fl.motion.easing.Back;
	
	
	
	public class OptionRollOut extends Entity {

		public static var BACKBOARD_WIDTH:int = 35;
		public static var BACKBOARD_HEIGHT:int = 1;
		public static var BUTTONS_OFFSET:int = 20;
		
		public var backboard:Sprite;
		public var buttonsList:Array;
		private var soundButton:SoundButton, creditButton:CreditButton, backgroundButton:BackgroundButton;
		
		public function OptionRollOut(scene:Scene) 
		{
			super();
			
			visible = false;
			
			backboard = new Sprite();
			backboard.addChild(new Rectangle(0, 0, BACKBOARD_WIDTH, BACKBOARD_HEIGHT));
			addChild(backboard);
			
			buttonsList = [];
			
			// Create Credit button
			creditButton = new CreditButton(scene);
			creditButton.cx = backboard.width / 2;
			creditButton.cy = BUTTONS_OFFSET;			
			_addButton(creditButton);
			
			// Create sound button
			soundButton = new SoundButton(scene);
			soundButton.cx = backboard.width / 2;
			soundButton.cy = BUTTONS_OFFSET;			
			_addButton(soundButton);
			
			// Create background button
			backgroundButton = new BackgroundButton(scene);
			backgroundButton.cx = backboard.width / 2;
			backgroundButton.cy = BUTTONS_OFFSET;
			_addButton(backgroundButton);
			
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}

		private function _addButton(button:Entity):void
		{
			buttonsList.push(button);
			addChild(button);
			addEntity(button);
		}
		
	}
	
}
