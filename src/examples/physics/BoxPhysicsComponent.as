package examples.physics
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2BodyDef;
	import com.scyllacharybdis.components.CollisionComponent;
	import com.scyllacharybdis.graphics.scenegraph.SceneGraph;
	
	/**
	 */
	public class BoxPhysicsComponent extends CollisionComponent
	{
		public function BoxPhysicsComponent( sceneGraph:SceneGraph )
		{
			super(sceneGraph);
		}
		
		public function createBox( x:int, y:int, width:int, height:int ):void
		{
			createBody(x, y, true);
			createPolygonShape(width, height, 1.0, 1, 0.2);
		}
		
		public function createCircle(x:int, y:int, radius:Number ):void
		{
			createBody(x, y, true);
			createCircleShape(radius, 1.0, 1, 0.2);
		}
	}
}