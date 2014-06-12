package components  {
	
	import objects.GameObject;
	
	public class PhysicsComponent 
	{

		public function PhysicsComponent() 
		{
		}

		public function init(gameObject:*):void 
		{
		}
		
		public function update(gameObject:*, timeDelta:Number):void
		{
			gameObject.x += gameObject.velocity[0] * timeDelta;
			gameObject.y += gameObject.velocity[1] * timeDelta;		
		}
		
	}
	
}
