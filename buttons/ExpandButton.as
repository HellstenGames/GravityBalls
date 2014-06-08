package buttons  {
	
	// Import project stuff
	import objects.GameEntity;
	
	// Import starling stuff
	import starling.core.Starling;
	import starling.events.TouchEvent;
	import starling.display.Image;
	
	public class ExpandButton extends Button {

		public static const EXPAND_MENU_ACCELERATION:Number = 10;
		
		private var _entityToExpand:GameEntity;
		private var _image:Image;
		private var _expanding:Boolean;
		
		public function ExpandButton(entityToExpand:GameEntity, cx:Number, cy:Number) {
			super(cx, cy);
			_entityToExpand = entityToExpand;
			
			// Add image
			_image = getCorrectImage();
			addChild(_image);
			adjustCentered();
			
		}

		private function getCorrectImage():Image {
            // Get the scaling factor (1, 2, 3 etc)
            var scalingFactor:int = Math.round(Starling.contentScaleFactor);
            return new Image(Game.INSTANCE.contractButtonTexture);
        }
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			if (_expanding)
			{
				// Is the menu off the screen completely or not?
				if (_entityToExpand.x < 0)
				{
					_entityToExpand.ax = EXPAND_MENU_ACCELERATION;
				} 
				else
				{
					_expanding = false;
					_entityToExpand.x = 0;
					_entityToExpand.stop();
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
			_expanding = true;
		}
		
	}
	
}
