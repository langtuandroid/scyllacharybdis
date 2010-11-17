package core 
{
	import flash.utils.Dictionary;
	
	/**
	 * MemoryManager
	 */
	public class MemoryManager
	{
		// Create the object lists
		private static var _baseObjects:Dictionary = new Dictionary(true);
		private static var _singletonList:Dictionary = new Dictionary(true);
		private static var _objectCounters:Dictionary = new Dictionary(true);
		
		/**
		* Instantiate an object
		* @param type (Class) The type of object to create
		*/
		public static function instantiate( type:Class, dependencies:Array = null ):*
		{
			// Declare the object variable
			var obj:* = getObject(type);
			
			if ( dependencies != null )
			{
				// Create the dependencies
				var depMap:Dictionary = new Dictionary();
				
				// Loop through all the dependencies
				for each ( var dep:Class in dependencies ) 
				{
					// Add the deps to a dictionary
					depMap[dep] = instantiate(dep);
				}
				
				// Inject the dependencies
				obj.setDependencies(depMap);
			}
			
			// Increase the debugging counter
			incrementCounter(type);
			
			// Awaken the object
			obj.engine_awake();
			
			// Return the object
			return obj;
		}
		
		/**
		 * Destroy the scene object 
		 * @param object (SceneObject) The scene object to be destroyed
		 */
		public static function destroyObject( obj:* ): void 
		{
			// Check to see if its a singleton
			if ( (Object( obj ).constructor as Class).scope == BaseObject.SINGLETON_OBJECT )  
			{
				trace("Can't delete a singleton");
				return;
			}

			// Reduce the debugging counter
			decrementCounter( Object( obj ).constructor as Class );

			// Let the object run its own destroy methods
			obj.engine_destroy();
			
			// Remove the object from the list
			delete _baseObjects[obj];
		}
		
		/**
		 * Get the object counter
		 * @param type (Class) The class type
		 * @return int 
		 */
		public static function getObjectCount(type:Class):int
		{
			return _objectCounters[type];
		}		
		
		/**
		 * Get object helper function
		 * @param type (Class) Type of object to get
		 * @return object
		 */
		private static function getObject(type:Class):* 
		{
			var obj:*;
			
			if ( type.scope == BaseObject.SINGLETON_OBJECT ) 
			{ 
				// if there isn't an instance of the singleton
				if ( _singletonList[type] == null ) 
				{
					// Create the singleton
					_singletonList[type] = new type();
					
					// Add it to the base objects list
					_baseObjects[_singletonList[type]] = _singletonList[type];
				}
				
				// Set the object
				obj = _singletonList[type];
				
				// Return the object
				return obj;
			}
			else
			{
				// Create the object
				obj = new type();
				
				// Add the object to the base objects list
				_baseObjects[obj] = obj;
				
				return obj;
			}
		}
		
		/**
		 * Debugging Helper Function
		 * @param type (BaseObject) The created object
		 */
		private static function incrementCounter(type:Class):void
		{
			if ( type.scope == BaseObject.SINGLETON_OBJECT ) 
			{
				_objectCounters[type] = 1;
				return;
			}
			
			if ( ! _objectCounters[type] ) 
			{
				_objectCounters[type] = 0;
			}
			
			_objectCounters[type]++;
		}
		
		/**
		 * Debugging Helper Function
		 * @param type (BaseObject) The destroyed object
		 */
		private static function decrementCounter(type:Class):void
		{
			if ( type.scope == BaseObject.SINGLETON_OBJECT ) 
			{
				return;
			}
			
			_objectCounters[type]--;
			if ( _objectCounters[type] < 0 )
			{
				_objectCounters[type] == 0;
			}
		}
	}
}

