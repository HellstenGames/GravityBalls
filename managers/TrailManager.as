package managers  {
	import objects.Trail;
	import starling.core.Starling;
	import objects.Projectile;
	import starling.display.Sprite;
	import utils.SpritePool;

	public class TrailManager {

		public var trails:Array;
		private var _pool:SpritePool;
		private var _counter:int;
		private var _layer:Sprite;
		
		public function TrailManager(layer:Sprite, len:int=50) {
			_layer = layer;
			
			// Create sprite pool + suns array, and set reference layer.
			_pool = new SpritePool(Trail, len);
			trails = [];
			_layer = layer;
		}

		public function addTrail(cx:Number, cy:Number):void 
		{
			var trail:Trail = _pool.getSprite() as Trail;
			trail.x = cx - trail.width / 2;
			trail.y = cy - trail.height / 2;
			trail.alpha = 1.0;
			_layer.addChild(trail);
			trails.push(trail);
		}

		public function removeTrail(i:int):void 
		{
			var trail:Trail = trails[i];
			trails.splice(i, 1);
			_layer.removeChild(trail);
			_pool.returnSprite(trail);
		}

		public function removeAll():void 
		{
			var tlength:int = trails.length; 
			for (var i:int = tlength - 1; i >= 0; --i) 
			{
				_layer.removeChild(trails[i]);
				_pool.returnSprite(trails[i]);
			}
			trails.splice(0);
		}
		
		public function update(timeDelta:Number):void 
		{
			var tlength:int = trails.length; 

			for (var i:int = tlength - 1; i >= 0; --i) 
			{
				trails[i].update(timeDelta);
				
				// Make trails slowly disappear
				if (trails[i].alpha > 0)
					trails[i].alpha -= Trail.DISAPPEAR_SPEED;
				else 
					removeTrail(i);

			}
		}
		
	}

}