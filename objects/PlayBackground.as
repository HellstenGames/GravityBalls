package  {
	
	// Import project stuff
	import components.gbGraphicsComponent;
	import components.gbInputComponent;
	
	public class PlayBackground extends GameObject  {

		public function PlayBackground() 
		{
			super(null, new gbInputComponent(), new gbGraphicsComponent());
		}

	}
	
}
