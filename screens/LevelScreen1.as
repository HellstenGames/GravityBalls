package screens {
	import objects.Entity;
	import buttons.MenuPick;
	
	public class LevelScreen1 extends Entity {

		public static var NUM_LEVELS:uint = 30;
		
		public function LevelScreen1() 
		{
			_addLevels();
		}

		private function _addLevels():void
		{
			for (var i:uint = NUM_LEVELS; i > 0; --i)
			{
				// Position level pick
				var menuPick:MenuPick = new MenuPick(i);
		
				addEntity(menuPick);
				menuPick.addEventListener(TouchEvent.TOUCH, _onLevelSelectTouch);
			}
		}
		
		private function _onLevelSelectTouch():void
		{
			
		}
		
	}
	
}
