package components {
	
	// Import project stuff
	import objects.GameObject;
	
	public class gbPhysicsComponent extends PhysicsComponent
	{

		public function gbPhysicsComponent() 
		{
			super();
		}

		override public function init(gameObject:*):void
		{
			super.init(gameObject);
		}
		
		override public function update(gameObject:*):void
		{
			if (gameObject is GameObject)
			{
				gameObject.x += gameObject.velocity[0];
				gameObject.y += gameObject.velocity[1];
			}
		}
		
	}
	
}
