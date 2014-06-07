package objects {
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class BlackHole extends GameEntity {

		public function BlackHole(startx:Number, starty:Number) {
			super();
			
			var spriteClip:MovieClip = new MovieClip(Assets.mpAtlas.getTextures("blackhole"), 1);
			Starling.juggler.add(spriteClip);
			addChild(spriteClip);
			
			x = startx;
			y = starty;
		}

	}
	
}
