package scenes {
	
	// Import project stuff
	
	import components.*;
	import objects.Entity;
	
	public class Scene extends Entity 
	{

		public var isDone:Boolean;
		public var nextScene:Scene;
		
		public function Scene() 
		{
			super();
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
