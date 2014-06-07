package  {

	// Import starling stuff
	import starling.core.Starling;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	// Import flash stuff
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.text.engine.TextBaseline;

	public class Assets {
		
		[Embed(source="assets/sfx/splashtheme.mp3")]
		public static var splashTheme:Class;
		public static var splashSound:Sound;
		  
		[Embed(source="assets/sfx/menutheme.mp3")]
		public static var menuTheme:Class;
		public static var menuSound:Sound;
		
		[Embed(source="assets/sfx/playtheme.mp3")]
		public static var playTheme:Class;
		public static var playSound:Sound;
		
		[Embed(source="assets/sfx/projectile_collision.mp3")]
		public static var projectileCollisionTheme:Class;
		public static var projectileCollisionSound:Sound;
		
		[Embed(source="assets/sfx/sun_collision.mp3")]
		public static var sunCollisionTheme:Class;
		public static var sunCollisionSound:Sound;
		
		[Embed(source="assets/sfx/black_hole_collision.mp3")]
		public static var blackHoleCollisionTheme:Class;
		public static var blackHoleCollisionSound:Sound;
		
		[Embed(source="assets/gfx/atlas.png")]
		private static var atlasBitmap:Class;
		public static var mpAtlas:TextureAtlas;
		
		[Embed(source="assets/gfx/atlas.xml", mimeType="application/octet-stream")]
		private static var atlasXML:Class;

		[Embed(source="assets/gfx/atlas_menu.png")]
		private static var atlasMenuBitmap:Class;
		public static var mpAtlasMenu:TextureAtlas;
		
		[Embed(source="assets/gfx/atlas_menu.xml", mimeType="application/octet-stream")]
		private static var atlasMenuXML:Class;
		
		// Splash Screen 
        [Embed(source="assets/x3/splashscreen.png")]
        private static const splashscreen3x:Class
		public static var splashscreen3xTexture:Texture;
        [Embed(source="assets/x2/splashscreen.png")]
        private static const splashscreen2x:Class
		public static var splashscreen2xTexture:Texture;
        [Embed(source="assets/x1/splashscreen.png")]
        private static const splashscreen1x:Class
		public static var splashscreen1xTexture:Texture;
		
		// Background Image
        [Embed(source="assets/x3/nebula_x3.png")]
        private static const background3x:Class
		public static var background3xTexture:Texture;
        [Embed(source="assets/x1/background_x1.png")]
        private static const background2x:Class
		public static var background2xTexture:Texture;
        [Embed(source="assets/x1/background_x1.png")]
        private static const background1x:Class
		public static var background1xTexture:Texture;
		
		// Blue Projectile 
        [Embed(source="assets/x1/blue_projectile.png")]
        private static const blueprojectile1x:Class
		public static var blueprojectile1xTexture:Texture;
        [Embed(source="assets/x2/blue_projectile_x2.png")]
        private static const blueprojectile2x:Class
		public static var blueprojectile2xTexture:Texture;
        [Embed(source="assets/x3/blue_projectile_x3.png")]
        private static const blueprojectile3x:Class
		public static var blueprojectile3xTexture:Texture;
		
		// Green Projectile 
        [Embed(source="assets/x1/green_projectile.png")]
        private static const greenprojectile1x:Class
		public static var greenprojectile1xTexture:Texture;
        [Embed(source="assets/x2/green_projectile_x2.png")]
        private static const greenprojectile2x:Class
		public static var greenprojectile2xTexture:Texture;
        [Embed(source="assets/x3/green_projectile_x3.png")]
        private static const greenprojectile3x:Class
		public static var greenprojectile3xTexture:Texture;
		
		// Red Projectile 
        [Embed(source="assets/x1/red_projectile.png")]
        private static const redprojectile1x:Class
		public static var redprojectile1xTexture:Texture;
        [Embed(source="assets/x2/red_projectile_x2.png")]
        private static const redprojectile2x:Class
		public static var redprojectile2xTexture:Texture;
        [Embed(source="assets/x3/red_projectile_x3.png")]
        private static const redprojectile3x:Class
		public static var redprojectile3xTexture:Texture;
		
		// Sun
        [Embed(source="assets/x1/sun_x1.png")]
        private static const sun1x:Class
		public static var sun1xTexture:Texture;
        [Embed(source="assets/x2/sun_x2.png")]
        private static const sun2x:Class
		public static var sun2xTexture:Texture;
        [Embed(source="assets/x3/sun_x3.png")]
        private static const sun3x:Class
		public static var sun3xTexture:Texture;

        [Embed(source="assets/gfx/contract_button.png")]
        private static const contractButton:Class
		public static var contractButtonTexture:Texture;
		
        [Embed(source="assets/gfx/reset_button.png")]
        private static const resetButton:Class
		public static var resetButtonTexture:Texture;


		public static function init():void {
			




			var scalingFactor:int = Math.round(Starling.contentScaleFactor);
			mpAtlas = new TextureAtlas(Texture.fromBitmap(new atlasBitmap(), true, false, scalingFactor), XML(new atlasXML()));
			mpAtlasMenu = new TextureAtlas(Texture.fromBitmap(new atlasMenuBitmap(), true, false, scalingFactor), XML(new atlasMenuXML()));
			
			// Load SFX Assets
			splashSound = new splashTheme();
			splashSound.play(0,0, new SoundTransform(0));
		
			menuSound = new menuTheme();
			menuSound.play(0,0, new SoundTransform(0));
			
			playSound = new playTheme();
			playSound.play(0,0, new SoundTransform(0));
			
			projectileCollisionSound = new projectileCollisionTheme();
			projectileCollisionSound.play(0,0, new SoundTransform(0));
			
			sunCollisionSound = new sunCollisionTheme();
			sunCollisionSound.play(0,0, new SoundTransform(0));
			
			blackHoleCollisionSound = new blackHoleCollisionTheme();
			blackHoleCollisionSound.play(0,0, new SoundTransform(0));
			
			// Load Splash Screen Textures
			splashscreen3xTexture = Texture.fromBitmap(new splashscreen3x(), true, false, 3);
			splashscreen2xTexture = Texture.fromBitmap(new splashscreen2x(), true, false, 2);
			splashscreen1xTexture = Texture.fromBitmap(new splashscreen1x(), true, false, 1);
			
			// Background Textures
			background3xTexture = Texture.fromBitmap(new background3x(), true, false, 3);
			background2xTexture = Texture.fromBitmap(new background2x(), true, false, 2);
			background1xTexture = Texture.fromBitmap(new background1x(), true, false, 1);
			
			// Load Blue Projectile Textures
			blueprojectile3xTexture = Texture.fromBitmap(new blueprojectile3x(), true, false, 3);
			blueprojectile2xTexture = Texture.fromBitmap(new blueprojectile2x(), true, false, 2);
			blueprojectile1xTexture = Texture.fromBitmap(new blueprojectile1x(), true, false, 1);	
			
			// Load red Projectile Textures
			greenprojectile3xTexture = Texture.fromBitmap(new greenprojectile3x(), true, false, 3);
			greenprojectile2xTexture = Texture.fromBitmap(new greenprojectile2x(), true, false, 2);
			greenprojectile1xTexture = Texture.fromBitmap(new greenprojectile1x(), true, false, 1);		
			
			// Load green Projectile Textures
			redprojectile3xTexture = Texture.fromBitmap(new redprojectile3x(), true, false, 3);
			redprojectile2xTexture = Texture.fromBitmap(new redprojectile2x(), true, false, 2);
			redprojectile1xTexture = Texture.fromBitmap(new redprojectile1x(), true, false, 1);					
			
			// Load sun Textures
			sun3xTexture = Texture.fromBitmap(new sun3x(), true, false, 3);
			sun2xTexture = Texture.fromBitmap(new sun2x(), true, false, 2);
			sun1xTexture = Texture.fromBitmap(new sun1x(), true, false, 1);			

			
			contractButtonTexture = Texture.fromBitmap(new contractButton(), true, false, 3);
			resetButtonTexture = Texture.fromBitmap(new resetButton(), true, false, 3);
			
		}
		
	}
	
}
