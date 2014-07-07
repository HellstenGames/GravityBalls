package objects {
	
	// Import buttons
	import buttons.ContractButton;
	import buttons.ExpandButton;
	
	// Import graphic stuff
	import graphics.Rectangle;
	import graphics.Line;
	
	// Import starling stuff
	import starling.core.Starling;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.events.Touch;
	
	public class SandboxMenu extends Entity {
		
		public static var CONTRACT_ACCELERATION:Number = 5.0;
		public static var WIDTH:Number = 150;
		
		private var _contractButton:ContractButton;
		private var _expandButton:ExpandButton;
		private var _backboard:Rectangle;
		private var _backboardLine:Line;
		
		private var _contract:Boolean;
		private var _expand:Boolean;
		
		public function SandboxMenu() 
		{
			// Set up backboard
			_backboard = new Rectangle(0, 0, WIDTH, Starling.current.nativeStage.stageHeight);
			_backboard.color = 0x0E4270;
			addChild(_backboard);
			_backboardLine = new Line(WIDTH, 0, WIDTH, Starling.current.nativeStage.stageHeight);
			_backboardLine.color = 0x07253F;
			_backboardLine.thickness = 2;
			addChild(_backboardLine);
			
			// Set up contract button
			_contractButton = new ContractButton();
			_contractButton.cx = _backboard.width;
			_contractButton.cy = Starling.current.nativeStage.stageHeight / 2;
			addEntity(_contractButton);
			// Set up expand button
			_expandButton = new ExpandButton();
			_expandButton.cx = _backboard.width;
			_expandButton.cy = Starling.current.nativeStage.stageHeight / 2;
			_expandButton.visible = false;
			addEntity(_expandButton);
			
			// Touch event for buttons
			_contractButton.addEventListener(TouchEvent.TOUCH, _onContractTouch);
			_expandButton.addEventListener(TouchEvent.TOUCH, _onExpandTouch);
			
			// Set other variables
			_contract = false;
			_expand = false;
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			if (_contract)
			{
				
				if (x + width > _contractButton.width) 
				{ 
					dx -= CONTRACT_ACCELERATION;
				}
				else
				{
					x = _contractButton.width - width;
					dx = 0;
					_contract = false; 
					_expandButton.visible = true;
					_contractButton.visible = false;
				}
				
			}
			
			if (_expand)
			{
				if (x < 0) 
				{ 
					dx += CONTRACT_ACCELERATION;
				}
				else
				{
					dx = 0;
					_expand = false; 
					_expandButton.visible = false;
					_contractButton.visible = true;					
				}
			}
			
		}
		
		private function _onContractTouch(event:TouchEvent):void
		{
			var touchEnd:Touch = event.getTouch(this, TouchPhase.ENDED);
			if (touchEnd)
			{
				_contract = true;
			}
		}

		private function _onExpandTouch(event:TouchEvent):void
		{
			var touchEnd:Touch = event.getTouch(this, TouchPhase.ENDED);
			if (touchEnd)
			{
				_expand = true;
			}
		}
		
	}
	
}
