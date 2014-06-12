package scenes {
	
	// Import project stuff
	import objects.GameObject;
	
	import components.*;
	
	public class Scene extends GameObject 
	{

		public var isDone:Boolean;
		public var nextScene:Scene;
		
		public function Scene(input:InputComponent, physics:PhysicsComponent, graphics:GraphicsComponent) 
		{
			super(input, physics, graphics);
			nextScene = this;
		}

		public function init():void
		{			
			isDone = false;
		}
		
		public function destroy():void
		{
			isDone = true;
		}
		
	}
	
}
