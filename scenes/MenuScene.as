package scenes {
	
	// Import starling stuff
	import starling.core.Starling;
	import starling.events.TouchEvent;
	
	import objects.Entity;
	import components.GraphicsComponent;
	import components.PhysicsComponent;
	import components.InputComponent;
	import components.MBGraphicsComponent;
	import components.PBInputComponent;
	import components.MBInputComponent;
	
	public class MenuScene extends Scene {

		public var playButton:Entity, sandboxButton:Entity, exitButton:Entity;
		public var background:Entity;
		
		public function MenuScene() 
		{
			super();
		}

		override public function init():void
		{		
			super.init();
			
			// Add Background
			background = new Entity();
			var backgroundPC:PhysicsComponent = new PhysicsComponent();
			background.addComponent(new GraphicsComponent(AssetResources.backgroundTexture, backgroundPC, new InputComponent()));
			background.addComponent(backgroundPC);
			addChild(background);
			
			// Create button texts
			/* Play Button Text */
			var playButtonText:Entity = new Entity();
			var playButtonTextPC:PhysicsComponent = new PhysicsComponent(AssetResources.playBallTexture.width / 2 - AssetResources.playTextTexture.width / 2,
																		 AssetResources.playBallTexture.height / 2 - AssetResources.playTextTexture.height / 2);
			playButtonText.addComponent(new GraphicsComponent(AssetResources.playTextTexture, 
															  playButtonTextPC, 
														      new InputComponent));
			playButtonText.addComponent(playButtonTextPC);
			/* Sandbox Button Text */
			var sandboxButtonText:Entity = new Entity();
			var sandboxButtonTextPC:PhysicsComponent = new PhysicsComponent(AssetResources.sandboxBallTexture.width / 2 - AssetResources.sandboxTextTexture.width / 2,
																				   AssetResources.sandboxBallTexture.height / 2 - AssetResources.sandboxTextTexture.height / 2);
			sandboxButtonText.addComponent(new GraphicsComponent(AssetResources.sandboxTextTexture, 
																 sandboxButtonTextPC,
																 new InputComponent()));
			sandboxButtonText.addComponent(sandboxButtonTextPC);
			/* Exit Button Text */
			var exitButtonText:Entity = new Entity();
			var exitButtonTextPC:PhysicsComponent = new PhysicsComponent(AssetResources.exitBallTexture.width / 2 - AssetResources.exitTextTexture.width / 2,
																				   AssetResources.exitBallTexture.height / 2 - AssetResources.exitTextTexture.height / 2);
			exitButtonText.addComponent(new GraphicsComponent(AssetResources.exitTextTexture, 
														      exitButtonTextPC,
															  new InputComponent()));
			exitButtonText.addComponent(exitButtonTextPC);
			
			
			// Add Play Button
			playButton = new Entity();
			var playIC:MBInputComponent = new MBInputComponent();
			var playPC:PhysicsComponent = new PhysicsComponent(Starling.current.nativeStage.stageWidth / 2 - AssetResources.playBallTexture.width / 2 - 125,
														 Starling.current.nativeStage.stageHeight / 2 - AssetResources.playBallTexture.height / 2);
			playButton.addComponent(playPC);			
			playPC.rotationSpeed = 1;
			
			var playGC:GraphicsComponent = new MBGraphicsComponent(AssetResources.playBallTexture, playPC, playIC);
			playButton.addComponent(playGC);
			
			playButton.addEntity(playButtonText);
			
			playButton.addComponent(playIC);
			addChild(playButton);
			
			// Add Sandbox Button
			sandboxButton = new Entity();
			var sandboxIC:MBInputComponent = new MBInputComponent();
			var sandboxPC:PhysicsComponent = new PhysicsComponent(Starling.current.nativeStage.stageWidth / 2 - AssetResources.playBallTexture.width / 2,
														 Starling.current.nativeStage.stageHeight / 2 - AssetResources.playBallTexture.height / 2);
			sandboxButton.addComponent(sandboxPC);											 
			sandboxPC.rotationSpeed = 1;
			
			var sandboxGC:GraphicsComponent = new MBGraphicsComponent(AssetResources.sandboxBallTexture, sandboxPC, sandboxIC);
			sandboxButton.addComponent(sandboxGC);
											 
			sandboxButton.addEntity(sandboxButtonText);
			
			sandboxButton.addComponent(sandboxIC);
			addChild(sandboxButton);
			
			// Add Exit Button
			exitButton = new Entity();
			var exitIC:MBInputComponent = new MBInputComponent();
			var exitPC:PhysicsComponent = new PhysicsComponent(Starling.current.nativeStage.stageWidth / 2 - AssetResources.playBallTexture.width / 2 + 125,
														 Starling.current.nativeStage.stageHeight / 2 - AssetResources.playBallTexture.height / 2);
			exitButton.addComponent(exitPC);
			exitPC.rotationSpeed = 1;
			
			var exitGC:GraphicsComponent = new MBGraphicsComponent(AssetResources.exitBallTexture, exitPC, exitIC);
			exitButton.addComponent(exitGC);
			
			exitButton.addEntity(exitButtonText);
			
			exitButton.addComponent(exitIC);
			addChild(exitButton);			
		}
		
		override public function update():void 
		{ 
			super.update();
			
			playButton.update();
			sandboxButton.update();
			exitButton.update();
		}
		
	}
	
}
