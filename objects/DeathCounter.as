package objects {
	
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class DeathCounter extends Entity {

		public static var OFFSETY:int = 10;
		public static var OFFSETX:int = 380;
		public static var WIDTH:int = 100;
		public static var HEIGHT:int = 25;
		public static var FONT_SIZE:int = 14;
		public static var FONT_COLOR:uint = Color.WHITE;
		public static var FONT_TYPE:String = "blue";
		public static var FONT_ISBOLD:Boolean = true;
		
		
		private var _deathText:TextField;
		private var _deaths:int;
		
		public function DeathCounter()  
		{
			super();
			_deaths = 0;
			
			/* Create death text. */
			_deathText = new TextField(WIDTH, HEIGHT, "Deaths: 0", FONT_TYPE, FONT_SIZE, FONT_COLOR, FONT_ISBOLD);
			_deathText.y = OFFSETY;
			_deathText.x = OFFSETX;
			addChild(_deathText);			
			
		}
		
		public function get deaths():int
		{
			return _deaths;
		}
		
		public function set deaths(value:int):void
		{
			_deaths = value;
			_deathText.text = "Deaths: " + _deaths;
		}

	}
	
}
