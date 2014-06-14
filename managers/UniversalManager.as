package managers {
	
	// Import project stuff
	import scenes.Scene;
	import starling.display.Sprite;
	
	public class UniversalManager {

		private var _scene:Scene;
		
		// Array of objects
		public var suns:Array;
		public var projectiles:Array;
		
		public function UniversalManager(scene:Scene) 
		{
			_scene = scene;
			suns = [];
			projectiles = [];
		}

		public function addObject(object:*, layer:Sprite=null):void
		{
			if (layer == null)
			{
			var s:Sun = _pool.getSprite() as Sun;
			s.x = cx - s.width / 2;
			s.y = cy - s.height / 2;
			s.velocity[0] = dx;
			s.velocity[1] = dy;
			_layer.addChild(s);
			suns.push(s);
			}
		}
		
		public function removeObject(object:*):void
		{
			object.parent.removeChild(object);
		}
		
	}
	
}
