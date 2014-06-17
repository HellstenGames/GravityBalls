package managers  {
	
	// Import project stuff
	import objects.Player;
	import scenes.PlayScene;
	import objects.Projectile;
	import objects.Collectible;
	
	// Import starling stuff
	import starling.display.Sprite;
	import starling.core.Starling;
	
	// Import flash stuff
	import flash.geom.Point;
	
	
	public class PlayerManager {

		private var _player:Player;
		private var _layer:Sprite;
		private var _scene:*;
		
		private var _leftBoundary:Number, _topBoundary:Number, _rightBoundary:Number, _bottomBoundary:Number;
		private var _originalPos:Point;
		
		public function PlayerManager(layer:Sprite, scene:*) 
		{
			_layer = layer;
			_scene = scene;
			
			_leftBoundary = _topBoundary = 0;
			_rightBoundary = Starling.current.stage.stageWidth;
			_bottomBoundary = Starling.current.stage.stageHeight;			
		}

		public function setPlayer(value:Player):void
		{
			_player = value;
			_layer.addChild(value);	
			// Set original positions
			_originalPos = new Point(_player.x, _player.y);
		}
		
		public function removePlayer():void
		{
			_layer.removeChild(_player);
		}
		
		public function setBoundary(leftBoundary:Number, topBoundary:Number, rightBoundary:Number, bottomBoundary:Number):void 
		{
			_leftBoundary = leftBoundary;
			_topBoundary = topBoundary;
			_rightBoundary = rightBoundary;
			_bottomBoundary = bottomBoundary;
		}
		
		public function update(timeDelta:Number):void 
		{
			_player.update(timeDelta);
			
			if (_player.released)
			{
				// Check if player is hitting boundaries
				if (Physics.isOutOfBounds(_player.x, _player.y, _player.width, _player.height, 
										  _leftBoundary, _topBoundary, _rightBoundary, _bottomBoundary))
				{
					resetPlayer();
					AssetResources.projectileCollisionSound.play();
					return;
				}
				
				// Apply gravity to player due to the suns
				var suns:Array = _scene.sunManager.suns;
				var slength:int = suns.length; 
				for (var s:int = slength - 1; s >= 0; --s)
				{
					// Apply Gravitaty to player
					var sComponents:Array = Physics.getGravityComponents(suns[s].x, suns[s].y, suns[s].width / 2, suns[s].mass,
																		 _player.x, _player.y, _player.height / 2, _player.mass);
					_player.velocity[0] += sComponents[0];
					_player.velocity[1] += sComponents[1];

					// Entity collides with sun
					if (Physics.circleDetection(suns[s].x, suns[s].y, suns[s].width / 2, 
												_player.x, _player.y, _player.height / 2))
					{
						resetPlayer();
						AssetResources.projectileCollisionSound.play();
						return;
					}
						
				}
				
				// Apply gravity to player due to black holes
				var blackHoles:Array = _scene.blackholeManager.blackHoles;
				var bhLength:int = blackHoles.length; 
				for (var bh:int = bhLength - 1; bh >= 0; --bh)
				{
					// Apply Gravitaty to player
					var bhComponents:Array = Physics.getGravityComponents(blackHoles[bh].x, blackHoles[bh].y, blackHoles[bh].width / 2, blackHoles[bh].mass,
																		 _player.x, _player.y, _player.height / 2, _player.mass);
					_player.velocity[0] += bhComponents[0];
					_player.velocity[1] += bhComponents[1];

					// Entity collides with black hole
					if (Physics.circleDetection(blackHoles[bh].x, blackHoles[bh].y, blackHoles[bh].width / 2, 
												_player.x, _player.y, _player.height / 2))
					{
						resetPlayer();
						AssetResources.blackHoleCollisionSound.play();
						_scene.nextLevel();
						return;
					}
						
				}
				
				
				// Check if player collides with points
				var collectibles:Array = _scene.collectibleManager.collectibles;
				var clength:int = collectibles.length; 
				for (var c:int = clength - 1; c >= 0; --c)
				{
					var collectible:Collectible = collectibles[c]; 
					if (Physics.circleDetection(collectible.x, collectible.y, collectible.width / 2, 
												_player.x, _player.y, _player.height / 2))
					{
						AssetResources.pointCollisionSound.play();
						_scene.collectibleManager.removeCollectible(c);
					}
				}
				
			}
		}
		
		private function resetPlayer():void
		{
			// Add to death counter
			_scene.deathCount ++;
			
			// Reset player
			_player.x = _originalPos.x;
			_player.y = _originalPos.y;
			_player.released = false;
			_player.velocity[0] = 0;
			_player.velocity[1] = 0;
			
			// Random color
			var rc:int = Math.random() * Projectile.COLORS.length;
			_player.color = Projectile.COLORS[rc];
		}
	}
	
}
