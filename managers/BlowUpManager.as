package managers  {
	
	/* Import starling stuff */
	import starling.display.Sprite;
	import starling.utils.Color;
	
	/* Import project stuff */
	import objects.Bit;
	import utils.SpritePool;
	import scenes.Scene;
	
	
	public class BlowUpManager {

		public var bits:Array;
		private var _pool:SpritePool;
		private var _counter:int;
		private var _layer:Sprite;
		private var _scene:*;
		
		public function BlowUpManager(layer:Sprite, scene:*, len:int=200) {
			_layer = layer;
			_scene = scene;
			_pool = new SpritePool(Bit, len);
			bits = [];
			_layer = layer;
		}
		
		public function addBit(cx:Number, cy:Number, dx:Number, dy:Number, color:uint):void 
		{
			var bit:Bit = _pool.getSprite() as Bit;
			bit.x = cx - bit.width / 2;
			bit.y = cy - bit.height / 2;
			bit.dx = dx;
			bit.dy = dy;
			bit.color = color;
			_layer.addChild(bit);
			bits.push(bit);
		}

		public function removeBit(i:int):void 
		{
			var bit:Bit = bits[i];
			bit.alpha = 1.0; /* Make sure bit is visible if used again */
			bits.splice(i, 1);
			_layer.removeChild(bit);
			_pool.returnSprite(bit);
		}

		public function removeAll():void 
		{
			var blength:int = bits.length; 
			for (var i:int = blength - 1; i >= 0; --i) 
			{
				_layer.removeChild(bits[i]);
				_pool.returnSprite(bits[i]);
			}
			bits.splice(0);
		}
		
		public function update(timeDelta:Number):void 
		{
			var blength:int = bits.length; 
			var slength:int = _scene.sunManager.suns.length;
			var suns:Array = _scene.sunManager.suns;
			
			for (var i:int = blength - 1; i >= 0; --i) 
			{
				bits[i].update(timeDelta);
				/* Make the bits slowly fade away, 
				   remove bit if its completely invisible */
				bits[i].alpha -= Constants.kBitFadeAwaySpeed;
				if (bits[i].alpha <= 0)
				{
					removeBit(i);
					continue;
				}
				/* Apply gravity to bits */
				for (var s:int = slength - 1; s >= 0; --s)
				{
					// Apply Gravitaty to bits
					var sComponents:Array = Physics.getGravityComponents(suns[s].x, suns[s].y, suns[s].width / 2, suns[s].mass,
																		 bits[i].x, bits[i].y, bits[i].height / 2, bits[i].mass);
					bits[i].velocity[0] += sComponents[0];
					bits[i].velocity[1] += sComponents[1];

					// Entity collides with sun
					if (Physics.circleDetection(suns[s].x, suns[s].y, suns[s].width / 2, 
												bits[i].x, bits[i].y, bits[i].height / 2))
					{
						removeBit(i);
						continue;
					}
				}
			}
		}		

	}
	
}
