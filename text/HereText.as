package text {
	
	/* Import project stuff */
	import objects.Entity;
	import objects.Player;
	
	/* Import starling */
	import starling.text.TextField;
	import starling.utils.Color;

	
	public class HereText extends Entity {

		private var ticker:Number;
		private var textField:TextField;
		private var callBackFunc:Function;
		private var player:Player;
		private var scaling:Number;
		
		public var running:Boolean;
		public var stopped:Boolean;
		
		public function HereText(p:Player) 
		{
			player = p;
			textField = new TextField(Constants.HT_WIDTH, Constants.HT_HEIGHT, Constants.HT_TEXT, Constants.HT_FONTTYPE, Constants.HT_FONTSIZE, Color.RED);
			addChild(textField);
			visible = false; /* Keep invisible for now */
			scaling = Constants.HT_SCALE_SPEED;
		}

		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			if (running)
			{
				
				/* Position text */
				cx = player.cx + Constants.PS_HT_OFFSETX;
				cy = player.cy + Constants.PS_HT_OFFSETY;
				
				/* Scale text up and down for an effect */
				if (scaleX > Constants.HT_SCALE_MAX)
				{
					scaling = -Constants.HT_SCALE_SPEED;
					scaleX = scaleY = Constants.HT_SCALE_MAX;
				}
				else if (scaleX < Constants.HT_SCALE_MIN)
				{
					scaling = Constants.HT_SCALE_SPEED;
					scaleX = scaleY = Constants.HT_SCALE_MIN;
				}
				scaleX = scaleY += scaling;
				
			}
			
		}
		
		public function show():void
		{
			visible = true;
			running = true;
		}
		public function hide():void
		{
			visible = false;
			running = false;
		}
		
	}
	
}
