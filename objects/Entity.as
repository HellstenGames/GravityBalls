package objects 
{
	
	// Import starling stuff
	import starling.display.Sprite;
	
	// Import project stuff
	import components.Component;
	
	public class Entity extends Sprite 
	{

		public var velocity:Array;
		public var entities:Array;
		public var origCX:Number, origCY:Number;
		
		public function Entity(xPos:Number=0, yPos:Number=0, dx:Number=0, dy:Number=0)  
		{
			velocity = new Array(dx, dy);
			entities = [];
			x = xPos;
			y = yPos;
		}


		public function addEntity(... args):void
		{
			for (var i:uint = 0; i < args.length; i++) {
				addChild(args[i]);
				entities.push(args[i]);	
			}	
		}
		
		public function removeEntity(entity:Entity):void
		{
			removeChild(entity);
			entities.splice(entity);
		}
		
		public function update(timeDelta:Number):void
		{
			// Update entity position
			x += velocity[0] * timeDelta;
			y += velocity[1] * timeDelta;

			// Update entities inside this entity
			var el:int = entities.length;
			for (var e:int = el - 1; e >=0; --e)
			{
				entities[e].update(timeDelta);
			}
		}
		
		public function get cx():Number
		{
			return x + width / 2;
		}
		
		public function get cy():Number
		{
			return y + height / 2;
		}
		
		public function set cx(value:Number):void
		{
			x = value - width / 2;
		}
		
		public function set cy(value:Number):void
		{
			y = value - height / 2;
		}
		
		public function set dx(value:Number):void
		{
			velocity[0] = value;
		}
		
		public function set dy(value:Number):void
		{
			velocity[1] = value;
		}
		
		public function get dx():Number
		{
			return velocity[0];
		}
		
		public function get dy():Number
		{
			return velocity[1];
		}
		
		public function trackOriginalCenter():void
		{
			origCX = cx;
			origCY = cy;
		}
	}
	
}
