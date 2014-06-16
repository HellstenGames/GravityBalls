package  {

	import starling.utils.rad2deg;
	
	public class Physics {

		public static var GRAVITY_CONSTANT:Number = 1;
		public static var GRAVITATIONAL_CONSTANT:Number = 6.67*10e-11;
		
		public static function calculateRadius(m1x:Number, m1y:Number, m2x:Number, m2y:Number):Number 
		{
			return Math.sqrt((m1x - m2x) * (m1x - m2x) + (m1y - m2y) * (m1y - m2y));
		}
	
		public static function calculateGF(m1:Number, m2:Number, radius:Number):Number 
		{
			if (radius == 0) return 0;
			return GRAVITY_CONSTANT * (m1*m2) / (radius*radius);
		}
		
		public static function calculateAcceleration(force:Number, mass:Number):Number 
		{
			if (mass == 0) return 0;
			return force / mass;
		}

		public static function hComponent(component:Number, angle:Number):Number 
		{
			return component * Math.cos(angle);
		}
		
		public static function vComponent(component:Number, angle:Number):Number 
		{
			return component * Math.sin(angle);
		}
		
		// WARNING, THIS FUNCTION ASSUMES BOTH ENTITIES ARE CIRCLES, THUS WIDTH AND HEIGHT EQUALS THE DIAMETER
		public static function circleDetection(e1x:Number, e1y:Number, e1radius:Number,
											   e2x:Number, e2y:Number, e2radius:Number):Boolean 
		{
			var radius:Number = Physics.calculateRadius(e1x + e1radius, e1y + e1radius, 
														e2x + e2radius, e2y + e2radius);
			var totalDiameter:Number = e1radius + e2radius;
			return (totalDiameter - radius >= 0) ? true : false;
		}
		
		public static function getGravityComponents(e1x:Number, e1y:Number, e1radius:Number, m1:Number, 
													e2x:Number, e2y:Number, e2radius:Number, m2:Number):Array 
		{
			// Get radius
			var radius:Number = Physics.calculateRadius(e1x + e1radius, e1y + e1radius, 
														e2x + e2radius, e2y + e2radius);
			
			// Find the acceleration of the force
			var gf:Number = Physics.calculateGF(m1, m2, radius);
			var acceleration:Number = Physics.calculateAcceleration(gf, m2);
			var angle:Number = Math.atan2((e1y + e1radius) - (e2y + e2radius),
										  (e1x + e1radius) - (e2x + e2radius));
					
			// Return acceleration due to gravity components
			return [Physics.hComponent(acceleration, angle), Physics.vComponent(acceleration, angle)];
		}
		
		public static function isOutOfBounds(objx:Number, objy:Number, objwidth:Number, objheight:Number, 
											 leftBound:Number, topBound:Number, rightBound:Number, bottomBound:Number) {
			return (objx < leftBound || objy < topBound || 
					objx + objwidth > rightBound || objy + objheight > bottomBound) ? true : false;		
		}
		
	}
	
}
