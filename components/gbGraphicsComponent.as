package components {
	
	// Import starling stuff
	import starling.display.Image;
	
	// Import Project stuff
	import objects.*;
	import scenes.*;
	
	public class gbGraphicsComponent extends GraphicsComponent {

		public function gbGraphicsComponent() 
		{
			super();
		}

		override public function init(gameObject:*):void 
		{
			super.init(gameObject);
			if (gameObject is SplashImage)
			{
				gameObject.addChild(new Image(AssetResources.splashTexture));
			}
			else if (gameObject is BackgroundImage)
			{
				gameObject.addChild(new Image(AssetResources.backgroundTexture));
			}
			else if (gameObject is Projectile)
			{
				if (gameObject.color == "red")
				{
					gameObject.addChild(new Image(AssetResources.redProjectileTexture));
				}
				else if (gameObject.color == "green")
				{
					gameObject.addChild(new Image(AssetResources.greenProjectileTexture));
				}
				else
				{
					gameObject.addChild(new Image(AssetResources.blueProjectileTexture));
				}
			}
			else if (gameObject is Sun)
			{
				gameObject.addChild(new Image(AssetResources.sunTexture));
			}
			else if (gameObject is PlayButton)
			{
				gameObject.addChild(new Image(AssetResources.playBallTexture));
				
				var text:Image = new Image(AssetResources.playTextTexture);
				text.x = gameObject.width / 2 - text.width / 2;
				text.y = gameObject.height / 2 - text.height / 2;	
				gameObject.addChild(text);
				
			}
			else if (gameObject is SandboxButton)
			{
				gameObject.addChild(new Image(AssetResources.sandboxBallTexture));
				
				text = new Image(AssetResources.sandboxTextTexture);
				text.x = gameObject.width / 2 - text.width / 2;
				text.y = gameObject.height / 2 - text.height / 2;	
				gameObject.addChild(text);
			}
			else if (gameObject is ExitButton)
			{
				gameObject.addChild(new Image(AssetResources.exitBallTexture));
				
				text = new Image(AssetResources.exitTextTexture);
				text.x = gameObject.width / 2 - text.width / 2;
				text.y = gameObject.height / 2 - text.height / 2;	
				gameObject.addChild(text);
			}	

		}
		
		override public function update(gameObject:*):void
		{
		}
		
	}
	
}
