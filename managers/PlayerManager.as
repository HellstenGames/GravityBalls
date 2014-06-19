﻿package managers  {
	
	// Import project stuff
	import objects.Player;
	import scenes.PlayScene;
	import objects.Projectile;
	import objects.Star;
	
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
		
		public function PlayerManager(layer:Sprite, player, scene:*) 
		{
			_layer = layer;
			_scene = scene;
			_player = player;
			_layer.addChild(_player);
			
			_originalPos = new Point(_player.x, _player.y);
			
			_leftBoundary = _topBoundary = 0;
			_rightBoundary = Starling.current.stage.stageWidth;
			_bottomBoundary = Starling.current.stage.stageHeight;			
		}

		public function setPlayer(cx:Number, cy:Number):void
		{
			// Position player
			_player.cx = cx;
			_player.cy = cy;
			// Set original positions
			_originalPos.x = _player.x;
			_originalPos.y = _player.y;
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
						_scene.livesCounter.deductLife();
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
				var stars:Array = _scene.starManager.stars;
				var clength:int = stars.length; 
				for (var c:int = clength - 1; c >= 0; --c)
				{
					var star:Star = stars[c]; 
					if (Physics.circleDetection(star.x, star.y, star.width / 2, 
												_player.x, _player.y, _player.height / 2))
					{
						AssetResources.pointCollisionSound.play();
						_scene.starManager.removeStar(c);
						_scene.scoreCounter += Constants.STAR_SCORE;
					}
				}
				
			}
		}
		
		private function resetPlayer():void
		{
			// Reset player
			_player.x = _originalPos.x;
			_player.y = _originalPos.y;
			_player.released = false;
			_player.velocity[0] = 0;
			_player.velocity[1] = 0;
		}
	}
	
}
