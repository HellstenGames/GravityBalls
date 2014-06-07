package objects {
	
	// Import project stuff
	import graphics.Rectangle;
	
	import buttons.ContractButton;
	import buttons.ResetButton;
	
	// Import starling stuff
	import starling.display.Sprite;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.utils.Color;

	
	public class SandboxMenu extends GameEntity {

		private var _sun:Sprite;
		private var _backboard:SandboxBackboard;
		
		// Button Objects
		private var _contractButton:ContractButton;
		private var _resetButton:ResetButton;
		
		public function SandboxMenu(xPos:Number, yPos:Number) {
			super();
			
			// Position Sandbox selection
			x = xPos;
			y = yPos;
			
			// Add backboard
			_backboard = new SandboxBackboard(0, 0);
			addChild(_backboard);
			
			// Add options
			_sun = new Sprite();

			
			addChild(_sun);
			
			// Add buttons
			_contractButton = new ContractButton(this, 75, Starling.current.stage.stageHeight / 2);
			addEntity(_contractButton);
			_resetButton = new ResetButton(_backboard.width / 2, Starling.current.stage.stageHeight - 25);
			addEntity(_resetButton);
			
            // Get the scaling factor (1, 2, 3 etc)
            var scalingFactor:int = Math.round(Starling.contentScaleFactor);
            
            if (scalingFactor == 1) {
				_sun.addChild(new Image(Assets.sun1xTexture));
            } 
            else if (scalingFactor == 2) {
				_sun.addChild(new Image(Assets.sun2xTexture));
            } 
            else {
				_sun.addChild(new Image(Assets.sun3xTexture));
            }
   
		}
		
		override public function update(timeDelta:Number):void {
			super.update(timeDelta);
		}

	}
	
}
