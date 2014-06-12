package objects {

	// Import project stuff
	import components.gbPhysicsComponent;
	import components.gbGraphicsComponent;	
	import components.gbInputComponent;
	
	public class ExitButton extends MenuButton {

		public function ExitButton() 
		{
			super(new gbInputComponent(), new gbPhysicsComponent(), new gbGraphicsComponent());
		}

		override public function update(timeDelta:Number):void 
		{
			super.update(timeDelta);
		}
		
		
	}
	
}
