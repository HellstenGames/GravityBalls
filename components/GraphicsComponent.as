package components  {
	
	// Import starling stuff
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Image;
	
	public class GraphicsComponent 
	{
		protected var _scalingFactor:int;
		
		public function GraphicsComponent() 
		{
			_scalingFactor = Math.round(Starling.contentScaleFactor);
		}

		public function init(gameObject:*):void 
		{
		}
		
		public function update(gameObject:*):void
		{
		}
		
	}
	
}
