package components  {

	public class PhysicsComponent extends Component
	{

		private var _velocity:Array;
		private var _x:Number, _y:Number;
		private var _rotation:Number;
		private var _rotationSpeed:Number;

		public function PhysicsComponent(x:Number=0.0, y:Number=0.0, dx:Number=0.0, dy:Number=0.0, rotation:Number=0.0) 
		{
			_velocity = new Array(dx, dy);
			_x = x;
			_y = y;
			_rotation = rotation;
			_rotationSpeed = 0;
		}
		
		override public function init(entity:*):void
		{
			entity.x = _x;
			entity.y = _y;
		}
		
		override public function changed(entity:*):void
		{					
		}
		
		override public function update(entity:*):void
		{
			_rotation += _rotationSpeed;
			_x += _velocity[0];
			_y += _velocity[1];	
			entity.x = _x;
			entity.y = _y;		
		}
		
		public function set dx(value:Number):void
		{
			_velocity[0] = value;
		}
		public function set dy(value:Number):void
		{
			_velocity[1] = value;
		}
		public function get dx():Number
		{
			return _velocity[0];
		}
		public function get dy():Number
		{
			return _velocity[1];
		}
		
		public function set x(value:Number):void
		{
			_x = value;
		}
		public function set y(value:Number):void
		{
			_y = value;
		}
		public function get x():Number
		{
			return _x;
		}
		public function get y():Number
		{
			return _y;
		}
		
		public function get rotation():Number
		{
			return _rotation;
		}
		public function set rotation(value:Number):void
		{
			_rotation = value;
		}
		
		public function get rotationSpeed():Number
		{
			return _rotationSpeed;
		}
		public function set rotationSpeed(value:Number):void
		{
			_rotationSpeed = value;
		}
	
	}
	
}
