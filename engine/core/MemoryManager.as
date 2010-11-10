package core 
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import core.BaseObject;
	
	class MemoryManager extends BaseObject 
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
			object.dependencies(depMap);
			
			// Increase the debugging counter
			incrementCounter(type);
			
			// Awaken the object
			object.awake();
			
			// Return the object
			return object;
		}
		
		/**
		 * Destroy the scene object 
		 * @param object (SceneObject) The scene object to be destroyed
		 */
		public function destroy( obj:* ): void 
		{
			// Get the class details
			var details = _injector.description( getQualifiedClassName(object) );
			
			// Check to see if its a singleton
			if ( details.scope() == Description.SINGLETON_OBJECT )  
			{
				trace("Can't delete a singleton");
				return;
			}

			// Reduce the debugging counter
			decrementCounter( getQualifiedClassNameByObject(object) );

			// Let the object run its own destroy methods
			object.destroy();
			
			// Remove the object from the list
			delete _baseObjects[object];
			
			// Delete the object ( should be replaced with a cache )
			delete object;
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
			var obj:* = null;
			if ( details.scope() == Description.SINGLETON_OBJECT ) 
			{
				if ( ! _singletonList[type] ) 
				{
					obj = new type();
				}

				// Create the object
				_singletonList[type] = obj;
				return _singletonList[type];
			} 
			else 
			{
				// Create the object
				obj = new type();
				
				// Add it to the array
				_baseObjects[obj] = obj;
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
			if ( ! _objectCounters[type] ) {
				_objectCounters[type] = 0;
			}
			_objectCounters[type]++;
		}
		
		/**
		 * Debugging Helper Function
		 * @param type (BaseObject) The destroyed object
		 */
		private function decrementCounter(obj:BaseObject):void
		{
			if ( _objectCounters.size == 0 ) 
			{
				return;
			}
			
			_objectCounters[type]--;
		}
	}
}

