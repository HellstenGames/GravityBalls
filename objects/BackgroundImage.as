package objects {

	// Import project stuff
	import components.gbGraphicsComponent;
	
	public class BackgroundImage extends GameObject  {

		public function BackgroundImage() 
		{
			super(null, null, new gbGraphicsComponent());
		}
		
	}
	
}
