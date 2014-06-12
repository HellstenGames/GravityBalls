package managers  {
	import objects.Sun;
	import starling.core.Starling;
	import objects.Projectile;
	import starling.display.Sprite;
	import utils.SpritePool;
	
	public class SunManager {

		public var suns:Array;
		private var _pool:SpritePool;
		private var _counter:int;
		private var _layer:Sprite;
		
		private var _leftBoundary:Number, _topBoundary:Number, _rightBoundary:Number, _bottomBoundary:Number;
		private var _gravitate:Boolean;
		public var projectileManager:ProjectileManager;
		
		public function SunManager(layer:Sprite, len:int=100) {
			_layer = layer;
			
			// Create sprite pool + suns array, and set reference layer.
			_pool = new SpritePool(Sun, len);
			suns = []
			_layer = layer;
			
			_leftBoundary = _topBoundary = 0;
			_rightBoundary = Starling.current.nativeStage.stageWidth;
			_bottomBoundary = Starling.current.nativeStage.stageHeight;
			_gravitate = false;
			projectileManager = null;
			
		}
		
		public function addSun(cx:Number, cy:Number, dx:Number, dy:Number):void {
			
			var s:Sun = _pool.getSprite() as Sun;
			s.x = cx - s.width / 2;
			s.y = cy - s.height / 2;
			s.velocity[0] = dx;
			s.velocity[1] = dy;
			_layer.addChild(s);
			suns.push(s);
		}
		
		public function removeSun(i:int):void {
			
			var s:Sun = suns[i];
			
			suns.splice(i, 1);
			_layer.removeChild(s);
			_pool.returnSprite(s);
			
		}
		
		public function update(timeDelta:Number):void {
			var slength:int = suns.length; 
			
			for (var i:int = slength - 1; i >= 0; --i) {

				suns[i].update(timeDelta);
				
				// Check if projectiles is out of bounds
				if (Physics.isOutOfBounds(suns[i], _leftBoundary, _topBoundary, _rightBoundary, _bottomBoundary))
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
						Physics.applyGravity(suns[s1], suns[s2], suns[s1].mass, suns[s2].mass);
						Physics.applyGravity(suns[s2], suns[s1], suns[s2].mass, suns[s1].mass);	
						
						// Sun collision detection
						if (Physics.circleDetection(suns[s1], suns[s2]))
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
			
			handleProjectiles();

		}
		
		public function setBoundary(leftBoundary:Number, topBoundary:Number, rightBoundary:Number, bottomBoundary:Number):void {
			_leftBoundary = leftBoundary;
			_topBoundary = topBoundary;
			_rightBoundary = rightBoundary;
			_bottomBoundary = bottomBoundary;
		}
		
		private function handleProjectiles():void {
			
			if (projectileManager == null)
				return;
			
			// Loop through all the suns and apply gravity onto the projectiles
			for (var s:int = 0; s < suns.length; ++s) {
				var sun:Sun = suns[s];
				for (var p:int = 0; p < projectileManager.projectiles.length; ++p) {
					var projectile:Projectile = projectileManager.projectiles[p];
					
					Physics.applyGravity(sun, projectile, sun.mass, projectile.mass);
					// Do collision check
					if (Physics.circleDetection(sun, projectile)) 
					{ 
						projectileManager.removeProjectile(p);
						//Assets.projectileCollisionSound.play();								
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
