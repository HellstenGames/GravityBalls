package components {
	
	import flash.geom.Point;
	
	public class MBInputComponent extends InputComponent {

		public var isOnTop:Boolean;
		
		public function MBInputComponent() 
		{
			super();
		}

		override public function update(entity:*):void
		{
			super.update(entity);
			
			var point:Point = touches[0][0];
			
			trace(point, entity.width);
			isOnTop = (point.x >= 0 && point.y >= 0 && point.x <= entity.width && point.y <= entity.height) ? true : false;
		}
		
	}
	
}
