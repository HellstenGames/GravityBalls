package scenes {
	
	// Import project stuff
	
	import components.*;
	import objects.Entity;
	
	/* Starling stuff */
	import starling.display.Sprite;
	
	// Flash stuff
	import flash.media.SoundChannel;
	import flash.media.Sound;
	
	
	public class Scene extends Entity 
	{

		public static var FADE_OUT_SPEED:Number = 0.015;
		public static var FADE_IN_SPEED:Number = 0.015;
		
		public var isDone:Boolean;
		public var nextScene:Scene;
		
		private var _fadeInOut:Boolean;
		public var fadedOut:Boolean;
		public var fadedIn:Boolean;
		
		public var themeChannel:SoundChannel;
		public var soundTheme:Sound;
		public var backgroundLayer:Sprite;
		
		public function Scene() 
		{
			super();
			
			backgroundLayer = new Sprite();
			addChild(backgroundLayer);
			
			nextScene = null;
			entities = [];
			_fadeInOut = false;
			alpha = 0;
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			// Fade in or out
			if (_fadeInOut)
			{
				alpha -= FADE_OUT_SPEED;
				if (alpha <= 0)
				{
					fadedOut = true;
					alpha = 0;
				}
			}
			else
			{
				alpha += FADE_IN_SPEED;
				if (alpha >= 1.0)
				{
					fadedIn = true;
					alpha = 1.0;
				}
			}
		}
		
		public function init():void
		{			
			isDone = false;
		}
		
		public function destroy():void
		{
			isDone = true;
		}
		
		public function fadeIn():void
		{
			_fadeInOut = false;
			fadedOut = false;
		}
		public function fadeOut():void
		{
			_fadeInOut = true;
			fadedIn = false;
		}
		
	}
	
}
