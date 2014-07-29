package utils {
	
	// Import project stuff
	import scenes.PlayScene;
	import objects.Player;
	import graphics.Rectangle;
	
	public class LevelLoader {

		public static function load_level(data:Object, pscene:PlayScene):void
		{
			
			var objs:Object = data.objects;
			var dlength:int = objs.length;
			
			/* Set width and height using rectangle */
			var rectangle:Rectangle = new Rectangle(0, 0, data.width, data.height, 0x052441);
			pscene.playBackgroundLayer.addChild(rectangle);
			Constants.kMapWidth = data.width;
			Constants.kMapHeight = data.height;
			
			for (var i:int = dlength - 1; i >= 0; --i)
			{
				
				if (objs[i].item == "sun")
				{
					pscene.sunManager.addSun(objs[i].position.cx, objs[i].position.cy, 0, 0);
				}
				else if (objs[i].item == "projectile")
				{
					pscene.projectileManager.addProjectile(objs[i].position.cx, objs[i].position.cy, 0, 0);
				}
				//else if (objs[i].item == "blackhole")
				//{
				//	pscene.blackholeManager.addBlackHole(objs[i].position.cx, objs[i].position.cy, 0, 0);
				//}
				else if (objs[i].item == "player")
				{
					pscene.playerManager.setPlayer(objs[i].position.cx, objs[i].position.cy);
				}				
				else if (objs[i].item == "star")
				{
					pscene.starManager.addStar(objs[i].position.cx, objs[i].position.cy);
				}		
				else if (objs[i].item == "asteroid")
				{
					pscene.asteroidManager.addAsteroid(objs[i].position.cx, objs[i].position.cy, objs[i].dx, objs[i].dy);
				}
				else if (objs[i].item == "wall")
				{
					pscene.wallManager.addWall(objs[i].coordinates.x1, objs[i].coordinates.y1, objs[i].coordinates.x2, objs[i].coordinates.y2, uint(objs[i].color));
				}
			}
		
		}
	}
	
}
