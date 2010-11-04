package Engine 
{
	class MemoryManager {
		
		/***********************************/
		// Singleton boilerplate
		/***********************************/
		private function MemoryManager() 
		{
		}
		
		private static var sInstance:MemoryManager;
		public static function Instance():MemoryManager {
			if (sInstance == null) {
				sInstance = new MemoryManager();
			}
			return instance;
		}		
		/***********************************/

		private var mBaseObjects:Array = new Array();
		private var mObjectCounters:Array = new Array();
		
		/**
		* Instantiate an object
		* @param Type (Class) The type of object to create
		* @return type of class to be created
		*/
		public function Instantiate( type:Class ):type
		{
			// Create the object
			var object:type = new type();
			
			// Increase the debugging counter
			IncrementCounter(object);

			// Add it to the array
			mSceneObjects.push(object);
			
			// Run Awake on the class
			object.Awake();
			
			// Return the object
			return object;
		}

		/**
		 * Destroy the scene object 
		 * @param object (SceneObject) The scene object to be destroyed
		 */
		public function Destroy( var object:SceneObject ): void 
		{
			// Reduce the debugging counter
			DecrementCounter(object);
			
			// Remove the object from the list
			mSceneObject.remove(object);

			// Remove the object frmo the tree
			if ( object.parent() ) {
				object.parent().removeChild(object);
			}
			// Let the object run its own destroy methods
			object.Stop();
			object.Destroy();
			
			// Delete the object ( should be replaced with a cache )
			delete object;
		}
		
		/**
		 * Get the object counter
		 * @param type (Class) The class type
		 * @return int 
		 */
		public function GetObjectCount(type:Class):int;
		{
			return mObjectCounters[type.GetType()];
		}		
		
		/**
		 * Debugging Helper Function
		 * @param type (BaseObject) The created object
		 */
		private function IncrementCounter(obj:BaseObject):void
		{
			if ( mObjectCounters.size == 0 ) {
				mObjectCounters.push( int );
				mObjectCounters.push( int );
				mObjectCounters.push( int );
				mObjectCounters.push( int );
			}
			mObjectCounters[obj.GetType()]++;
		}
		
		/**
		 * Debugging Helper Function
		 * @param type (BaseObject) The destroyed object
		 */
		private function DecrementCounter(obj:BaseObject):void
		{
			if ( mObjectCounters.size == 0 ) {
				return;
			}
			mObjectCounters[obj.GetType()]--;
		}
	}
}