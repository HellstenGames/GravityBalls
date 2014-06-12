package objects {

	// Import project stuff
	import components.gbPhysicsComponent;
	import components.gbGraphicsComponent;	
	import components.gbInputComponent;
	
	public class PlayButton extends GameObject {

		public function PlayButton() 
		{
			super(new gbInputComponent(), new gbPhysicsComponent(), new gbGraphicsComponent());
		}

		override public function update(timeDelta:Number):void 
		{
			super.update(timeDelta);
		}
		
		
	}
	
}
