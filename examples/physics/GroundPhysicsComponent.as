package physics
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2BodyDef;
	import com.scyllacharybdis.components.CollisionComponent;
	import com.scyllacharybdis.components.RenderComponent;
	
	/**
	 */
	[Component (type="CollisionComponent")]
	public class GroundPhysicsComponent extends CollisionComponent
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
			createBody( 0, 500, false );
			createPolygonShape( 600, 10, 0.6, 1, 0.1 );
			if ( owner.getComponent(RenderComponent) != null ) 
			{
				owner.getComponent(RenderComponent).createBox(590, 20, 0x0000FF);
			}
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