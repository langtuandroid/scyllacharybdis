package  
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2BodyDef;
	import components.PhysicsComponent;
	
	/**
	 */
	public class GroundPhysicsComponent extends PhysicsComponent
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
			// Defined in pixels
			var bodyDef:b2BodyDef = createBodyDef(300, 360);
			var boxShape:b2PolygonShape = CreatePolygonShape(710, 90, 0.3, 0, 0);
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
	}
}