package buttons  {
	
	// Import project stuff
	import buttons.MenuButton;
	import scenes.Scene;
	
	// Import starling stuff
	import starling.display.Image;
	
	public class ExitButton extends MenuButton {

		public function ExitButton(scene:Scene) 
		{
			super(scene);
			
			_ballSprite.addChild(new Image(AssetResources.exitBallTexture));
			var textImage:Image = new Image(AssetResources.exitTextTexture);
			textImage.x = width / 2 - textImage.width / 2;
			textImage.y = height / 2 - textImage.height / 2;
			addChild(textImage);
			
			// Align Stupid pivot. Driving me nuts.
			_ballSprite.alignPivot();
			_ballSprite.x = _ballSprite.width / 2;
			_ballSprite.y = _ballSprite.height / 2;			
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);		
		}		
		
	}
	
}
