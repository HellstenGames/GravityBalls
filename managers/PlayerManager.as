package managers  {
	
	// Import project stuff
	import objects.Player;
	import scenes.PlayScene;
	import objects.Projectile;
	import objects.Star;
	import objects.Asteroid;
	import objects.Wall;
	
	// Import starling stuff
	import starling.display.Sprite;
	import starling.core.Starling;
	import starling.animation.DelayedCall;
	
	// Import flash stuff
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import objects.Arrow;
	
	public class PlayerManager {

		public static var TRAIL_DELAY:Number = 0.1;
		public static var RESET_DELAY:Number = 0.5;
		
		private var _player:Player;
		private var _layer:Sprite;
		private var _scene:*;
		
		private var _leftBoundary:Number, _topBoundary:Number, _rightBoundary:Number, _bottomBoundary:Number;
		private var _originalPos:Point;

		private var _trailDelayCall:DelayedCall;
		private var _resetDelayCall:DelayedCall;
		
		public function PlayerManager(layer:Sprite, player, scene:*) 
		{
			_layer = layer;
			_scene = scene;
			_player = player;
			
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
			
			/* Set arrow */
			_scene.arrow = new Arrow(Arrow.ARROW_BLUE);
			_scene.arrow.visible = false;
			_layer.addChild(_scene.arrow);		
			
			// Set original positions
			_originalPos.x = _player.x;
			_originalPos.y = _player.y;
			_layer.addChild(_player);
			
			_followPlayer();
				
		}
		
		public function setBoundary(leftBoundary:Number, topBoundary:Number, rightBoundary:Number, bottomBoundary:Number):void 
		{
			_leftBoundary = leftBoundary;
			_topBoundary = topBoundary;
			_rightBoundary = rightBoundary;
			_bottomBoundary = bottomBoundary;
		}
		
		private function _followPlayer():void
		{
			/* Scene follows player */
			var layer:Sprite = _scene.playLayer;
			layer.x = Starling.current.stage.stageWidth - _player.cx - Starling.current.stage.stageWidth / 2;
			layer.y = Starling.current.stage.stageHeight - _player.cy - Starling.current.stage.stageHeight / 2;
			_scene.keepMapInBoundary(layer);		
		}
		
		private function _updateDeathTimer():void
		{
			
			/* Make sure death timer is running */		
			if (!_scene.deathTimer.running) {
				_scene.deathTimer.startTimer();
				/* Kill player if timer runs out */
				_scene.deathTimer.addOnStopEventListener(killPlayer);
			}
			
			/* Keep death timer on player */
			_scene.deathTimer.cx = _player.cx + Constants.PS_DT_OFFSETX + _scene.playLayer.x;
			_scene.deathTimer.cy = _player.cy + Constants.PS_DT_OFFSETY + _scene.playLayer.y;

		}

		public function update(timeDelta:Number):void 
		{
			if (!_player.visible)
				return;
			
			_player.update(timeDelta);
			
			if (_player.released)
			{
				/* Hide here text */
				_scene.hereText.hide();
				
				/* Focus on player if focus button is on */
				if (_scene.focusButton.focused)
					_followPlayer();
				
				/* Update things */
				_updateDeathTimer();
				
				
				// Poop trail
				if (!_trailDelayCall)
				{
					poopTrail();
				}
				
				/*
				// Check if player is hitting boundaries
				var wall:int = Physics.wallCollision(_player.x, _player.y, _player.width, _player.height, 
										  _leftBoundary, _topBoundary, _rightBoundary, _bottomBoundary);
				if (wall == Physics.DIR_LEFT)
				{
					_player.x = 0;
					_player.dx *= -1;
					trace("left");
				}
				else if (wall == Physics.DIR_TOP)
				{
					_player.y = 0;
					_player.dy *= -1;
					trace("top");
				}
				else if (wall == Physics.DIR_RIGHT)
				{
					_player.x = _rightBoundary - _player.width;
					_player.dx *= -1;
					trace("right");
				}
				else if (wall == Physics.DIR_BOTTOM)
				{
					_player.y = _bottomBoundary - _player.height;
					_player.dy *= -1;
					trace("bottom");
				}*/

				if (Physics.isOutOfBounds(_player.x, _player.y, _player.width, _player.height, 
										  _leftBoundary, _topBoundary, _rightBoundary, _bottomBoundary))
				{
					removeTrail();
					killPlayer();
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
						killPlayer();
						AssetResources.projectileCollisionSound.play();
						return;
					}
						
				}
				
				// Apply gravity to player due to black holes
				/*
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
				*/
				
				// Check if player collides with points
				var stars:Array = _scene.starManager.stars;
				var clength:int = stars.length; 
				if (clength == 0)
				{
					
					/* Stop Timer */
					_scene.deathTimer.stopTimer();
					
					AssetResources.blackHoleCollisionSound.play();
					_player.visible = false;					
					removeTrail();
					_scene.fadeOut();
					return;
				}
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
				
				// Check if player collides with asteroids
				var asteroids:Array = _scene.asteroidManager.asteroids;
				var alength:int = asteroids.length; 
				for (var a:int = alength - 1; a >= 0; --a)
				{
					var asteroid:Asteroid = asteroids[a]; 
					var origRotation:Number = asteroid.rotation;
					asteroid.rotation = 0;					
					if (Physics.circleDetection(asteroid.x, asteroid.y, asteroid.width / 2, 
												_player.x, _player.y, _player.height / 2))
					{
						// Get random sun death message
						var radm:int = Math.random() * Constants.DEATH_ASTEROID_MESSAGES.length;
						_scene.textManager.addPopupText(_player.cx, _player.cy, Constants.DEATH_ASTEROID_MESSAGES[radm]);
						killPlayer();
						AssetResources.projectileCollisionSound.play();
					}
					asteroid.rotation = origRotation;
				}
				
				// Check if player collides with walls
				var walls:Array = _scene.wallManager.walls;
				var wlength:int = walls.length; 
				for (var w:int = wlength - 1; w >= 0; --w)
				{
					var wall:Wall = walls[w]; 	
					
					// Rectangle collision check
					var bounds1:Rectangle = wall.bounds;
					var bounds2:Rectangle = _player.bounds;

					if (bounds1.intersects(bounds2))
					{
						if (wall.height == 1)
						{
							_player.dy *= -1;
						}
						else if (wall.width == 1)
						{
							_player.dx *= -1;
						}
						AssetResources.projectileCollisionSound.play();
						_scene.textManager.addPopupText(_player.cx, _player.cy, Constants.spitRandomMessage(Constants.WALL_MESSAGES));
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
			/* Randomize color */
			var rci:int = Math.random() * Projectile.COLORS.length;
			_player.color = Projectile.COLORS[rci];
		
			_followPlayer();
			/* Stop Timer */
			_scene.deathTimer.stopTimer();
			/* Shode here text */
			_scene.hereText.show();			
		}
		
		public function killPlayer():void
		{	
			/* Delay player kill delay */
			if (!_resetDelayCall)
			{
				
				/* Stop Timer */
				_scene.deathTimer.stopTimer();
				
				removeTrail();
				_player.visible = false;
				_scene.deathCounter.deaths ++;
				// Change arrow color
				_scene.arrow.changeImage(Projectile.COLORS.indexOf(_player.color));			
				_resetDelayCall = new DelayedCall(_resetDelay, RESET_DELAY);
				_resetDelayCall.repeatCount = 1;
				Starling.juggler.add(_resetDelayCall);	
			}
		}
		
		private function _resetDelay():void
		{
			resetPlayer();
			_resetDelayCall = null;
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
