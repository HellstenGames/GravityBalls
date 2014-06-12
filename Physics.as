package  {
	import objects.GameObject;
	import starling.display.DisplayObject;
	
	import starling.utils.rad2deg;
	
	public class Physics {

		public static var GRAVITY_CONSTANT:Number = 1;
		public static var GRAVITATIONAL_CONSTANT:Number = 6.67*10e-11;
		
		public static function calculateRadius(m1x:Number, m1y:Number, m2x:Number, m2y:Number):Number {
			return Math.sqrt((m1x - m2x) * (m1x - m2x) + (m1y - m2y) * (m1y - m2y));
		}
	
		public static function calculateGF(m1:Number, m2:Number, radius:Number):Number {
			if (radius == 0) return 0;
			return GRAVITY_CONSTANT * (m1*m2) / (radius*radius);
		}
		
		public static function calculateAcceleration(force:Number, mass:Number):Number {
			if (mass == 0) return 0;
			return force / mass;
		}

		public static function hComponent(component:Number, angle:Number):Number {
			return component * Math.cos(angle);
		}
		
		public static function vComponent(component:Number, angle:Number):Number {
			return component * Math.sin(angle);
		}
		
		// WARNING, THIS FUNCTION ASSUMES BOTH ENTITIES ARE CIRCLES, THUS WIDTH AND HEIGHT EQUALS THE DIAMETER
		public static function circleDetection(e1:GameObject, e2:GameObject):Boolean {
			var radius:Number = Physics.calculateRadius(e1.x + e1.width / 2, e1.y + e1.height / 2, 
														e2.x + e2.width / 2, e2.y + e2.height / 2);
			var totalDiameter:Number = e1.width / 2 + e2.width / 2;
			return (totalDiameter - radius >= 0) ? true : false;
		}
		
		public static function applyGravity(e1:GameObject, e2:GameObject, m1:Number, m2:Number):void {
			
			// Get radius
			var radius:Number = Physics.calculateRadius(e1.x+e1.width/2, e1.y+e1.height/2, 
														e2.x+e2.width/2, e2.y+e2.height/2);
			
			// Find the acceleration of the force
			var gf:Number = Physics.calculateGF(m1, m2, radius);
			var acceleration:Number = Physics.calculateAcceleration(gf, m2);
			var angle:Number = Math.atan2((e1.y + e1.height / 2) - (e2.y + e2.height / 2),
										  (e1.x + e1.width / 2) - (e2.x + e2.width / 2));
					

			e2.velocity[0] += Physics.hComponent(acceleration, angle);
			e2.velocity[1] += Physics.vComponent(acceleration, angle);

		}
		
		public static function isOutOfBounds(obj:DisplayObject, leftBound:Number, topBound:Number, rightBound:Number, bottomBound:Number) {
			return (obj.x < leftBound || obj.y < topBound || 
					obj.x + obj.width > rightBound || obj.y + obj.height > bottomBound) ? true : false;		
		}
		
	}
	
}
