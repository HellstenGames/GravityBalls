package managers  {
	import objects.Asteroid;
	import starling.core.Starling;
	import objects.Projectile;
	import starling.display.Sprite;
	import utils.SpritePool;

	public class AsteroidManager {

		public var asteroids:Array;
		private var _pool:SpritePool;
		private var _counter:int;
		private var _layer:Sprite;
		
		private static var OUT_OF_BOUNDS_LEFT:Number = -200;
		private static var OUT_OF_BOUNDS_TOP:Number = - 200;
		private static var OUT_OF_BOUNDS_RIGHT:Number = 600;
		private static var OUT_OF_BOUNDS_BOTTOM:Number = 500;
		
		public function AsteroidManager(layer:Sprite, len:int=10) {
			_layer = layer;
			
			// Create sprite pool
			_pool = new SpritePool(Asteroid, len);
			asteroids = [];
			_layer = layer;
		}

		public function addAsteroid(cx:Number, cy:Number, dx:Number, dy:Number):void 
		{
			var asteroid:Asteroid = _pool.getSprite() as Asteroid;
			asteroid.x = cx - asteroid.width / 2;
			asteroid.y = cy - asteroid.height / 2;
			asteroid.dx = dx;
			asteroid.dy = dy;
			asteroid.alpha = 1.0;
			_layer.addChild(asteroid);
			asteroids.push(asteroid);
			
			// Set original positions and speed for reference
			asteroid.originalCX = cx;
			asteroid.originalCY = cy;
			asteroid.originalDX = dx;
			asteroid.originalDY = dy;
			
			// Set rotation speed
			var rs:Number = Math.random() * (Asteroid.ROTATION_MAX - Asteroid.ROTATION_MIN) + Asteroid.ROTATION_MIN;
			asteroid.rotationSpeed = rs;
		}

		public function removeAsteroid(i:int):void 
		{
			var asteroid:Asteroid = asteroids[i];
			asteroids.splice(i, 1);
			_layer.removeChild(asteroid);
			_pool.returnSprite(asteroid);
		}

		public function removeAll():void 
		{
			var alength:int = asteroids.length; 
			for (var i:int = alength - 1; i >= 0; --i) 
			{
				_layer.removeChild(asteroids[i]);
				_pool.returnSprite(asteroids[i]);
			}
			asteroids.splice(0);
		}
		
		public function update(timeDelta:Number):void 
		{
			var alength:int = asteroids.length; 

			for (var i:int = alength - 1; i >= 0; --i) 
			{
				asteroids[i].update(timeDelta);
				
				// Check if out of bounds
				if (Physics.isOutOfBounds(asteroids[i].x, asteroids[i].y, asteroids[i].width, asteroids[i].height,
							OUT_OF_BOUNDS_LEFT, OUT_OF_BOUNDS_TOP, OUT_OF_BOUNDS_RIGHT, OUT_OF_BOUNDS_BOTTOM))	
				{
					resetAsteroid(asteroids[i]);
				}
			}
		}
		
		private function resetAsteroid(asteroid:Asteroid):void
		{
			asteroid.cx = asteroid.originalCX;
			asteroid.cy = asteroid.originalCY;
			asteroid.dx = asteroid.originalDX;
			asteroid.dy = asteroid.originalDY;
			// Set rotation speed
			var rs:Number = Math.random() * (Asteroid.ROTATION_MAX - Asteroid.ROTATION_MIN) + Asteroid.ROTATION_MIN;
			asteroid.rotationSpeed = rs;			
		}
		
	}

}