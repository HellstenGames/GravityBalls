package managers  {
	import objects.Star;

	import starling.core.Starling;
	import starling.display.Sprite;
	import utils.SpritePool;

	public class StarManager {

		public static var PROJECTILE_HIDDEN_XOFFSET:Number = -10000;
		public static var PROJECTILE_HIDDEN_YOFFSET:Number = -10000;

		public var stars:Array;
		private var _pool:SpritePool;
		private var _counter:int;

		private var _layer:Sprite;
		private var _scene:*;
		
		public function StarManager(layer:Sprite, scene:*, len:int=100) {
			super();

			_scene = scene;
			
			// Create sprite pool + points array, and set reference layer.
			_pool = new SpritePool(Star, len);
			stars = []
			_layer = layer;
		}

		public function addStar(cx:Number, cy:Number):void {

			var p:Star = _pool.getSprite() as Star;
			p.x = cx - p.width / 2;
			p.y = cy - p.height / 2

			// Set original center points, prevent the scaling from looking off
			p.originalCX = p.cx;
			p.originalCY = p.cy;
				
			// Set scale randomly so all stars are not identical
			p.scaleX = p.scaleY = (Math.random() * (Star.SCALE_MAX - Star.SCALE_MIN) + Star.SCALE_MIN);
			
			_layer.addChild(p);
			stars.push(p);

		}
		
		public function removeStar(i:int):void {

			var p:Star = stars[i];

			stars.splice(i, 1);
			_layer.removeChild(p);
			_pool.returnSprite(p);

			--_scene.starsLeftText.starsLeft;
		}

		public function removeAll():void 
		{
			var plength:int = stars.length; 
			for (var i:int = plength - 1; i >= 0; --i) 
			{
				_layer.removeChild(stars[i]);
				_pool.returnSprite(stars[i]);
			}
			stars.splice(0);
		}

		public function update(timeDelta:Number):void 
		{
			var plength:int = stars.length; 
			for (var i:int = plength - 1; i >= 0; --i) 
			{
				stars[i].update(timeDelta);
			}
			
		}

		// =========================================================================================================================================================
		// Properties
		// =========================================================================================================================================================
		public function get starsCount():int {
			return stars.length;
		}

	}

}