package objects  {
	
	import starling.text.TextField;
	
	public class PopupText extends Entity {

		public static var SCALE_SPEED:Number = 0.01;
		public static var DISAPPEAR_SPEED:Number = 1.0;
		public static var FONT_TYPE:String = "Arial";
		public static var FONT_SIZE:int = 12;
		public static var FONT_
		private var _text:String;
		private var _textSprite:TextField;
		
		public var originalCX:Number, originalCY:Number;
			
		
		public function PopupText() 
		{
			super();
			_textSprite = new TextField(100, 100, 
		}

		public function set text(value:String):void
		{
			_text = value;
		}
		public function get text():String
		{
			return _text;
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
	}
	
}
