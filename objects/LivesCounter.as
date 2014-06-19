package objects {
	
	import starling.utils.Color;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class LivesCounter extends Entity {

		public static var LIVES_OFFSET:int = 10;
		public static var LIVES_WIDTH:int = 60;
		public static var LIVES_HEIGHT:int = 25;
		public static var FONT_SIZE:int = 16;
		public static var FONT_COLOR:uint = Color.SILVER;
		public static var FONT_TYPE:String = "Arial";
		public static var FONT_ISBOLD:Boolean = true;
		
		private var _lives:int;
		private var _projectiles:Array;
		private var _projectileLiveBar:Sprite;
		private var _livesText:TextField;
		private var _player:Player;
		
		public function LivesCounter(lives:int, player:Player)  
		{
			super();
			_lives = lives;
			_player = player;
			
			/* Create lives text. */
			_livesText = new TextField(LIVES_WIDTH, LIVES_HEIGHT, "Lives: ", FONT_TYPE, FONT_SIZE, FONT_COLOR, FONT_ISBOLD);
			addChild(_livesText);			
			
			_projectileLiveBar = new Sprite();
			_projectileLiveBar.x = LIVES_WIDTH + LIVES_OFFSET / 2;
			_projectileLiveBar.y = LIVES_OFFSET / 2;
			// Create lives number of projectiles (each projectile symbolizes the next projectile)
			var randomColor:int;
			var livesXPos:int = 0;
			_projectiles = [];
			for (var i:int = _lives - 1; i >= 0; --i) 
			{
				var projectile:Projectile = new Projectile(Projectile.COLORS[i % Projectile.COLORS.length]);
				_projectiles.push(projectile);
				
				// Add projectile to lives bar
				projectile.x = livesXPos;
				_projectileLiveBar.addChild(projectile);
				
				// Get ready to position for next projectile
				livesXPos += projectile.width * 1.5;
			}
			addChild(_projectileLiveBar);
		}
		
		public function deductLife():void
		{
			--_lives;
			_player.color = _projectiles[_lives].color;
			_projectileLiveBar.removeChild(_projectiles[_lives]);
		}
		
		public function get lives():int
		{
			return _lives;
		}

	}
	
}
