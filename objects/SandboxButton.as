package objects {

	// Import project stuff
	import components.gbPhysicsComponent;
	import components.gbGraphicsComponent;	
	import components.gbInputComponent;
	import scenes.SandboxScene;
	
	public class SandboxButton extends MenuButton {

		public function SandboxButton() 
		{
			super(new gbInputComponent(), new gbPhysicsComponent(), new gbGraphicsComponent());
			linkedScene = new SandboxScene();
		}

		override public function update(timeDelta:Number):void 
		{
			super.update(timeDelta);
		}
		
		
	}
	
}
