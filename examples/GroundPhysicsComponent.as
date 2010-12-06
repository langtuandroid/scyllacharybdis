package  
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2BodyDef;
	import components.PhysicsComponent;
	import core.BaseObject;
	
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
			createBody( 600, 790 );
			createPolygonShape( 600, 10, 0.3, 0, 0 );
			if ( owner.getComponent(BaseObject.RENDER_COMPONENT) != null ) 
			{
				owner.getComponent(BaseObject.RENDER_COMPONENT).createBox(600, 10, 0x0000FF);
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