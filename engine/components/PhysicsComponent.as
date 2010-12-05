package components 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
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
		private var _body:b2Body;

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
		 * Create the body of the object. The body is the whole object.
		 * @param	x (int) Width in pixels of the body
		 * @param	y (int) Height in pixels of the body
		 */
		public function createBodyDef(x:int, y:int):void
		{
			// Create the body definition
			var _bodyDef:b2BodyDef = new b2BodyDef();
			
			// Get the world scale
			var scale:int = _physicsWorld.drawScale;

			//Set its position in the world. 
			_bodyDef.position.Set(x / scale, y / scale);
			
			// Add the gameobject to it
			_bodyDef.userData = owner;

			// Create the body
			_body = _physicsWorld.world.CreateBody(_bodyDef);

			// Add the game object to it.
			_body.SetUserData( owner );

		}
		
		/**
		 * Create a polygon shape to represent all or part of the body
		 * @param	x (int) Width in pixels
		 * @param	y (int) Height in pixels
		 * @param	friction (Number) Friction amount from 0 to 1
		 * @param	density (Number) Desity amount ( set to 0 for static items )
		 * @param	restitution (Number) The bounciness of the object from 0 to 1
		 */
		public function createPolygonShape(x:int, y:int, friction:Number = 0.3, density:Number = 0, restitution:Number = 0.1):void
		{
			var boxShape:b2PolygonShape = new b2PolygonShape();
			var scale:int = _physicsWorld.drawScale;
			boxShape.SetAsBox(x / scale, y/scale);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxShape;
			fixtureDef.friction = friction;
			fixtureDef.density = density; 
			fixtureDef.restitution = restitution;

			// Add the game object to it
			fixtureDef.userData = owner;

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
		public function createCircleShape( radius:int, friction:Number = 0.3, density:Number = 0, restitution:Number = 0.1 ):void
		{
			var scale:int = _physicsWorld.drawScale;
			
			var circleShape:b2CircleShape = new b2CircleShape(radius / scale);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = circleShape;
			fixtureDef.friction = friction;
			fixtureDef.density = density; 
			fixtureDef.restitution = restitution;
			
			// Add the game object to it
			fixtureDef.userData = owner;

			// Attach to the body
			_body.CreateFixture(fixtureDef);
		}
		
	}
}