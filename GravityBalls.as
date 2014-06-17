
package  
{
    import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import starling.core.Starling;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;
	
	import starling.events.ResizeEvent;
	
	public class GravityBalls extends Sprite {
        private static const STAGE_WIDTH:int = 480;
        private static const STAGE_HEIGHT:int = 320;
		private static const FRAME_RATE:int = 60;
		
		private var _starling:Starling;
		
		public function GravityBalls() {
			super();
			
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
		
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			stage.addEventListener(ResizeEvent.RESIZE, resizeStage);
			
			setupStarling();
		}
		

        private function setupStarling():void {
			Starling.multitouchEnabled = true;
			
			 // Get the preferred stage size based on our smallest target resolution
            var stageArea:Rectangle = new Rectangle(0, 0, STAGE_WIDTH, STAGE_HEIGHT);
            var fullscreenArea:Rectangle = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
            var viewport:Rectangle = RectangleUtil.fit(stageArea, fullscreenArea, ScaleMode.SHOW_ALL);
			
            _starling = new Starling(Game, stage, viewport);
            
			_starling.simulateMultitouch = true;
            _starling.showStats = true;
            _starling.antiAliasing = 1;
			
			_starling.stage.stageWidth = STAGE_WIDTH;
			_starling.stage.stageHeight = STAGE_HEIGHT;
			
			Starling.current.nativeStage.frameRate = FRAME_RATE;

            _starling.start();
        }

		private function resizeStage(e:Event):void
		{
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = stage.stageWidth;
			viewPortRectangle.height = stage.stageHeight;
			Starling.current.viewPort = viewPortRectangle;
		}

		
        private function deactivate(e:Event):void {
            NativeApplication.nativeApplication.exit();
        }
		
	}
	
}