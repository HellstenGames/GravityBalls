package objects {
	import starling.display.Image;
	
	public class BlackHole extends Entity {
	
		public var mass:Number;
		
		public var originalCX:Number, originalCY:Number;
		
		public function BlackHole() 
		{
			super();

			mass = 5.0*10e+3;
			addChild(new Image(AssetResources.blackHoleTexture));
			
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}

	}
	
}
	