package managers  {
	import objects.Collectible;

	import starling.core.Starling;
	import starling.display.Sprite;
	import utils.SpritePool;

	public class CollectibleManager {

		public static var PROJECTILE_HIDDEN_XOFFSET:Number = -10000;
		public static var PROJECTILE_HIDDEN_YOFFSET:Number = -10000;

		public var collectibles:Array;
		private var _pool:SpritePool;
		private var _counter:int;

		private var _layer:Sprite;

		public function CollectibleManager(layer:Sprite, len:int=100) {
			super();

			// Create sprite pool + points array, and set reference layer.
			_pool = new SpritePool(Collectible, len);
			collectibles = []
			_layer = layer;
		}

		public function addCollectible(cx:Number, cy:Number):void {

			var p:Collectible = _pool.getSprite() as Collectible;
			p.x = cx - p.width / 2;
			p.y = cy - p.height / 2

			_layer.addChild(p);
			collectibles.push(p);

		}
		
		public function removeCollectible(i:int):void {

			var p:Collectible = collectibles[i];

			collectibles.splice(i, 1);
			_layer.removeChild(p);
			_pool.returnSprite(p);

		}

		public function removeAll():void 
		{
			var plength:int = collectibles.length; 
			for (var i:int = plength - 1; i >= 0; --i) 
			{
				_layer.removeChild(collectibles[i]);
				_pool.returnSprite(collectibles[i]);
			}
			collectibles.splice(0);
		}

		public function update(timeDelta:Number):void 
		{
			
		}

		// =========================================================================================================================================================
		// Properties
		// =========================================================================================================================================================
		public function get collectibleCount():int {
			return collectibles.length;
		}

	}

}