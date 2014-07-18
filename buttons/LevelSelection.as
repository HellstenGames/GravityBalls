package buttons {
	import starling.display.Image;
	import objects.Entity;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class LevelSelection extends Entity {

		public static var ROTATION_SPEED:Number = 0.05;
		private var _number:int;
		
		private var _backgroundImage:Image;
		private var _textField:TextField;
		
		public function LevelSelection(number:int) 
		{
			super();
			_backgroundImage = new Image(AssetResources.menuPickTexture)
			addChild(_backgroundImage);
			_backgroundImage.alignPivot();
			_number = number;

			// Create text field for number
			_textField = new TextField(_backgroundImage.width, _backgroundImage.height, _number.toString(), "Arial", 12, Color.WHITE);	
			trace(_textField.textBounds.width, _textField.textBounds.height);
			_textField.x -= _backgroundImage.width / 2 - _textField.textBounds.width;
			_textField.y -= _backgroundImage.height / 2 - _textField.textBounds.height;
			addChild(_textField);
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			_backgroundImage.rotation += ROTATION_SPEED;
		}
		
		public function get number():int { return _number; }
		

	}
	
}
