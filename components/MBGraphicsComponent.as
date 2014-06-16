package components {
	
	import starling.textures.Texture;
	
	public class MBGraphicsComponent extends GraphicsComponent {

		private var _input:MBInputComponent;
		private var _physics:PhysicsComponent;
		
		public function MBGraphicsComponent(texture:Texture, physics:PhysicsComponent, input:MBInputComponent) 
		{
			super(texture, physics, input);
			_input = input;
			_physics = physics;
		}

		override public function update(entity:*):void
		{			

			// Set to zero because otherwise it screws positioning of sprite
			_sprite.rotation = 0;
			
			// Get center coordinates
			var cx:Number = _physics.x + entity.width / 2;
			var cy:Number = _physics.y + entity.height / 2;		
			
			if ((_input.isTouched || _input.isMoved) && _input.isOnTop)
			{						
				entity.scaleX = entity.scaleY = 1.25;					
			}
			else 
			{				
				entity.scaleX = entity.scaleY = 1;			
			}
			
			// Center sprite
			_physics.x = cx - entity.width / 2;
			_physics.y = cy - entity.height / 2;	
			
			// Super needs to be last in order for rotation to take affect
			super.update(entity);
		}
		
	}
	
}
