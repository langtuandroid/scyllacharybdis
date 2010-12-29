package core.memory 
{
	import as3reflect.Type;
	import core.objects.BaseObject;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * MemoryManager
	 */
	[Singleton]
	public final class MemoryManager
	{
		
		/****************************************/
		// Class Details
		/****************************************/
		
		// Create the object lists
		private static var _baseObjects:Dictionary = new Dictionary(true);
		private static var _singletonList:Dictionary = new Dictionary(true);
		
		// Create the class parser
		private static var _classParser:DIClassParser = new DIClassParser();
		
		/**
		* Instantiate an object
		* @param type (Class) The type of object to create
		*/
		public static function instantiate( type:Class, owner:* = null ):*
		{
			trace( "instantiate: " + type );
			var classDetails:DIClassDetails = _classParser.loadClass( type );
			
			trace("creating object");
			// Declare the object variable
			var obj:* = createObject(classDetails);
			if (!(obj is BaseObject )) 
			{
				trace(type + " is not a baseobject");
				return new type();
			}		
			
			obj.setClassDetails(classDetails);
			var depList:Dictionary = classDetails.getDependencies();
			
			trace("checking for deps");
			if ( classDetails.getDependencies() != null && classDetails.getDependencyCount() > 0 )
			{
				// Create the dependencies
				var depMap:Dictionary = new Dictionary(true);
				
				trace("looping through deps");
				// Loop through all the dependencies
				for ( var key:String in classDetails.getDependencies() ) 
				{
					trace( "Key: " + key );
					// Get the class name
					var tempClass:Class = getDefinitionByName(key) as Class;
					
					trace ( "dependencies: " + tempClass );
					// Add the deps to a dictionary
					depMap[tempClass] = instantiate(tempClass);
				}
				trace("done looping through deps");
				
				// Inject the dependencies
				obj.setDependencies(depMap);
			}

			// Add the owner if there is one
			if ( owner ) {
				obj.owner = owner;
			}
			
			if ( obj.awaked != true ) 
			{
				// Awaken the object
				obj.engine_awake();
			}
			
			// Return the object
			return obj;
		}
		
		/**
		 * Destroy the scene object 
		 * @param object (SceneObject) The scene object to be destroyed
		 */
		public static function destroy( obj:* ): void 
		{
			// Let the object run its own destroy methods
			obj.engine_stop();
			obj.engine_destroy();
			
			// Remove the object from the list
			delete _baseObjects[obj];
		}
		
		/**
		 * Create the object helper function
		 * @param type (Class) Type of object to get
		 * @return object
		 */
		private static function createObject(type:DIClassDetails):* 
		{
			var obj:*;
			
			if ( type.singleton ) 
			{ 
				// if there isn't an instance of the singleton
				if ( _singletonList[type.className] == null ) 
				{
					// Create the singleton
					_singletonList[type.className] = new type.className;
					
					// Add it to the base objects list
					_baseObjects[ _singletonList[type.className] ] = _singletonList[type.className];
				}
				
				// Set the object
				obj = _singletonList[type.className];
				
				// Return the object
				return obj;
			}
			else
			{
				// Create the object
				obj = new type.className;
				
				// Add the object to the base objects list
				_baseObjects[obj] = obj;
				
				return obj;
			}
		}
	}
}

