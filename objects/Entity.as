package objects 
{
	
	// Import starling stuff
	import starling.display.Sprite;
	
	// Import project stuff
	import components.Component;
	
	public class Entity extends Sprite 
	{

		public var componentList:Array;
		public var entities:Array;
		
		public function Entity()  
		{
			componentList = [];
			entities = [];
		}
		
		public function addComponent(component:Component):void
		{
			component.init(this);
			componentList.push(component);
		}
		
		public function removeComponent(component:Component):void
		{
			componentList.splice(component);
		}
		
		public function addEntity(entity:Entity):void
		{
			addChild(entity);
			entities.push(entity);
			// Apply change to components
			var cll:int = componentList.length;
			for (var i:int = cll - 1; i >= 0; --i)
			{
				componentList[i].changed(this);
			}			
		}
		
		public function removeEntity(entity:Entity):void
		{
			removeChild(entity);
			entities.splice(entity);
		}
		
		public function update():void
		{
			// Update Components of this entity
			var cll:int = componentList.length;
			for (var i:int = cll - 1; i >= 0; --i)
			{
				componentList[i].update(this);
			}
			// Update entities inside this entity
			var el:int = entities.length;
			for (var e:int = el - 1; e >=0; --e)
			{
				entities[e].update();
			}
		}
		
	}
	
}
