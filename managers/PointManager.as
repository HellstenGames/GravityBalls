package managers  {
	import objects.Point;

	import starling.core.Starling;
	import starling.display.Sprite;
	import utils.SpritePool;

	public class PointManager {

		public static var PROJECTILE_HIDDEN_XOFFSET:Number = -10000;
		public static var PROJECTILE_HIDDEN_YOFFSET:Number = -10000;

		public var points:Array;
		private var _pool:SpritePool;
		private var _counter:int;

		private var _layer:Sprite;

		public function PointManager(layer:Sprite, len:int=100) {
			super();

			// Create sprite pool + points array, and set reference layer.
			_pool = new SpritePool(Point, len);
			points = []
			_layer = layer;
		}

		public function addPoint(cx:Number, cy:Number):void {

			var p:Point = _pool.getSprite() as Point;
			p.x = cx - p.width / 2;
			p.y = cy - p.height / 2

			_layer.addChild(p);
			points.push(p);

		}
		
		public function removePoint(i:int):void {

			var p:Point = points[i];

			points.splice(i, 1);
			_layer.removeChild(p);
			_pool.returnSprite(p);

		}

		public function removeAll():void 
		{
			var plength:int = points.length; 
			for (var i:int = plength - 1; i >= 0; --i) 
			{
				_layer.removeChild(points[i]);
				_pool.returnSprite(points[i]);
			}
			points.splice(0);
		}

		public function update(timeDelta:Number):void {
			
		}

		// =========================================================================================================================================================
		// Properties
		// =========================================================================================================================================================
		public function get pointCount():int {
			return points.length;
		}

	}

}