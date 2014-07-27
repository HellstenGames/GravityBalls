package utils  {
	
	import screens.CreditScreen;
	import screens.LevelSelectScreen;
	
	import buttons.LevelSelection;
	import objects.Asteroid;

	import scenes.Scene;
	
	public class ObjectLoader 
	{

		public static function load_credit_screen(data:Object):CreditScreen
		{
			
			return null;
		}
		
		public static function load_select_screen(scene:Scene, data:Object):LevelSelectScreen
		{
			var loadSelectScreen:LevelSelectScreen = new LevelSelectScreen();
			
			// Load level selections
			if (data.selections)
			{
				var selections:Object = data.selections;
				var slength:int = selections.length;
				for (var i:int = slength - 1; i >= 0; --i)
				{
					// Create new level selection
					var levelSelection:LevelSelection = new LevelSelection(scene, selections[i].number);
					levelSelection.cx = selections[i].cx;
					levelSelection.cy = selections[i].cy;
					loadSelectScreen.addEntity(levelSelection);
				}
			}
		
			// Load doodads
			if (data.doodads)
			{
				var doodads:Object = data.doodads;
				var dlength:int = doodads.length;
				for (var d:int = dlength - 1; d >= 0; --d)
				{
					var doodad:Object = doodads[d];
					// Create/Add doodad
					if (doodad.item == "asteroid")
					{
						var asteroid:Asteroid = new Asteroid();
						asteroid.scaleX = asteroid.scaleY = 3.0;
						asteroid.cx = doodad.cx;
						asteroid.cy = doodad.cy;
						loadSelectScreen.addEntity(asteroid);
					}
				}
			}
			
			return loadSelectScreen;
		}
		
	}
	
}
