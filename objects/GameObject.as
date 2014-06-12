package objects {
	
	// Import starling stuff
	import starling.display.Sprite;
	
	// Import project stuff
	import components.InputComponent;
	import components.PhysicsComponent;
	import components.GraphicsComponent;
	
	public class GameObject extends Sprite 
	{

		private var _input:InputComponent;
		private var _physics:PhysicsComponent;
		private var _graphics:GraphicsComponent;
		
		public var velocity:Array;

		public function GameObject(input:InputComponent, physics:PhysicsComponent, graphics:GraphicsComponent) 
		{
			_input = input;
			_physics = physics;
			_graphics = graphics;
			velocity = new Array(0, 0);
			
			if (_input != null) _input.init(this);
			if (_physics != null) _physics.init(this);
			if (_graphics != null) _graphics.init(this);
		}

		public function update(timeDelta:Number):void
		{
			if (_input != null) _input.update(this);
			if (_physics != null) _physics.update(this);
			if (_graphics != null) _graphics.update(this);
		}
		
	}
	
}
