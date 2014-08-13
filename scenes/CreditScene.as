package scenes {
	
	// Starling stuff
	import starling.display.Sprite;
	import starling.core.Starling;
	
	// Objects
	import objects.StartBackground;
	import objects.Projectile;
	import objects.Sun;
	import objects.StartTitle;
	import objects.OptionRollOut;
	
	// Managers
	import managers.ProjectileManager;
	import managers.SunManager;
	
	// Buttons
	import buttons.PlayButton;
	import buttons.ExitButton;
	import buttons.OptionButton;
	import text.CreditText;
	import flash.geom.Point;
	import flash.media.SoundTransform;
	import buttons.BackButton;

	public class CreditScene extends Scene {

		public static var MAX_PROJECTILES:int = 16;
		public static var MAX_SUNS:int = 2;
		public static var MAX_SHOOT:Number = 30;
		public static var MIN_SHOOT:Number = 25;
		public static var OUT_OF_BOUNDS:Number = 100;
		public static var SPAWN_BOUNDARY:Number = 25;
		
		public static var SCROLL_SPEED:Number = 0.2;
		
		// Layers
		public var creditLayer:Sprite;
		public var m_buttonsLayer:Sprite;
		
		// Objects/Sprites/Buttons
		public var playButton:PlayButton;
		public var exitButton:ExitButton;
		public var optionButton:OptionButton;
		public var startTitle:StartTitle;
		public var optionRollOut:OptionRollOut;
		public var m_backButton:BackButton;
		
		// Managers
		public var projectileManager:ProjectileManager;
		public var sunManager:SunManager;

		// Layers
		public var creditsLayer:Sprite;
		
		/* Properties */

		public var vScrollSpeed:Number, hScrollSpeed:Number;
		
		public var creditFont:String;
		public var creditFontSize:int;
		public var creditPadding:Number;
		
		public var headingFont:String;
		public var headingFontSize:int;
		public var headingPadding:int;
		
		public var title:String;
		public var titleFont:String;
		public var titleFontSize:int;
		public var titlePadding:Number;
		
		public var align:String;
		public var padding:Number;
		
		public function CreditScene() 
		{
			super();
			
			/* Set up layers */
			m_buttonsLayer = new Sprite();
			m_buttonsLayer.x = Constants.k_BackButtonX;
			m_buttonsLayer.y = Constants.k_BackButtonY;
			addChild(m_buttonsLayer);
			
			/* Set up back button */
			m_backButton = new BackButton(this, new SplashScene());
			m_buttonsLayer.addChild(m_backButton);
			
			/* Add layers */
			creditsLayer = new Sprite();
			addChild(creditsLayer);
			
			nextScene = new MenuScene();
		}

		override public function init():void
		{		
			super.init();
			
			// Play start theme
			themeChannel = soundTheme.play();
			themeChannel.soundTransform = new SoundTransform();
			
		}
		
		override public function update(timeDelta:Number):void 
		{ 
			super.update(timeDelta);
			creditsLayer.y += vScrollSpeed;
			creditsLayer.x += hScrollSpeed;
		}
		
		override public function destroy():void
		{
			super.destroy();
			themeChannel.stop();
		}
		
		
	}
	
}
