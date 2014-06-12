package managers  {
	import objects.Projectile;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import utils.SpritePool;
	
	public class ProjectileManager {

		public static var PROJECTILE_HIDDEN_XOFFSET:Number = -10000;
		public static var PROJECTILE_HIDDEN_YOFFSET:Number = -10000;
		
		public var projectiles:Array;
		private var _pool:SpritePool;
		private var _counter:int;
		
		private var _layer:Sprite;
		
		private var _leftBoundary:Number, _topBoundary:Number, _rightBoundary:Number, _bottomBoundary:Number;
		private var _gravitate:Boolean;
		
		public function ProjectileManager(layer:Sprite, len:int=100) {
			super();
			
			// Create sprite pool + projectiles array, and set reference layer.
			_pool = new SpritePool(Projectile, len);
			projectiles = []
			_layer = layer;
			
			_leftBoundary = _topBoundary = 0;
			_rightBoundary = Starling.current.nativeStage.stageWidth;
			_bottomBoundary = Starling.current.nativeStage.stageHeight;
		}
		
		public function addProjectile(cx:Number, cy:Number, dx:Number=0, dy:Number=0, color:String="blue"):void {
			
			var p:Projectile = _pool.getSprite() as Projectile;
			p.x = cx - p.width / 2;
			p.y = cy - p.height / 2
			p.velocity[0] = dx;
			p.velocity[1] = dy;

			p.color = color;
			_layer.addChild(p);
			projectiles.push(p);

		}
		
		public function removeProjectile(i:int):void {

			var p:Projectile = projectiles[i];
			
			projectiles.splice(i, 1);
			_layer.removeChild(p);
			_pool.returnSprite(p);

		}
		
		public function removeAll():void 
		{
			var plength:int = projectiles.length; 
			for (var i:int = plength - 1; i >= 0; --i) 
			{
				_layer.removeChild(projectiles[i]);
				_pool.returnSprite(projectiles[i]);
			}
			projectiles.splice(0);
		}
		
		public function update(timeDelta:Number):void {

			var plength:int = projectiles.length; 
			
			for (var i:int = plength - 1; i >= 0; --i) {
				projectiles[i].update(timeDelta);
				
				// Check if projectiles is out of bounds
				if (Physics.isOutOfBounds(projectiles[i], _leftBoundary, _topBoundary, _rightBoundary, _bottomBoundary))
				{
					removeProjectile(i);
					--i;
					continue; // go to next projectile, this one has been removed	
				}
			}
			
			// Make sure to get current projectiles array length
			plength = projectiles.length; 
			
			// Projectiles gravitate towards each other
			if (_gravitate) 
			{		
				for (var p1:int = plength - 1; p1 >= 0; --p1)
				{
					for (var p2:int = plength - 1; p2 >= 0; --p2)
					{
						if (p1 != p2) {
							Physics.applyGravity(projectiles[p1], projectiles[p2], projectiles[p1].mass, projectiles[p2].mass);
						}
					}
				}
			}	
				
		}
		
		
		public function setBoundary(leftBoundary:Number, topBoundary:Number, rightBoundary:Number, bottomBoundary:Number):void {
			_leftBoundary = leftBoundary;
			_topBoundary = topBoundary;
			_rightBoundary = rightBoundary;
			_bottomBoundary = bottomBoundary;
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
	
		public function get projectileCount():int {
			return projectiles.length;
		}
		
	}
	
}
