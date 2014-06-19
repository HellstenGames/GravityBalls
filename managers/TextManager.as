package managers 
{
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import utils.SpritePool;
	
	import objects.PopupText;
	
	public class TextManager {

		// Popup Score Texts List
		public var puTexts:Array;
		private var _puPool:SpritePool;
		private var _layer:Sprite;
		
		public function TextManager(layer:Sprite, puLength:int=10) 
		{
			_layer = layer;
			
			// Create sprite pools
			_puPool = new SpritePool(PopupText, puLength);
			puTexts = []
			
		}
		
		public function addPopupText(cx:Number, cy:Number, text:String):void
		{
			var p:PopupText = _puPool.getSprite() as PopupText;
			p.cx = cx;
			p.cy = cy;
			
			// Set original center points, prevent the scaling from looking off
			p.originalCX = p.cx;
			p.originalCY = p.cy;
				
			_layer.addChild(p);
			puTexts.push(p);
		}
		public function removePopupText(index:int):void
		{
			var p:PopupText = puTexts[index];
			puTexts.splice(index, 1);
			_layer.removeChild(p);
			_puPool.returnSprite(p);
		}
		
		public function removeAll():void 
		{
			var plength:int = puTexts.length; 
			for (var i:int = plength - 1; i >= 0; --i) 
			{
				_layer.removeChild(puTexts[i]);
				_puPool.returnSprite(puTexts[i]);
			}
			puTexts.splice(0);
		}
		
		public function update(timeDelta):void
		{
			var plength:int = puTexts.length; 
			for (var i:int = plength - 1; i >= 0; --i) 
			{
				puTexts[i].update(timeDelta);
			}
		}
		
	}
	
}
