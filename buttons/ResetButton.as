package buttons  {
	
	// Import project stuff
	import objects.GameEntity;
	import scenes.SandboxScene;
	
	// Import starling stuff
	import starling.core.Starling;
	import starling.events.TouchEvent;
	import starling.display.Image;
	import starling.display.Sprite;
	import scenes.SandboxScene;
	
	public class ResetButton extends Button {

		private var _image:Image;
		
		public function ResetButton(cx:Number, cy:Number) {
			super(cx, cy);

			// Add image
			_image = getCorrectImage();
			addChild(_image);
			adjustCentered();
			
		}

		private function getCorrectImage():Image {
            // Get the scaling factor (1, 2, 3 etc)
            var scalingFactor:int = Math.round(Starling.contentScaleFactor);
            
            if (scalingFactor == 1) {
				return new Image(Assets.resetButtonTexture);
            } 
            else if (scalingFactor == 2) {
				return new Image(Assets.resetButtonTexture);
            } 
            else {
				return new Image(Assets.resetButtonTexture);
            }
            // If you have a 4x version of the graphics, here is the place to add some code..
        }
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
		override protected function onTouch(event:TouchEvent):void
		{
			super.onTouch(event);
		}
		
		override protected function touchCallBack():void 
		{
			super.touchCallBack();
			var scene:SandboxScene = this.parent.parent.parent as SandboxScene;
			scene.projectileManager.removeAll();
		}
		
	}
	
}
