package objects 
{
	
	// Import starling stuff
	import starling.display.Sprite;
	
	// Import project stuff
	import components.Component;
	
	public class Entity extends Sprite 
	{

		public var componentList:Array;
		
		public function Entity()  
		{
			components = [];
		}
		
		public function addComponent(component:Component):void
		{
			componentList.push(component);
		}
		
		public function removeComponent(component:Component):void
		{
			componentList.splice(component);
		}
		
		public function update():void
		{
			var cll:int = componentList.length;
			for (var i:int = cll; i >= 0; --i)
			{
				componentList[cll].update();
			}
		}
		
	}
	
}
