package managers  {
	
	// Import project stuff
	import objects.Player;
	import scenes.PlayScene;
	import objects.Projectile;
	import objects.Star;
	
	// Import starling stuff
	import starling.display.Sprite;
	import starling.core.Starling;
	import starling.animation.DelayedCall;
	
	// Import flash stuff
	import flash.geom.Point;
	
	
	
	public class PlayerManager {

		public static var TRAIL_DELAY:Number = 0.1;
		
		
		private var _player:Player;
		private var _layer:Sprite;
		private var _scene:*;
		
		private var _leftBoundary:Number, _topBoundary:Number, _rightBoundary:Number, _bottomBoundary:Number;
		private var _originalPos:Point;

		private var _trailDelayCall:DelayedCall;
		
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
			_trailDelayCall = null;
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
			if (!_player.visible)
				return;
			
			_player.update(timeDelta);
			
			if (_player.released)
			{
				// Poop trail
				if (!_trailDelayCall)
				{
					poopTrail();
				}
				
				// Check if player is hitting boundaries
				if (Physics.isOutOfBounds(_player.x, _player.y, _player.width, _player.height, 
										  _leftBoundary, _topBoundary, _rightBoundary, _bottomBoundary))
				{
					removeTrail();
					resetPlayer();
					_scene.livesCounter.deductLife();
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
						removeTrail();
						
						// Get random sun death message
						var rsdm:int = Math.random() * Constants.DEATH_SUN_MESSAGES.length;
						_scene.textManager.addPopupText(_player.cx, _player.cy, Constants.DEATH_SUN_MESSAGES[rsdm]);
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
						removeTrail();
						
						// Get random win message
						var rwm:int = Math.random() * Constants.WIN_MESSAGES.length;
						_scene.textManager.addPopupText(_player.cx, _player.cy, Constants.WIN_MESSAGES[rwm]);
						AssetResources.blackHoleCollisionSound.play();
						
						_player.visible = false;
						
						_scene.fadeOut();
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
						_scene.textManager.addPopupText(star.cx, star.cy, String(Constants.STAR_SCORE));
					}
				}
				
			}
		}
		
	
		public function resetPlayer():void
		{
			// Reset player
			_player.x = _originalPos.x;
			_player.y = _originalPos.y;
			_player.released = false;
			_player.velocity[0] = 0;
			_player.velocity[1] = 0;
			_player.visible = true;
		}
		
		private function poopTrailDelay():void
		{
			_scene.trailManager.addTrail(_player.cx, _player.cy);
		}
		private function poopTrail():void
		{
			_trailDelayCall = new DelayedCall(poopTrailDelay, PlayerManager.TRAIL_DELAY);
			_trailDelayCall.repeatCount = 0;
			Starling.juggler.add(_trailDelayCall);	
		}
		private function removeTrail():void
		{
			Starling.juggler.remove(_trailDelayCall);	
			_trailDelayCall = null;
		}

	}
	
}
