package objects  {
	
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class PopupText extends Entity {

		public static var SCALE_SPEED:Number = 0.02;
		public static var DISAPPEAR_SPEED:Number = 0.03;
		public static var FONT_TYPE:String = "Arial";
		public static var FONT_SIZE:int = 16;
		public static var FONT_COLOR:uint = Color.RED;
		public static var FONT_ISBOLD:Boolean = true;
		
		private var _textSprite:TextField;
		
		public var originalCX:Number, originalCY:Number;
			
		
		public function PopupText() 
		{
			super();
			_textSprite = new TextField(200, 200, "", FONT_TYPE, FONT_SIZE, FONT_COLOR, FONT_ISBOLD);
			addChild(_textSprite);
		}

		public function set text(value:String):void
		{
			_textSprite.text = value;
		}
		public function get text():String
		{
			return _textSprite.text;
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
	}
	
}
