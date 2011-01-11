package components 
{
	import core.loaders.PhysicsResults;
	import core.loaders.XMLLoaderAction;
	/**
	 * ...
	 * @author 
	 */
	public class XMLCollisionComponent extends CollisionComponent
	{
		private var _body:String;
		
		public function loadPhysics( fileName:String, body:String=null)
		{
			_body = body;
			var task:AMITask = new AMITask( new XMLLoaderAction(fileName), new PhysicsResults(), this );
		}
		
		public function parseXML( data:* ):void
		{
			var results:String = _physics.parseBodies( data..physics );
		}

		/**
		 * Parse the physics bodies 
		 * @param	bodies
		 */
		public function parseBodies(bodies:XMLList):void 
		{
			trace("******************************");
			for each ( var body:XML in bodies..body )
			{
				trace();
				trace ("Body name: " + body.attribute("name") );
				trace ("Body dynamic: " + body.attribute("dynamtic") );
				for each ( var shape:XML in body..shape ) {
					if ( shape.attribute("type") == "circle" ) 
					{
						trace ("Shape type: " + shape.attribute("type") );
						trace ("Shape center: " + shape.attribute("center") );
						trace ("Shape radius: " + shape.attribute("radius") );
					} 
					else if ( shape.attribute("type") == "polygon" ) 
					{
						trace ("Shape type: " + shape.attribute("type") );
						trace ("Shape top: " + shape.attribute("top") );
						trace ("Shape left: " + shape.attribute("left") );
						trace ("Shape width: " + shape.attribute("width") );
						trace ("Shape height: " + shape.attribute("height") );
					}
					else
					{
						trace("Shape has to be a polygon or circle: " + shape.attributes() );
					}
					trace ("Shape friction: " + shape.attribute("friction") );
					trace ("Shape density: " + shape.attribute("density") );
					trace ("Shape restitution: " + shape.attribute("restitution") );
				}
			}
		}
		
	}
}