package objects {

	// Import project stuff
	import components.gbPhysicsComponent;
	import components.gbGraphicsComponent;	
	import components.gbInputComponent;
	
	public class SandboxButton extends GameObject {

		public function SandboxButton() 
		{
			super(new gbInputComponent(), new gbPhysicsComponent(), new gbGraphicsComponent());
		}

		override public function update(timeDelta:Number):void 
		{
			super.update(timeDelta);
		}
		
		
	}
	
}
