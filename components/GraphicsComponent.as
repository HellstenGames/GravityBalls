package components  {
	
	// Import starling stuff
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Image;
	import starling.textures.Texture;

	import starling.display.Sprite;
	import starling.utils.deg2rad;

	public class GraphicsComponent extends Component
	{
		
		private var _physics:PhysicsComponent;
		private var _input:InputComponent;
		
		protected var _sprite:Sprite;
		protected var _width:Number, _height:Number;
		
		public function GraphicsComponent(texture:Texture, physics:PhysicsComponent, input:InputComponent)
		{
			_physics = physics;
			_input = input;
			var image:Image = new Image(texture);
			
			_sprite = new Sprite();
			_sprite.addChild(image);
			alignPivot();	
			_sprite.rotation = deg2rad(_physics.rotation);

		}

		override public function init(entity:*):void
		{
			entity.addChild(_sprite);
			
			var origRotation:Number = entity.rotation;
			entity.rotation = 0;
			
			// Set dimensions before rotation screws it up!
			_width = entity.width;
			_height = entity.height;	

			// WHY DO YOU CAUSE ME SO MUCH TROUBLE!?
			entity.rotation = origRotation;	
		}
		
		override public function changed(entity:*):void
		{		
			var origRotation:Number = entity.rotation;
			entity.rotation = 0;
			
			// Set dimensions before rotation screws it up!
			_width = entity.width;
			_height = entity.height;	
			
			// WHY DO YOU CAUSE ME SO MUCH TROUBLE!?
			entity.rotation = origRotation;		
		}
		
		override public function update(entity:*):void
		{			
			// Set rotation last.
			_sprite.rotation = deg2rad(_physics.rotation); // render sprite based on physics rotation
		}
		
		public function add(texture:Texture, x:Number, y:Number):void
		{
			var image:Image = new Image(texture);
			image.x = x;
			image.y = y;
			_sprite.addChild(image);
		}
		
		private function alignPivot():void
		{
			_sprite.alignPivot();
			_sprite.x = _sprite.width / 2;
			_sprite.y = _sprite.height / 2;
		}
		
		
		public function get width():int 
		{
			return _width;
		}
		public function get height():int
		{
			return _height;
		}
		
	}
	
}
