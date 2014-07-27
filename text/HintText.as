package text  {
	
	import objects.Entity;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class HintText extends Entity {
		
		public static var FONT_TYPE:String = "Arial";
		public static var FONT_SIZE:int = 16;
		public static var FONT_COLOR:uint = Color.BLACK;
		public static var FONT_ISBOLD:Boolean = true;
		
		private var _textSprite:TextField;
		
		public var originalCX:Number, originalCY:Number;
			
		
		public function HintText() 
		{
			super();
			_textSprite = new TextField(50, 50, "Default", FONT_TYPE, FONT_SIZE, FONT_COLOR, FONT_ISBOLD);
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
