package objects {

	// Import project stuff
	import components.gbPhysicsComponent;
	import components.gbGraphicsComponent;	
	import components.gbInputComponent;
	import scenes.PlayScene;
	
	public class PlayButton extends MenuButton {

		public function PlayButton() 
		{
			super(new gbInputComponent(), new gbPhysicsComponent(), new gbGraphicsComponent());
			linkedScene = new PlayScene();
		}

		override public function update(timeDelta:Number):void 
		{
			super.update(timeDelta);
		}
		
		
	}
	
}
