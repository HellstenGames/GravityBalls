package objects {
	import graphics.Line;
	import starling.utils.Color;
	
	public class Wall extends Entity 
	{

		private var _line:Line;
		
		public function Wall() 
		{
			super();	
			_line = new Line(0);
			_line.color = Color.RED;
			addChild(_line);
		}
		
		public function set(x2:Number, y2:Number):void
		{
			_line.lineTo(x2, y2);
		}

		public function set color(value:uint):void
		{
			_line.color = value;
		}
		public function get color():uint
		{
			return _line.color;
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}

	}
	
}
