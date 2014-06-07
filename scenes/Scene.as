package scenes {
	import starling.display.Sprite;
	
	public class Scene extends Sprite {

		public var isDone:Boolean;
		public var nextScene:Scene;
		
		public function Scene() {
			isDone = false;
			nextScene = null;
		}

		public function init():void { isDone = false; }
		public function destroy():void { isDone = true; }
		public function update(timeDelta:Number):void { }

		
	}
	
}
