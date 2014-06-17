package utils {
	
	// Import project stuff
	import scenes.PlayScene;
	import objects.Player;
	
	public class LevelLoader {

		public static function load_level(data:Object, pscene:PlayScene):void
		{

			var dlength:int = data.length;
			for (var i:int = dlength - 1; i >= 0; --i)
			{
				if (data[i].item == "sun")
				{
					pscene.sunManager.addSun(data[i].position.cx, data[i].position.cy, 0, 0);
				}
				else if (data[i].item == "projectile")
				{
					pscene.projectileManager.addProjectile(data[i].position.cx, data[i].position.cy, 0, 0);
				}
				else if (data[i].item == "blackhole")
				{
					pscene.blackholeManager.addBlackHole(data[i].position.cx, data[i].position.cy, 0, 0);
				}
				else if (data[i].item == "player")
				{
					pscene.player = new Player(data[i].position.cx, data[i].position.cy, "blue");
					pscene.playerManager.setPlayer(pscene.player);
				}				
				else if (data[i].item == "collectible")
				{
					pscene.collectibleManager.addCollectible(data[i].position.cx, data[i].position.cy);
				}								
			}
		
		}
	}
	
}
