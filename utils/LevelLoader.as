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
					pscene.playerManager.setPlayer(data[i].position.cx, data[i].position.cy);
				}				
				else if (data[i].item == "star")
				{
					pscene.starManager.addStar(data[i].position.cx, data[i].position.cy);
				}		
				else if (data[i].item == "asteroid")
				{
					pscene.asteroidManager.addAsteroid(data[i].position.cx, data[i].position.cy, data[i].dx, data[i].dy);
				}
				else if (data[i].item == "wall")
				{
					pscene.wallManager.addWall(data[i].coordinates.x1, data[i].coordinates.y1, data[i].coordinates.x2, data[i].coordinates.y2, uint(data[i].color));
				}
			}
		
		}
	}
	
}
