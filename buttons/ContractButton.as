package buttons  {
	
	// Import project stuff
	import objects.GameEntity;
	
	// Import starling stuff
	import starling.core.Starling;
	import starling.events.TouchEvent;
	import starling.display.Image;
	
	public class ContractButton extends Button {

		public static const CONTRACT_MENU_ACCELERATION:Number = -10;
		
		private var _entityToContract:GameEntity;
		private var _image:Image;
		private var _contracting:Boolean;
		
		public function ContractButton(entityToContract:GameEntity, cx:Number, cy:Number) {
			super(cx, cy);
			_entityToContract = entityToContract;
			
			// Add image
			_image = getCorrectImage();
			addChild(_image);
			adjustCentered();
			
		}

		private function getCorrectImage():Image {
            // Get the scaling factor (1, 2, 3 etc)
            var scalingFactor:int = Math.round(Starling.contentScaleFactor);
            
            if (scalingFactor == 1) {
				return new Image(Game.INSTANCE.contractButtonTexture);
            } 
            else if (scalingFactor == 2) {
				return new Image(Game.INSTANCE.contractButtonTexture);
            } 
            else {
				return new Image(Game.INSTANCE.contractButtonTexture);
            }
            // If you have a 4x version of the graphics, here is the place to add some code..
        }
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			if (_contracting)
			{
				// Is the menu off the screen completely or not?
				if (_entityToContract.x > -_entityToContract.width)
				{
					_entityToContract.ax = CONTRACT_MENU_ACCELERATION;
				} 
				else
				{
					_contracting = false;
					_entityToContract.stop();
				}
			}
		}
		
		override protected function onTouch(event:TouchEvent):void
		{
			super.onTouch(event);
		}
		
		override protected function touchCallBack():void 
		{
			super.touchCallBack();
			_contracting = true;
		}
		
	}
	
}
