package  
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2BodyDef;
	import components.PhysicsComponent;
	
	/**
	 */
	public class BoxPhysicsComponent extends PhysicsComponent
	{
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
		
		public function createBox( x:int, y:int ):void
		{
			createBodyDef(x, y);
			createPolygonShape(x, y, 1.0, 0.5, 0.2);
		}
		
		public function createCircle( radius:Number ):void
		{
			createBodyDef(radius, radius);
			createCircleShape(radius, 1.0, 0.5, 0.2);
		}
	}
}