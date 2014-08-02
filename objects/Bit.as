package objects {
	
	/* Import starling stuff */
	import starling.utils.Color;
	
	/* Import project stuff */
	import graphics.Rectangle;
	
	public class Bit extends Entity {

		private var _body:Rectangle;
		public var mass:Number;
		
		public function Bit() 
		{
			_body = new Rectangle(0, 0, Constants.kBitSize, Constants.kBitSize, Color.WHITE);
			mass = Constants.kBitMass;
			addChild(_body);
		}
		
		public function set color(value:uint):void
		{
			_body.color = value;
		}
		
	}
	
}
