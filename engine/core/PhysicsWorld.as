package core 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 */
	public class PhysicsWorld extends BaseObject
	{

		/**
		 * Return the class scope
		 */
		public static function get scope():int { return SINGLETON_OBJECT };
		

		/****************************************/
		// Class Details
		/****************************************/
		
		private var _updateTimer:Timer = new Timer(1/30, 0); 
		private var _world:b2World;
		private var _debug:Boolean;
		
		// map pixels to meters ( 30 pixels = 1 meter );
		private var _drawScale:int = 30;
		private var _gravity:b2Vec2;		
		
		private var _velocityIterations:int = 10;
		private var _positionIterations:int = 10;

		/**
		 * Initialize the scene memory
		 */
		public final override function engine_awake():void
		{
			super.engine_awake();
			
			// Define the gravity vector
			gravity = new b2Vec2(0.0, 0.0);
			
			// Allow bodies to sleep
			var doSleep:Boolean = true;
			
			// Construct a world object
			_world = new b2World(gravity, doSleep);
			
		}

		/**
		 * Start the core object
		 */
		public final override function engine_start():void
		{
			super.engine_start();

			// setup the timer
			_updateTimer.addEventListener(TimerEvent.TIMER, engine_update);
			_updateTimer.start();
		}

		/**
		 * Update the physics model
		 * @param	event
		 */
		public final function engine_update(event:TimerEvent):void
		{
			_world.Step( 1 / 30, _velocityIterations, _positionIterations );
		}			
		/**
		 * Stop the core object
		 */
		public final override function engine_stop():void
		{
			super.engine_stop();
		}		

		/**
		 * Destroy the scene memory
		 */
		public final override function engine_destroy():void
		{
			super.engine_destroy();
		}
		
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
		 * Get the world gravity
		 */
		public function get gravity():b2Vec2 { return _gravity; }
		
		/**
		 * Set the world gravity
		 * @param gravity (beVec2) The gravity in a vector
		 */
		public function set gravity(value:b2Vec2):void 
		{
			_world.SetGravity(value);
			_gravity = value;
		}
		
		public function get velocityIterations():int { return _velocityIterations; }
		
		public function set velocityIterations(value:int):void 
		{
			_velocityIterations = value;
		}
		
		public function get positionIterations():int { return _positionIterations; }
		
		public function set positionIterations(value:int):void 
		{
			_positionIterations = value;
		}
	}
}

