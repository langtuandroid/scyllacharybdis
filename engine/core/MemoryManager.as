package core 
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	
	import core.BaseObject;
	
	/**
	 * MemoryManager
	 */
	public class MemoryManager extends BaseObject 
	{

		// Create the object lists
		private var _baseObjects:Dictionary = new Dictionary();
		private var _singletonList:Dictionary = new Dictionary();
		private var _objectCounters:Dictionary = new Dictionary();
		
		/**
		* Instantiate an object
		* @param type (Class) The type of object to create
		*/
		public function instantiate( type:Class ):*
		{
			// Declare the object variable
			var obj:* = getObject(type);
			
			// Create the dependencies
			var depMap:Dictionary = new Dictionary();
			
			// Add the memory manager to the list
			depMap[MemoryManager] = this;

			// Loop through all the dependencies
			for each ( var dep:Class in obj.dependencies ) 
			{
				// Add the deps to a dictionary
				depMap[type] = getObject(dep);
			}
			
			// Inject the dependencies
			obj.dependencies(depMap);
			
			// Increase the debugging counter
			incrementCounter(type);
			
			// Awaken the object
			obj.awake();
			
			// Return the object
			return obj;
		}
		
		/**
		 * Destroy the scene object 
		 * @param object (SceneObject) The scene object to be destroyed
		 */
		public function destroyObject( obj:* ): void 
		{
			// Get the class details
			var details:* = BaseObject(getDefinitionByName(getQualifiedClassName(obj) ));
			
			// Check to see if its a singleton
			if ( details.scope == BaseObject.SINGLETON_OBJECT )  
			{
				trace("Can't delete a singleton");
				return;
			}

			// Reduce the debugging counter
			decrementCounter( details );

			// Let the object run its own destroy methods
			obj.destroy();
			
			// Remove the object from the list
			delete _baseObjects[obj];
		}
		
		/**
		 * Get the object counter
		 * @param type (Class) The class type
		 * @return int 
		 */
		public function getObjectCount(type:Class):int
		{
			return _objectCounters[type];
		}		
		
		/**
		 * Get object helper function
		 * @param type (Class) Type of object to get
		 * @return object
		 */
		private function getObject(type:Class):* 
		{
			var obj:*;
			
			if ( type.scope == BaseObject.SINGLETON_OBJECT ) 
			{
				if ( ! _singletonList[type] ) 
				{
					obj = new type();
				}

				// Create the object
				_singletonList[type] = obj;
				
				// Add object to the singleton list
				return _singletonList[type];
			} 
			else 
			{
				// Create the object
				obj = new type();
				
				// Add it to the array
				_baseObjects[obj] = obj;
				
				// Add object to the base objects
				return obj;
			}
			
			return null;
		}
		
		/**
		 * Debugging Helper Function
		 * @param type (BaseObject) The created object
		 */
		private function incrementCounter(type:Class):void
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
		private function decrementCounter(type:Class):void
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

