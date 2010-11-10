package core 
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import di.DependencyInjector;
	import di.Description;
	
	class MemoryManager {
		
		private var _injector:DependencyInjector;

		// Create the object lists
		private var _baseObjects:Dictionary = new Dictionary();
		private var _singletonList:Dictionary = new Dictionary();
		private var _objectCounters:Dictionary = new Dictionary();
		
		public function MemoryManager( injector:DependencyInjector ):void 
		{
			_injector = injector;
		}
		
		/**
		* Instantiate an object
		* @param type (Class) The type of object to create
		* @param level (int) Count the dep levels to stop infiniate declarations
		*/
		public function instantiate( type:Class, level:int = 0):*
		{
			if ( level > 5 ) 
			{
				trace("Recursive instanciate!!!!!!!");
				return;
			}
			// Declare the object variable
			var object:*;
			
			// Get the class details
			var details = _injector.description(type);
			
			if ( details.scope() == Description.SINGLETON_OBJECT ) 
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

			// Create the dependencies
			var depMap:Dictionary = new Dictionary();
			for each ( var type:Class in _injector.dependencies(type) ) 
			{
				if ( _injector.description(type).scope == Description.SINGLETON_OBJECT ) {
					depMap[type] = _singletonList[type];
				} else {
					depMap[type] = instantiate(type, level++);
				}
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
		public function destroy( object:* ): void 
		{
			// Get the class details
			var details = _injector.description( getQualifiedClassName(object) );
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

