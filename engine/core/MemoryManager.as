package engine.core 
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	class MemoryManager {
		
		private final var _injector:DependencyInjector;

		// Create the object lists
		private var _baseObjects:Dictionary = new Dictionary();
		private var _singletonList:Dictionary = new Dictionary();
		private var _objectCounters:Dictionary = new Dictionary();
		
		public function MemoryManager(injector:DependencyInjector) 
		{
				_injector = injector;
		}
		
		/**
		* Instantiate an object
		* @param type (Class) The type of object to create
		* @return type (Object) The object of the specified type
		*/
		public function instantiate( type:Class ):type
		{
			// Do we need a check to see if the type is BaseObject or an ancestor thereof?
			
			var object:type;
			
			// Get the class details
			var details = _injector.description(type);
			
			if ( details.scope() == SINGLETON_OBJECT ) 
			{
				if ( _singletonList[type] ) {
					return _singletonList[type];
				}
				else 
				{
					// Create the object
					object = new type();
					_singletonList[type] = object;
				}
			} 
			else 
			{
				// Create the object
				object = new type();
				// Add it to the array
				_baseObjects[object] = object;
			}

			// Inject the dependencies
			object.dependencies( _injector.dependencies(type) );
			
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
		public function destroy( object:BaseObject ): void 
		{
			// Get the class details
			var details = _injector.description( getQualifiedClassName(object) );
			if ( details.scope() == SINGLETON_OBJECT )  
			{
				trace("Can't delete a singleton");
				return;
			}

			// Reduce the debugging counter
			decrementCounter( getQualifiedClassName(object) );

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
		public function getObjectCount(type:Class):int;
		{
			return _objectCounters[type];
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

