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
		
		override public function update(gameObject:*, timeDelta:Number):void
		{
			super.update(gameObject, timeDelta);
		}
		
	}
	
}
