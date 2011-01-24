package com.scyllacharybdis.components 
{
	import com.scyllacharybdis.core.ami.AMIHandler;
	import com.scyllacharybdis.core.ami.AMITask;
	import com.scyllacharybdis.core.loaders.XMLLoaderAction;
	import com.scyllacharybdis.core.loaders.XMLResults;
	
	/**
	 * ...
	 * @author 
	 */
	[Component (type="CollisionComponent")]
	[Requires ("com.scyllacharybdis.core.ami.AMIHandler")]
	public class XMLCollisionComponent extends CollisionComponent
	{
		private var _bodyName:String;
		private var _amihandler:AMIHandler;
		
		/**
		 * Engine contructor
		 */
		public override final function engine_awake():void
		{
			_amihandler = getDependency(AMIHandler);
		}
		
		/**
		 * Engine destructor
		 */
		public override final function engine_destroy():void
		{
			MemoryManager.destroy( _amihandler );
		}
		
		/**
		 * Load the physics information from an xml file
		 * @param	fileName (String) Filename of the xml file
		 * @param	bodyName (String) The body name that you are trying to load from the file
		 */
		public final function loadPhysics( fileName:String, bodyName:String):void
		{
			// Store the body name
			_bodyName = bodyName;
			
			// Dispatch the xml loader task
			_amihandler.dispatchTask( new AMITask( new XMLLoaderAction(fileName), new XMLResults(), this ) );
			
		}
		
		/**
		 * Parse the results from the load action
		 * @param	data
		 */
		public final function xmlLoadSuccess( data:* ):void
		{
			parseBodies( data..physics );
		}
		
		/**
		 * Handle the xml load failure
		 * @param	data
		 */
		public final function xmlLoadError( data:* ):void
		{
			trace( "xmlLoadError: " + data );
		}
		
		
		/**
		 * Parse the physics bodies 
		 * @param	bodies
		 */
		private final function parseBodies(bodies:XMLList):void 
		{
			trace("******************************");
			for each ( var body:XML in bodies..body )
			{
				var name:String = body.attribute("name");
				if ( name == _bodyName ) 
				{
					// Get the attributes
					var width:int = body.attribute("width");
					var height:int = body.attribute("height");
					var dynamtic:Boolean = body.attribute("dynamtic");
					
					// Create the physics body
					createBody( width, height, dynamtic );
					
					// Parse the shapes
					parseShapes( body..shape );
				}
			}
		}
		private final function parseShapes(shapes:XMLList):void 
		{
			for each ( var shape:XML in shapes ) 
			{
				// Get the global attributes
				var friction:Number = body.attribute("friction");
				var density:Number = body.attribute("density");
				var restitution:Number = body.attribute("restitution");
				
				if ( shape.attribute("type") == "circle" ) 
					{
						// Get the circle attributes
						var x:int = body.attribute("x");
						var y:int = body.attribute("y");
						var radius:int = body.attribute("radius");
						
						// Create the physics circle shape
						createCircleShape(radius, friction, density, restitution);
					} 
					else if ( shape.attribute("type") == "polygon" ) 
					{
						// Get the polygon attributes
						var top:int = body.attribute("top");
						var left:int = body.attribute("left");
						var width:int = body.attribute("width");
						var height:int = body.attribute("height");
						
						// Create the physics polygon shape
						createPolygonShape( width, height, friction, density, restitution);
					}
					else
					{
						trace("Shape has to be a polygon or circle: " + shape.attributes() );
					}

				}
			}
		}
		
	}
}