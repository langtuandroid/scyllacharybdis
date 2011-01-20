package com.scyllacharybdis.components 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import com.scyllacharybdis.graphics.scenegraph.SceneGraph;
	import com.scyllacharybdis.interfaces.IPhysicsComponent;
	import com.scyllacharybdis.physics.PhysicsSceneComponent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	/**
	 */
	public class CollisionComponent implements IPhysicsComponent
	{
		
		/****************************************/
		// Class Details
		/****************************************/
		private var _sceneGraph:SceneGraph;
		private var _body:b2Body;
		private var _physicsWorld:PhysicsSceneComponent;
		private var _owner:*;

		public function CollisionComponent( graph:SceneGraph ):void
		{
			_sceneGraph = graph;
			_physicsWorld = _sceneGraph.getComponent(PhysicsSceneComponent) as PhysicsSceneComponent;
		}
		
		public function awake( owner:* ):void
		{
			_owner = owner;
		}
		
		public function update():void
		{
		}
		
		public function destroy():void
		{
			_sceneGraph = null;
			_physicsWorld = null;
			_body = null;
			_owner = null;
		}

		/**
		 * Create the body of the object. The body is the whole object.
		 * @param	x (int) width in pixels
		 * @param	y (int) height in pixels
		 * @param dynamtic (Boolean) Is the object dynamtic
		 */
		public function createBody(x:int, y:int, dynamtic:Boolean):void
		{
			// Create the body definition
			var bodyDef:b2BodyDef = new b2BodyDef();
			
			if ( dynamtic == true ) 
			{
				// Set the object to be dynamic
				bodyDef.type = b2Body.b2_dynamicBody;
			}	
			
			// Get the world scale
			var scale:int = _physicsWorld.drawScale;

			//Set its position in the world. 
			bodyDef.position.Set(x / scale, y / scale);
			
			// Add the gameobject to it
			bodyDef.userData = _owner;

			// Create the body
			_body = _physicsWorld.world.CreateBody(bodyDef);

			// Add the game object to it.
			_body.SetUserData( _owner );
		}
		
		/**
		 * Create a polygon shape to represent all or part of the body
		 * @param	width (int) Width in pixels
		 * @param	height (int) Height in pixels
		 * @param	friction (Number) Friction amount from 0 to 1
		 * @param	density (Number) Desity amount ( set to 0 for static items )
		 * @param	restitution (Number) The bounciness of the object from 0 to 1
		 */
		public function createPolygonShape(width:int, height:int, friction:Number = 0.3, density:Number = 0, restitution:Number = 0.1):void
		{
			// Get the draw scale
			var scale:int = _physicsWorld.drawScale;

			// Create the shape
			var boxShape:b2PolygonShape = new b2PolygonShape();
			
			// Set as a box
			boxShape.SetAsBox(width / scale, height/scale);
			
			// Create the fixture
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxShape;
			fixtureDef.friction = friction;
			fixtureDef.density = density; 
			fixtureDef.restitution = restitution;

			// Add the game object to it
			fixtureDef.userData = _owner;

			// Attach to the body
			_body.CreateFixture(fixtureDef);	
		}
		
		/**
		 * Create a circle shape to represent all or part of the body
		 * @param	radius (int) Radius of the circle in pixels
		 * @param	friction (Number) Friction amount from 0 to 1
		 * @param	density (Number) Desity amount ( water is around 1, less for wood, greater for metals )
		 * @param	restitution (Number) The bounciness of the object from 0 to 1
		 */		
		public function createCircleShape( radius:int, friction:Number = 0.3, density:Number = 1, restitution:Number = 0.1 ):void
		{
			// Get the draw scale
			var scale:int = _physicsWorld.drawScale;
			
			// Create the shape
			var circleShape:b2CircleShape = new b2CircleShape(radius / scale);
			
			// Create the fixture
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = circleShape;
			fixtureDef.friction = friction;
			fixtureDef.density = density; 
			fixtureDef.restitution = restitution;
			
			// Add the game object to it
			fixtureDef.userData = _owner;

			// Attach to the body
			_body.CreateFixture(fixtureDef);
			
		}
		
		public function get body():b2Body { return _body; }
		
	}
}