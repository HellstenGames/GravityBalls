package screens {
	
	// Import starling stuff
	import starling.core.Starling;
	import starling.text.TextField;
	import starling.utils.Color;
	
	
	import objects.Background;
	import objects.Entity;
	import graphics.Rectangle;
	
	
	public class CreditScreen extends Entity {

		private var credits:Object;
		
		public function CreditScreen() 
		{
			_createBackground();
			_createCredits();
		}
		
		private function _createBackground():void
		{
			addChild(new Rectangle(0, 0, Starling.current.stage.stageWidth, Starling.current.stage.stageHeight));
		}
		
		private function _createCredits():void
		{
			credits = new Object();
			// Add headings
			_addHeading(credits, "Programmers", 100, 100);
			_addHeading(credits, "Level Designers", 200, 100);
			_addHeading(credits, "Game Play Designers", 300, 100);
			_addHeading(credits, "Musicians", 300, 200);
			// Add credits
			_addCredit(credits, "Programmers", "Justin Hellsten");
			_addCredit(credits, "Musicians", "Positively Dark");
			// Draw credits
			_drawCredits();
		}
		
		private function _addHeading(credits:Object, heading:String, locationX:int, locationY:int):void
		{
			credits[heading] = new Object();
			credits[heading].x = locationX;
			credits[heading].y = locationY;
			credits[heading].names = [];
		}
		
		private function _addCredit(credits:Object, heading:String, name:String):void
		{
			credits[heading].names.push(name);
		}

		private function _drawCredits():void
		{
			// Draw headings	
			for (var key:String in credits)
			{
				var tf:TextField = new TextField(100, 25, key, "Arial", 12, Color.RED);	
				tf.x = credits[key].x;
				tf.y = credits[key].y;
				addChild(tf);
			}
			/*
			for (var i:int = 0; i < credits["Programmers"].names.length; ++i)
			{
				var textField:TextField = 
					new TextField(100, 20, "text", "Arial", 12, Color.RED);				
			}
			*/
		}
		
	}
	
}
