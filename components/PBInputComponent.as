package components  {
	
	public class PBInputComponent extends MBInputComponent {

		public function PBInputComponent() 
		{
			super();
		}

		override public function update(entity:*):void
		{
			super.update(entity);
			
			if (isOnTop)
			{
				trace("on top");
			} 
			else
			{
				trace("not on top");
			}
		}
		
	}
	
}
