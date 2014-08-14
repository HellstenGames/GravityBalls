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
		
		private var m_text:TextField;
		private var m_seconds_ticker:int;
		
		public function DeathTimer() 
		{
			super();
			m_text = new TextField(200, 50, String(Constants.k_DeathTimerMaxTime), "Arial", Constants.k_DeathTimerNormalFontSize, Constants.k_DeathTimerColor);
			addChild(m_text);
			visible = false; /* Keep invisible for now */
		}

		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			if (running&&!paused)
			{
				ticker -= timeDelta;
				

				/* indicate to player that time is running out! */
				if (int(ticker) <= Constants.k_DeathTimerDangerLimit)
				{
					m_text.color = Constants.k_DeathTimerDangerColor;
					m_text.fontSize = ticker % 1.0 * (Constants.k_DeathTimerMaxDangerFontSize - Constants.k_DeathTimerMinDangerFontSize) + Constants.k_DeathTimerMinDangerFontSize;
					
					if (ticker < m_seconds_ticker && m_seconds_ticker != 0)
					{
						m_seconds_ticker = int(ticker);
						AssetResources.sounds["countdown"].play();
					}
					
				}
				
				if (ticker <= 0) {
					ticker = 0;
					/* Call back function */
					callBackFunc();					
					stopTimer();
				}
				m_text.text = String(int(ticker));
			}
			
		}
		
		public function startTimer():void
		{
			running = true;
			stopped = false;
			visible = true;
			m_seconds_ticker = ticker = Constants.k_DeathTimerMaxTime;
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
			m_seconds_ticker = ticker = Constants.DT_MAX_TIME;
			m_text.color = Constants.k_DeathTimerColor;
			m_text.fontSize = Constants.k_DeathTimerNormalFontSize;
		}
		
		public function addOnStopEventListener(listener:Function):void
		{
			callBackFunc = listener;
		}
		
	}
	
}
