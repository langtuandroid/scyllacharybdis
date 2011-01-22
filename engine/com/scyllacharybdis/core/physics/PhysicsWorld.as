package com.scyllacharybdis.core.physics 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.scyllacharybdis.core.objects.GameObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.casalib.math.geom.Point3d;
	/**
	 */
	[Singleton]
	[Requires ("com.scyllacharybdis.core.physics.PhysicsContactListener")]
	public final class PhysicsWorld extends BaseObject
	{

		private var _updateTimer:Timer = new Timer(1/30 * 1000, 0); 
		private var _world:b2World;
		private var _contactListener:PhysicsContactListener;
		
		// map pixels to meters ( 30 pixels = 1 meter );
		private var _drawScale:int = 30;
		
		private var _velocityIterations:int = 10;
		private var _positionIterations:int = 10;

		/**
		 * The engine contructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			super.engine_awake();
			
			// Allow bodies to sleep
			var doSleep:Boolean = true;
			
			// Define the gravity vector
			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
			
			// Construct a world object
			_world = new b2World(gravity, doSleep);

			// Create a contact listener
			_contactListener = new PhysicsContactListener();
			
			// Set the contact listener for the world
			_world.SetContactListener(_contactListener);	

			// setup the timer
			_updateTimer.addEventListener(TimerEvent.TIMER, engine_update);
			_updateTimer.start();
		
		}

		/**
		 * The engine start method
		 * @private
		 */
		public final override function engine_start():void
		{
			super.engine_start();

		}

		/**
		 * Update the physics model
		 * @param	event
		 * @private
		 */
		public final function engine_update(event:TimerEvent):void
		{
			_world.Step( 1 / 30, _velocityIterations, _positionIterations );
			
			var counter:int = 0;
			// Update all the game object positions
			for (var bb:b2Body = _world.GetBodyList(); bb; bb = bb.GetNext())
			{
				if (bb.GetUserData() is GameObject)
				{
					var gameObj:GameObject = bb.GetUserData() as GameObject;
					if ( gameObj == null ) {
						continue;
					}
					gameObj.position = new Point3d( bb.GetPosition().x * drawScale, bb.GetPosition().y * drawScale, gameObj.position.z );
					gameObj.rotation = bb.GetAngle() * (180/Math.PI);
					counter++;
				}
			}
		}	
		
		/**
		 * The engine stop function
		 * @private
		 */
		public final override function engine_stop():void
		{
			super.engine_stop();
		}		

		/**
		 * Destroy is called at the removal of the object
		 * @private
		 */
		public final override function engine_destroy():void
		{
			super.engine_destroy();
		}

		/**
		 * Get the world 
		 */
		public function get world():b2World { return _world; }
		
		/**
		 * Get the draw scale that maps pixels to meters.
		 */
		public function get drawScale():int { return _drawScale; }

		/**
		 * Set the draw scale that maps pixels to meters.
		 * @param scale (int) The number of pixels to make up a meter. Default = 30
		 */
		public function set drawScale(value:int):void 
		{
			_drawScale = value;
		}
		
		/**
		 * Set the world gravity
		 * @param gravity (beVec2) The gravity in a vector
		 */
		public function set gravity(value:b2Vec2):void 
		{
			_world.SetGravity(value);
		}

		/**
		 * Get Number of iterations before its finished trying to solve a collision
		 */
		public function get velocityIterations():int { return _velocityIterations; }
		
		/**
		 * Set Number of iterations before its finished trying to solve a collision
		 * The recommended number is 10
		 */
		public function set velocityIterations(value:int):void 
		{
			_velocityIterations = value;
		}
		
		/**
		 * Get Number of iterations before its finished trying to solve a collision
		 */
		public function get positionIterations():int { return _positionIterations; }
		
		/**
		 * Set Number of iterations before its finished trying to solve a collision
		 * The recommended number is 10
		 */
		public function set positionIterations(value:int):void 
		{
			_positionIterations = value;
		}
		
	}
}

