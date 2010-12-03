package core 
{
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
		private var var _debug:Boolean;

		/**
		 * Initialize the scene memory
		 */
		public final override function engine_awake():void
		{
			super.engine_awake();
			
			// Define the gravity vector
			var gravity:b2Vec2 = new b2Vec2(0.0, 0.0);
			
			// Allow bodies to sleep
			var doSleep:Boolean = true;
			
			// Construct a world object
			_world= new b2World(gravity, doSleep);
			
			if ( _debug == true ) {
				// set debug draw
				var debugDraw:b2DebugDraw = new b2DebugDraw();
				debugDraw.SetSprite(this);
				debugDraw.SetDrawScale(30.0);
				debugDraw.SetFillAlpha(0.3);
				debugDraw.SetLineThickness(1.0);
				debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
				m_world.SetDebugDraw(debugDraw);
				m_world.DrawDebugData();			
			}
		}

		/**
		 * Start the core object
		 */
		public final override function engine_start():void
		{
			super.engine_start();

			// setup the timer
			_updateTimer.addEventListener(TimerEvent.TIMER, update);
			_updateTimer.start();
		}

		/**
		 * Update the physics model
		 * @param	event
		 */
		public final function engine_update(event:TimerEvent):void
		{
			m_world.Step(1/30, m_velocityIterations, m_positionIterations);
			
			// Go through body list and update sprite positions/rotations
			for (var bb:b2Body = m_world.GetBodyList(); bb; bb = bb.GetNext()){
				if (bb.GetUserData() is Sprite){
					var sprite:Sprite = bb.GetUserData() as Sprite;
					sprite.x = bb.GetPosition().x * 30;
					sprite.y = bb.GetPosition().y * 30;
					sprite.rotation = bb.GetAngle() * (180/Math.PI);
				}
			}				
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
	}
}

