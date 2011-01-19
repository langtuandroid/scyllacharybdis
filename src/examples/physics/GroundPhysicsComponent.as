package examples.physics
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2BodyDef;
	import com.scyllacharybdis.components.CollisionComponent;
	import com.scyllacharybdis.graphics.scenegraph.SceneGraph;
	import com.scyllacharybdis.interfaces.IRenderComponent;
	
	/**
	 */
	public class GroundPhysicsComponent extends CollisionComponent
	{
		public function GroundPhysicsComponent( graph:SceneGraph ):void
		{
			super( graph );
		}
		
		public override function awake(owner:*):void
		{
			// Defined in pixels
			createBody( 0, 500, false );
			createPolygonShape( 600, 10, 0.6, 1, 0.1 );
			if ( owner.getComponent(IRenderComponent) != null ) 
			{
				owner.getComponent(IRenderComponent).createBox(590, 20, 0x0000FF);
			}
		}
	}
}