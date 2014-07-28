package utils {
	
	/* Import project stuff */
	import scenes.CreditScene;
	import scenes.Scene;
	
	import text.HeadingText;
	import text.CreditText;
	import objects.Entity;
	
	/* Import starling stuff */
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.core.Starling;
	import flash.media.SoundChannel;
	import starling.display.Image;
	
	public class SceneLoader {

		/* Credit Constants */
		private static var kCreditTextWidth:int = 200;
		private static var kCreditTextHeight:int = 50;
		private static var kCreditTextColor:uint = Color.WHITE;
		private static var kCreditTextBold:Boolean = false;
		
		public static function loadScene(data:Object, scene:Scene):void
		{
			
			/* Load scene properties */
			if (data.properties)
			{
				
				var properties:Object = data.properties;
				scene.soundTheme = AssetResources.themes[properties.theme];
				scene.backgroundLayer.addChild(new Image(AssetResources.backgrounds[properties.background]));
				
			}
			
		}
		
		public static function loadCreditScene(data:Object):CreditScene
		{
			var cs:CreditScene = new CreditScene();
			loadScene(data, cs);
			
			if (data.credits)
			{
				
				/* Credit properties */
				var type:String, text:String;
				var creditText:CreditText, headingText:HeadingText;
				
				/* Grab credit properties: padding, font size, font type, etc. */
				var properties:Object = data.properties;
				cs.creditFont = properties.creditFont;
				cs.creditFontSize = properties.creditFontSize;
				cs.creditPadding = properties.creditPadding;
				
				cs.headingFont = properties.headingFont;
				cs.headingFontSize = properties.headingFontSize;
				cs.headingPadding = properties.headingPadding;
				
				cs.title = properties.title;
				cs.titleFont = properties.titleFont;
				cs.titleFontSize = properties.titleFontSize;
				cs.titlePadding = properties.titlePadding;
				
				cs.vScrollSpeed = properties.vScrollSpeed;
				cs.hScrollSpeed = properties.hScrollSpeed;
				cs.align = properties.align;
				cs.padding = properties.padding;
				
				/* Prepare to loop through credits */
				var yPosition:Number = cs.padding;
				
				var credits:Object = data.credits;
				var clength:int = credits.length;
				
				for (var i:int = 0; i < clength; ++i)
				{
					
					type = credits[i].type;
					text = credits[i].text;
					var padding:Number;
					
					var textObject:Entity;
					
					/* Get text object type */
					if (type == "heading")
					{
						textObject = headingText = new HeadingText(kCreditTextWidth, kCreditTextHeight, text, cs.headingFont,
													  cs.headingFontSize, kCreditTextColor, kCreditTextBold);
						padding = cs.headingPadding;
					}
					else if (type == "credit")
					{
						textObject = creditText = new CreditText(kCreditTextWidth, kCreditTextHeight, text, cs.creditFont, 
													cs.creditFontSize, kCreditTextColor, kCreditTextBold);
						padding = cs.creditPadding;
					}
					
					/* Position text object */
					if (cs.align == "center")
					{
						textObject.cx = Starling.current.stage.stageWidth / 2;
					}
					
					yPosition += padding; /* Padding before */
					textObject.cy = yPosition;
					//yPosition += padding; /* Padding after */
					
					cs.creditsLayer.addChild(textObject);
					

				}
				
			}
			
			return cs;
		}
		
	}
	
}
