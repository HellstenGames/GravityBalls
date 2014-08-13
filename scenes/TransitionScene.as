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

	public class TransitionScene extends Scene {

		/* Private Members */
		private var m_textLayer:Sprite;
		
		public static var SCROLL_SPEED:Number = 0.2;
		
		/* Layers */
		public var creditLayer:Sprite;
		
		// Objects/Sprites/Buttons
		public var playButton:PlayButton;
		public var exitButton:ExitButton;
		public var optionButton:OptionButton;
		public var startTitle:StartTitle;
		public var optionRollOut:OptionRollOut;
		
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
		
		public function TransitionScene() 
		{
			super();
			
			/* Set up layers */
			m_textLayer = new Sprite();
			addChild(m_textLayer);
			
			nextScene = new PlayScene();
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
