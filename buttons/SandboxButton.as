package buttons  {
	
	// Import project stuff
	import buttons.MenuButton;
	import scenes.Scene;
	import scenes.MenuScene;
	
	// Import starling stuff
	import starling.display.Image;
	
	public class SandboxButton extends MenuButton {

		public function SandboxButton(scene:Scene) 
		{
			super(scene);
			
			_ballSprite.addChild(new Image(AssetResources.sandboxBallTexture));
			var textImage:Image = new Image(AssetResources.sandboxTextTexture);
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
		
		override protected function _touchCallBack():void {
			_scene.nextScene = new MenuScene();
			_scene.destroy();
		}
		
	}
	
}
