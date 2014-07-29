package text {
	
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.Color;
	import objects.Entity;
	
	public class StarsLeftText extends Entity {

		public static var OFFSETY:int = 30;
		public static var OFFSETX:int = 0;
		public static var WIDTH:int = 100;
		public static var HEIGHT:int = 25;
		public static var FONT_SIZE:int = 14;
		public static var FONT_COLOR:uint = Color.WHITE;
		public static var FONT_TYPE:String = "white";
		public static var FONT_ISBOLD:Boolean = true;
		
		private var _starsText:TextField;
		private var _starsLeft:int;
		
		public function StarsLeftText(starsLeft:Number) 
		{
			/* Create stars text. */
			_starsLeft = starsLeft;
			_starsText = new TextField(WIDTH, HEIGHT, "Stars Left: " + _starsLeft, FONT_TYPE, FONT_SIZE, FONT_COLOR, FONT_ISBOLD);
			_starsText.y = OFFSETY;
			_starsText.x = OFFSETX;
			addChild(_starsText);	
		}
	
		public function get starsLeft():int 
		{
			return _starsLeft;
		}
		
		public function set starsLeft(value:int):void
		{
			_starsLeft = value;
			_starsText.text = "Stars Left: " + _starsLeft;
		}
		
	}
	
}
