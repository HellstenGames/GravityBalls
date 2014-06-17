package managers  {
	import objects.Sun;
	import starling.core.Starling;
	import objects.Projectile;
	import starling.display.Sprite;
	import utils.SpritePool;
	import objects.Player;
	import objects.Entity;

	public class SunManager {

		public var suns:Array;
		private var _pool:SpritePool;
		private var _counter:int;
		private var _layer:Sprite;

		private var _leftBoundary:Number, _topBoundary:Number, _rightBoundary:Number, _bottomBoundary:Number;
		private var _gravitate:Boolean;

		private var _projectileManager:ProjectileManager;
		
		public function SunManager(layer:Sprite, projectileManager:ProjectileManager, len:int) {
			_layer = layer;
			_projectileManager = projectileManager;
			
			// Create sprite pool + suns array, and set reference layer.
			_pool = new SpritePool(Sun, len);
			suns = []
			_layer = layer;
			
			_leftBoundary = _topBoundary = 0;
			_rightBoundary = Starling.current.nativeStage.stageWidth;
			_bottomBoundary = Starling.current.nativeStage.stageHeight;
			_gravitate = false;
		}

		public function addSun(cx:Number, cy:Number, dx:Number, dy:Number):void {

			var s:Sun = _pool.getSprite() as Sun;
			s.x = cx - s.width / 2;
			s.y = cy - s.height / 2;
			s.dx = dx;
			s.dy = dy;
			_layer.addChild(s);
			suns.push(s);
		}

		public function removeSun(i:int):void {


			var s:Sun = suns[i];

			suns.splice(i, 1);
			_layer.removeChild(s);
			_pool.returnSprite(s);

		}

		public function removeAll():void 
		{
			var slength:int = suns.length; 
			for (var i:int = slength - 1; i >= 0; --i) 
			{
				_layer.removeChild(suns[i]);
				_pool.returnSprite(suns[i]);
			}
			suns.splice(0);
		}
		
		public function update(timeDelta:Number):void {
			var slength:int = suns.length; 

			for (var i:int = slength - 1; i >= 0; --i) {

				suns[i].update(timeDelta);

				// Check if projectiles is out of bounds
				if (Physics.isOutOfBounds(suns[i].x, suns[i].y, suns[i].width, suns[i].height, 
										  _leftBoundary, _topBoundary, _rightBoundary, _bottomBoundary))
				{
					removeSun(i);
					--i;
					continue; // go to next sun, this one has been removed	
				}

			}

			// Make sure to get current suns array length
			slength = suns.length; 

			// Suns gravitate towards each other
			if (_gravitate) 
			{		
				for (var s1:int = slength - 1; s1 >= 0; --s1)
				{
					for (var s2:int = s1 - 1; s2 >= 0; --s2)
					{

						// Apply Gravitaty to both suns
						var s1Components:Array = Physics.getGravityComponents(suns[s2].x, suns[s2].y, suns[s2].width / 2, suns[s2].mass,
																			  suns[s1].x, suns[s1].y, suns[s1].height / 2, suns[s1].mass);
						suns[s1].velocity[0] += s1Components[0];
						suns[s1].velocity[1] += s1Components[1];
						
						var s2Components:Array = Physics.getGravityComponents(suns[s1].x, suns[s1].y, suns[s1].width / 2, suns[s1].mass,
																			  suns[s2].x, suns[s2].y, suns[s2].height / 2, suns[s2].mass);
						suns[s2].velocity[0] += s2Components[0];
						suns[s2].velocity[1] += s2Components[1];						
		
						// Sun collision detection
						if (Physics.circleDetection(suns[s1].x, suns[s1].y, suns[s1].width / 2, 
													suns[s2].x, suns[s2].y, suns[s2].height / 2))
						{
							removeSun(s1);
							removeSun(s2);
							//Assets.sunCollisionSound.play();
							--s1;
							break;
						}

					}
				}
			}	

			handleProjectileManager();
		}

		public function setBoundary(leftBoundary:Number, topBoundary:Number, rightBoundary:Number, bottomBoundary:Number):void {
			_leftBoundary = leftBoundary;
			_topBoundary = topBoundary;
			_rightBoundary = rightBoundary;
			_bottomBoundary = bottomBoundary;
		}

		public function handleProjectileManager():void {

			var slength:int = suns.length; 
			for (var s:int = slength - 1; s >= 0; --s)
			{
				var plength:int = _projectileManager.projectiles.length;
				var sun:Sun = suns[s];
				for (var p:int = plength - 1; p >= 0; --p)
				{

					var projectile:Projectile = _projectileManager.projectiles[p];
					
					var components:Array = Physics.getGravityComponents(sun.x, sun.y, sun.width / 2, sun.mass,
																		projectile.x, projectile.y, projectile.width / 2, projectile.mass);
					projectile.velocity[0] += components[0];
					projectile.velocity[1] += components[1];

					// Do collision check
					if (Physics.circleDetection(sun.x, sun.y, sun.width / 2, 
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
		public function set gravitate(setValue:Boolean):void {
			_gravitate = setValue;
		}
		public function get gravitate():Boolean {
			return _gravitate;
		}

		public function get sunCount():Number {
			return suns.length;
		}

	}

}