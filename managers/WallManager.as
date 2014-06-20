package managers  {
	import objects.Wall;

	import starling.core.Starling;
	import starling.display.Sprite;
	import utils.SpritePool;

	public class WallManager {

		public var walls:Array;
		private var _pool:SpritePool;
		private var _layer:Sprite;

		public function WallManager(layer:Sprite, len:int=100) {
			super();

			// Create sprite pool + points array, and set reference layer.
			_pool = new SpritePool(Wall, len);
			walls = []
			_layer = layer;
		}

		public function addWall(x1:Number, y1:Number, x2:Number, y2:Number, color:uint):void {

			var w:Wall = _pool.getSprite() as Wall;
			w.x = x1;
			w.y = y1;
			w.set(x2 - x1, y2 - y1);
			w.color = color;
			
			_layer.addChild(w);
			walls.push(w);
		}
		
		public function removeWall(i:int):void {

			var w:Wall = walls[i];

			walls.splice(i, 1);
			_layer.removeChild(w);
			_pool.returnSprite(w);

		}

		public function removeAll():void 
		{
			var wlength:int = walls.length; 
			for (var i:int = wlength - 1; i >= 0; --i) 
			{
				_layer.removeChild(walls[i]);
				_pool.returnSprite(walls[i]);
			}
			walls.splice(0);
		}

		public function update(timeDelta:Number):void 
		{
			// ? WHAT
		}

	}

}