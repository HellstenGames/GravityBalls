package objects {

	// Import starling stuff
	import starling.display.Sprite;
	import starling.display.DisplayObject;
	
	// Import rectangle for backboard
	import graphics.Rectangle;
	
	// Buttons
	import buttons.SoundButton;
	import buttons.CreditButton;
	
	
	public class OptionRollOut extends Entity {

		public static var BACKBOARD_WIDTH:int = 35;
		public static var BACKBOARD_HEIGHT:int = 75;
		public static var BUTTONS_OFFSET:int = 17;
		
		public var backboard:Sprite;
		public var buttonsLayer:Sprite;
		public var soundButton:SoundButton, creditButton:CreditButton;
		
		public function OptionRollOut() 
		{
			super();
			
			backboard = new Sprite();
			backboard.addChild(new Rectangle(0, 0, BACKBOARD_WIDTH, BACKBOARD_HEIGHT));
			backboard.scaleY = 0;
			addChild(backboard);
			
			buttonsLayer = new Sprite();
			addChild(buttonsLayer);
			
			// Create sound button
			soundButton = new SoundButton();
			buttonsLayer.addChild(soundButton);
			soundButton.cx = backboard.width / 2;
			soundButton.cy = BUTTONS_OFFSET;
			
			// Create sound button
			creditButton = new CreditButton();
			buttonsLayer.addChild(creditButton);
			creditButton.cx = backboard.width / 2;
			creditButton.cy = BUTTONS_OFFSET;
			
		}
		
		public function rollOutButtons(speed:Number):void
		{
			
			var sign = speed < 0 ? -1 : 1;
			backboard.y += speed;
			var index:int = sign ? 0 : buttonsLayer.numChildren - 1;
			var increment:int = sign ? -1 : 1
			for (var i:int = index; i >= 0; i += increment)
			{
				var button:DisplayObject = buttonsLayer.getChildAt(i);
				button.y += speed;
				if (button.y < button.width * sign && sign == -1)
				{
					--i;
				} 
				else if (button.y > button.width && sign == 1)
				{
					++i;
				}
			}
			
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}

	}
	
}
