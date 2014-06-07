package objects  {
	import starling.display.Sprite;
	import starling.core.Starling;
	import flash.display.Stage;

	public class GameEntity extends Sprite {

		protected var _nativeStage:Stage;
		protected var _dx:Number, _dy:Number;
		protected var _ax:Number, _ay:Number;
		protected var _rotationSpeed:Number;
		protected var _entities:Array;
		
		public function GameEntity() {
			super();
			_nativeStage = Starling.current.nativeStage;
			_dx = _dy = 0;
			_ax = _ay = 0;
			_rotationSpeed = 0;
			
			_entities = [];
		}
		
		// ================================================================================================================================================
		// Methods
		// ================================================================================================================================================
		public function update(timeDelta:Number):void { 

			rotation += _rotationSpeed;
			_dx += _ax;
			_dy += _ay;
			x += _dx * timeDelta;
			y += _dy * timeDelta;						
			_ax = _ay = 0; // reset instant acceleration vector

			// Update entities			
			var entityLength:int = _entities.length;
			for (var e:int = entityLength - 1; e >= 0; --e)
			{
				_entities[e].update(timeDelta);
			}
			
		}
		
		public function addEntity(entity:GameEntity):void {
			_entities.push(entity);
			addChild(entity);
		}
		
		public function removeEntity(entity:GameEntity):void {
			_entities.splice(entity, 1);
			removeChild(entity);
		}
		
		public function stop():void 
		{
			_dx = _dy = 0;
		}
		
		// ================================================================================================================================================
		// Get/Set Properties
		// ================================================================================================================================================
		public function get dx():Number { 
			return _dx; 
		} 
		public function get dy():Number { 
			return _dy; 
		} 
		
		public function set dx(setValue:Number):void { 
			_dx = setValue;
		} 
		public function set dy(setValue:Number):void { 
			_dy = setValue; 
		} 
		
		public function get ax():Number { 
			return _ax; 
		} 
		public function get ay():Number { 
			return _ay; 
		} 
		
		public function set ax(setValue:Number):void { 
			_ax = setValue;
		} 
		public function set ay(setValue:Number):void { 
			_ay = setValue; 
		} 
	}
	
}
