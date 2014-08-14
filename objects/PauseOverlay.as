package objects {
	
	import graphics.Rectangle;
	import graphics.Line;
	
	public class PauseOverlay extends Entity {
		
		/* Private Members */
		private var m_rollout:Boolean;
		private var m_rollin:Boolean;
		private var m_backboard:Rectangle;
		private var m_border:Line;
		private var m_rollspeed:Number;
		
		public function PauseOverlay() 
		{

			/* Set backboard */
			m_backboard = new Rectangle(0, 0, Constants.k_PauseOverlayWidth, Constants.k_PauseOverlayHeight);
			m_backboard.color = Constants.k_PauseOverlayColor;
			m_backboard.alpha = Constants.k_PauseOverlayAlpha;
			addChild(m_backboard);
			m_border = new Line(Constants.k_PauseOverlayWidth, 0, Constants.k_PauseOverlayWidth, Constants.k_PauseOverlayHeight, 
								Constants.k_PauseOverlayLineColor, Constants.k_PauseOverlayLineThickness);
			m_border.alpha = Constants.k_PauseOverlayAlpha;
			addChild(m_border);
			
			/* Set position */
			x = Constants.k_PauseOverlayX;
			y = Constants.k_PauseOverlayY;
			alpha = Constants.k_PauseOverlayAlpha;
			
			m_rollspeed = Constants.k_PauseOverlayInitRollSpeed;
			m_rollout = m_rollin = false;
			
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);

			/* Roll overlay in or out */
			if (m_rollout)
			{
				m_rollspeed += Constants.k_PauseOverlayAcceleration;
				x += m_rollspeed;
				
				/* Stop rolling out if completly visible */
				if (x > 0)
				{
					m_rollout = false;
					m_rollspeed = 0;
					x = 0;
				}
				
			}
			
			if (m_rollin)
			{
				m_rollspeed -= Constants.k_PauseOverlayAcceleration;
				x += m_rollspeed;
				
				/* Stop rolling in if off screen */
				if (x < -m_backboard.width)
				{
					m_rollin = false;
					m_rollspeed = 0;
					x = -m_backboard.width;
				}
				
			}
			
		}
		
		public function RollOut():void
		{
			m_rollspeed = Constants.k_PauseOverlayInitRollSpeed;
			m_rollout = true;
			m_rollin = false;
		}

		public function RollIn():void
		{
			m_rollspeed = -Constants.k_PauseOverlayInitRollSpeed;
			m_rollout = false;
			m_rollin = true;
		}
		
	}
	
}
