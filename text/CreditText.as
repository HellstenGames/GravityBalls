package text {
	
	/* Import project stuff */
	import objects.Entity;
	
	/* Import starling */
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class CreditText extends Entity {

		public function CreditText(width:int, height:int, text:String, font:String="Arial", 
								   fontSize:int=14, color:uint=Color.WHITE, bold:Boolean=false) {
			var tf:TextField = new TextField(width, height, text, font, fontSize, color, bold);
			addChild(tf);
		}

	}
	
}
