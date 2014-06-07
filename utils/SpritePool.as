package utils {
	import starling.display.DisplayObject;
	
	public class SpritePool {

		private var _pool:Array;
		private var _counter:int;
		
		public function SpritePool(type:Class, len:int) 
		{
			super()
			
			_pool = [];
			_counter = len;
			
			for (var i:int = len; i >= 0; --i) 
				_pool[i] = new type();
	
		}

		public function getSprite():DisplayObject 
		{
			if (_counter > 0) 
				return _pool[--_counter];
			else
				throw new Error("You exausted the pool!"); // might change this to create new sprite for pool
		}
		
		public function returnSprite(s:DisplayObject):void 
		{
			_pool[_counter++] = s;
		}
		
	}
	
}
