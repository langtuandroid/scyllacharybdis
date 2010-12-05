package components 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import core.PhysicsWorld;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	import core.BaseObject;
	import core.EventManager;

	/**
	 */
	public class PhysicsComponent extends BaseObject
	{
		/****************************************/
		// Type definition
		/****************************************/
		public override final function getType():String 
		{
			return PHYSICS_COMPONENT; 
		}		
		
		/****************************************/
		// Class Details
		/****************************************/

		private var _physicsWorld:PhysicsWorld;

		/** 
		 * Engine constructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			_physicsWorld = getDependency( PhysicsWorld );
			super.engine_awake();
		}
		
		/** 
		 * Engine start
		 * @private
		 */
		public final override function engine_start():void
		{
			super.engine_start();
		}

		/** 
		 * Engine stop
		 * @private
		 */
		public final override function engine_stop():void
		{
			super.engine_stop();
		}

		/** 
		 * Engine destructor
		 * @private
		 */
		public final override function engine_destroy():void
		{
			super.engine_destroy();
		}

		/**
		 * The users constructor. 
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
		}
		
		/**
		 * The users start method. 
		 * Start runs when the game object is added to the scene.
		 */
		public override function start():void
		{
		}

		/**
		 * The users stop method.
		 * Stop runs when the game object is added to the scene.
		 */
		public override function stop():void
		{
		}

		/**
		 * The users destructor. 
		 * Override destroy to clean up any variables or listeners.
		 */
		public override function destroy():void
		{
		}
		
		/**
		 * Create a polygon shape to represent all or part of the body
		 * @param	x (int) Set its x position in pixels
		 * @param	y (int) Set its y position in pixels
		 * @param	width (int) Width in pixels
		 * @param	height (int) Height in pixels
		 * @param	friction (Number) Friction amount from 0 to 1
		 * @param	density (Number) Desity amount ( set to 0 for static items )
		 * @param	restitution (Number) The bounciness of the object from 0 to 1
		 */
		public function createPolygonShape(x:int, y:int, width:int, height:int, friction:Number = 0.3, density:Number = 0, restitution:Number = 0.1):void
		{
			// Create the body definition
			var _bodyDef:b2BodyDef = new b2BodyDef();
			
			// Get the world scale
			var scale:int = _physicsWorld.drawScale;

			//Set its position in the world. 
			_bodyDef.position.Set(x / scale, y / scale);
			
			// Add the gameobject to it
			_bodyDef.userData = owner;

			// Create the shape
			var boxShape:b2PolygonShape = new b2PolygonShape();

			// Create the box shape
			boxShape.SetAsBox(width / scale, height / scale);
			
			// Create the fixture 
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxShape;
			fixtureDef.friction = friction;
			fixtureDef.density = density; 
			fixtureDef.restitution = restitution;

			// Add the game object to it
			fixtureDef.userData = owner;

			// Create the body
			var body:b2Body = _physicsWorld.world.CreateBody(_bodyDef);

			// Attach to the body
			body.CreateFixture(fixtureDef);	

			// Add the game object to it.
			body.SetUserData( owner );
			
			trace("Body Count: " + _physicsWorld.world.GetBodyCount() );
		}
		
		/**
		 * Create a circle shape to represent all or part of the body
		 * @param	x (int) Set its x position in pixels
		 * @param	y (int) Set its y position in pixels
		 * @param	radius (int) Radius of the circle in pixels
		 * @param	friction (Number) Friction amount from 0 to 1
		 * @param	density (Number) Desity amount ( water is around 1, less for wood, greater for metals )
		 * @param	restitution (Number) The bounciness of the object from 0 to 1
		 */		
		public function createCircleShape( x:int, y:int, radius:int, friction:Number = 0.3, density:Number = 0, restitution:Number = 0.1 ):void
		{
			
			// Create the body definition
			var _bodyDef:b2BodyDef = new b2BodyDef();
			
			// Get the world scale
			var scale:int = _physicsWorld.drawScale;

			//Set its position in the world. 
			_bodyDef.position.Set(x / scale, y / scale);
			
			// Add the gameobject to it
			_bodyDef.userData = owner;

			// Create the shape
			var circleShape:b2CircleShape = new b2CircleShape(radius / scale);

			// Create the circle
			circleShape.SetRadius( radius / scale );

			// Create the fixture
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = circleShape;
			fixtureDef.friction = friction;
			fixtureDef.density = density; 
			fixtureDef.restitution = restitution;

			// Add the game object to it
			fixtureDef.userData = owner;

			// Create the body
			var body:b2Body = _physicsWorld.world.CreateBody(_bodyDef);

			// Attach to the body
			body.CreateFixture(fixtureDef);	

			// Add the game object to it.
			body.SetUserData( owner );

			trace("Body Count: " + _physicsWorld.world.GetBodyCount() );
		}
		
	}
}