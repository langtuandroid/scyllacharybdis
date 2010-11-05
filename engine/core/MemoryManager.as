package engine.core 
{
	import flash.utils.getQualifiedClassName;
	
	class MemoryManager {
		
		/***********************************/
		// Singleton boilerplate
		/***********************************/
		public function MemoryManager( se:SingletonEnforcer ) 
		{
			
		}
		
		private static var _sInstance:MemoryManager = null;
		
		public static function get instance():MemoryManager 
		{
			if (_sInstance == null) 
			{
				_sInstance = new MemoryManager( new SingletonEnforcer() );
			}
			
			return _sInstance;
		}		
		/***********************************/

		private var _baseObjects:Array = new Array();
		private var _objectCounters:Array = new Array();
		
		/**
		* Instantiate an object
		* @param type (Class) The type of object to create
		* @return type (Object) The object of the specified type
		*/
		public function instantiate( type:Class ):type
		{
			// Do we need a check to see if the type is BaseObject or an ancestor thereof?
			
			// Create the object
			var object:type = new type();
			
			// Increase the debugging counter
			incrementCounter(object);

			// Add it to the array
			_baseObjects.push(object);
			
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
			// Reduce the debugging counter
			decrementCounter(object);
			
			// Remove the object from the list
			_baseObjects.remove(object);

			// Remove the object frmo the tree
			if ( object.parent != null ) 
			{
				object.parent.removeChild(object);
			}
			
			// Let the object run its own destroy methods
			object.destroy();
			
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
			return _objectCounters[ getQualifiedClassName( new type() )];
		}		
		
		/**
		 * Debugging Helper Function
		 * @param type (BaseObject) The created object
		 */
		private function incrementCounter(obj:BaseObject):void
		{
			_objectCounters[getQualifiedClassName( obj )]++;
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
			
			_objectCounters[getQualifiedClassName( obj )]--;
		}
	}
}

final class SingletonEnforcer { }