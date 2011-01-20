package com.scyllacharybdis.physics 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import com.scyllacharybdis.graphics.scenegraph.SceneGraph;
	import com.scyllacharybdis.interfaces.IBaseComponent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.casalib.math.geom.Point3d;

	/**
	 */
	[Singleton]
	[Component type="PhysicsSceneComponent"]
	public final class PhysicsSceneComponent implements IBaseComponent
	{
		private var _world:b2World;
		private var _contactListener:PhysicsContactListener;
		private var _sceneGraph:SceneGraph;
		private var _drawScale:int = 30;
		
		// map pixels to meters ( 30 pixels = 1 meter );
		
		private var _velocityIterations:int = 10;
		private var _positionIterations:int = 10;
		private var _gravity:b2Vec2;
		private var _doSleep:Boolean;
		
		/**
		 * Constructor
		 */
		public function PhysicsSceneComponent()
		{
			// Allow bodies to sleep
			_doSleep = true;
			
			// Define the gravity vector
			_gravity = new b2Vec2(0.0, 10.0);
			
			// Create a contact listener
			_contactListener = new PhysicsContactListener();
			
			// Construct a world object
			_world = new b2World(_gravity, _doSleep);

			// Set the contact listener for the world
			_world.SetContactListener(_contactListener);				
		}

		/**
		 * The plugin create method
		 */
		public function awake(owner:*):void
		{
			// Store the scene graph
			_sceneGraph = owner;
		}

		/**
		 * Destructor
		 */
		public function destroy():void
		{
			_world = null;
			_contactListener = null;			
		}
		
		/**
		 * Plugin update
		 * @param	event
		 * @private
		 */
		public function update():void
		{
			_world.Step( 1 / 30, _velocityIterations, _positionIterations );
		
			/*
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
			*/
		}	

		/**
		 * Set the world gravity
		 * @param gravity (beVec2) The gravity in a vector
		 */
		public function set gravity(value:b2Vec2):void 
		{
			_gravity = value;
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
		
		public function get drawScale():int { return _drawScale; }
		
		public function set drawScale(value:int):void 
		{
			_drawScale = value;
		}
		
		public function get world():b2World { return _world; }
		
		public function set world(value:b2World):void 
		{
			_world = value;
		}
		
	}
}

