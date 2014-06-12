package objects {
	
	// Import project stuff
	import components.InputComponent;
	import components.GraphicsComponent;	
	import components.PhysicsComponent;
	import scenes.Scene;
	
	public class MenuButton extends GameObject {

		public var linkedScene:Scene;
		
		public function MenuButton(input:InputComponent, physics:PhysicsComponent, graphics:GraphicsComponent) 
		{
			super(input, physics, graphics);
		}

	}
	
}
