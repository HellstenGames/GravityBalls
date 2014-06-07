package graphics {
	
	// Import project stuff
	import graphics.Line;
	
	// Import starling stuff
	import starling.utils.Color;	
	import starling.display.Quad;
	import starling.display.Sprite;
 
	public class Rectangle extends Sprite
	{
		private var baseQuad:Quad;
		private var _color:uint = 0x000000;
 
		public function Rectangle(x1:Number, y1:Number, width:Number, height:Number, color:uint=Color.BLACK)
		{
			_color = color;
			baseQuad = new Quad(width, height, _color);
			addChild(baseQuad);
			
			// Position Rectangle
			x = x1;
			y = y1;
			
		}
 
		public function set color(c:uint):void
		{
			baseQuad.color = _color = c;
		}
 
		public function get color():uint
		{
			return _color;
		}
	}
	
}
