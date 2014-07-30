package text {
	
	/* Import project stuff */
	import objects.Entity;
	
	/* Import starling */
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class LocationText extends Entity {


		private var text:TextField;
		
		public function LocationText() 
		{
			text = new TextField(200, 50, "white", 14, Color.WHITE);
			addChild(text);
		}

		
		public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			if (start)
			{
				ticker -= timeDelta;
				if (ticker <= 0)
					ticker = 0;
				text.text = "Death Timer: " + ticker;
			}
			
		}
		}
		
	}
	
}
