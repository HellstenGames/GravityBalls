package managers  {
	import objects.BlackHole;
	import starling.core.Starling;
	import objects.Projectile;
	import starling.display.Sprite;
	import utils.SpritePool;

	public class BlackholeManager {

		public var blackHoles:Array;
		private var _pool:SpritePool;
		private var _counter:int;
		private var _layer:Sprite;
		
		private var _projectileManager:ProjectileManager;
		
		public function BlackholeManager(layer:Sprite, projectileManager:ProjectileManager, len:int) {
			_layer = layer;
			_projectileManager = projectileManager;
			
			// Create sprite pool + suns array, and set reference layer.
			_pool = new SpritePool(BlackHole, len);
			blackHoles = []
			_layer = layer;
		}

		public function addBlackHole(cx:Number, cy:Number, dx:Number, dy:Number):void {

			var bh:BlackHole = _pool.getSprite() as BlackHole;
			bh.x = cx - bh.width / 2;
			bh.y = cy - bh.height / 2;
			bh.dx = dx;
			bh.dy = dy;
			_layer.addChild(bh);
			blackHoles.push(bh);
		}

		public function removeBlackHole(i:int):void 
		{

			var bh:BlackHole = blackHoles[i];

			blackHoles.splice(i, 1);
			_layer.removeChild(bh);
			_pool.returnSprite(bh);

		}

		public function update(timeDelta:Number):void {
			var bhlength:int = blackHoles.length; 

			for (var i:int = bhlength - 1; i >= 0; --i) {

				blackHoles[i].update(timeDelta);

			}

			handleProjectileManager();
		}

		public function handleProjectileManager():void {

			var bhLength:int = blackHoles.length; 
			for (var bh:int = bhLength - 1; bh >= 0; --bh)
			{
				var plength:int = _projectileManager.projectiles.length;
				var blackHole:BlackHole = blackHoles[bh];
				for (var p:int = plength - 1; p >= 0; --p)
				{

					var projectile:Projectile = _projectileManager.projectiles[p];
					
					var components:Array = Physics.getGravityComponents(blackHole.x, blackHole.y, blackHole.width / 2, blackHole.mass,
																		projectile.x, projectile.y, projectile.width / 2, projectile.mass);
					projectile.velocity[0] += components[0];
					projectile.velocity[1] += components[1];

					// Do collision check
					if (Physics.circleDetection(blackHole.x, blackHole.y, blackHole.width / 2, 
											    projectile.x, projectile.y, projectile.width / 2)) { 
						_projectileManager.removeProjectile(p);
						--p;
						continue; // go to next projectile, this one has been removed								
					}					
				}
			}

		}

		// =========================================================================================================================================================
		// Properties
		// =========================================================================================================================================================
		public function get blackHoleCount():Number {
			return blackHoles.length;
		}

	}

}