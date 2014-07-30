package text {
	
	/* Import project stuff */
	import objects.Entity;
	
	/* Import starling */
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class DeathTimer extends Entity {

		private var ticker:Number;
		private var textField:TextField;
		private var callBackFunc:Function;
		
		public var running:Boolean;
		public var paused:Boolean;
		public var stopped:Boolean;
		
		public function DeathTimer() 
		{
			super();
			textField = new TextField(200, 50, String(Constants.DT_MAX_TIME), "popup", 14, Color.RED);
			addChild(textField);
			visible = false; /* Keep invisible for now */
		}

		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			if (running&&!paused)
			{
				ticker -= timeDelta;
				if (ticker <= 0) {
					ticker = 0;
					/* Call back function */
					callBackFunc();					
					stopTimer();
				}
				textField.text = String(int(ticker));
			}
			
		}
		
		public function startTimer():void
		{
			running = true;
			stopped = false;
			visible = true;
			ticker = Constants.DT_MAX_TIME;
		}
		
		public function pauseTimer():void
		{
			paused = true;
		}
		public function resumeTimer():void
		{
			paused = false;
		}
		
		public function stopTimer():void
		{
			running = false;
			stopped = true;
			visible = false;
			resetTimer();
		}
		
		public function resetTimer():void
		{
			ticker = Constants.DT_MAX_TIME;
		}
		
		public function addOnStopEventListener(listener:Function):void
		{
			callBackFunc = listener;
		}
		
	}
	
}
