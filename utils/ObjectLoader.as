package utils  {
	
	import screens.CreditScreen;
	import screens.LevelSelectScreen;
	
	import buttons.LevelSelection;
	
	public class ObjectLoader 
	{

		public static function load_credit_screen(data:Object):CreditScreen
		{
			return null;
		}
		
		public static function load_select_screen(data:Object):LevelSelectScreen
		{
			var loadSelectScreen:LevelSelectScreen = new LevelSelectScreen();
			
			var selections:Object = data.selections;
			var slength:int = selections.length;
			for (var i:int = slength - 1; i >= 0; --i)
			{
				// Create new level selection
				var levelSelection:LevelSelection = new LevelSelection(selections[i].number);
				levelSelection.cx = selections[i].cx;
				levelSelection.cy = selections[i].cy;
				loadSelectScreen.addEntity(levelSelection);
			}
			return loadSelectScreen;
		}
		
	}
	
}
