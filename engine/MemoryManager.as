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
		
		/**
		* Instantiate an object
		* @param Type (Class) The type of object to create
		*/
		public function Instantiate( type:Class,  param:Array ... ):type
		{
			var object:type = new type( param );

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
			if ( mSceneObjects.indexOf( object ) < 0 ) {
				trace("Object: " + object " wasn't created by the memory manager!" );
			}
			
			// Remove the object from the list
			mSceneObject.remove(object);

			// Let the object run its own destroy methods
			object.Destroy();
			
			// Delete the object ( should be replaced with a cache )
			delete object;
		}
		
		function FindSceneObjectByName( var name:String ): SceneObject
		{
			for (int i = 0; i < mSceneObjects.length(); i++) 
			{
				if ( mSceneObjects[i].name() == name) {
					return mSceneObjects[i];
				}
			}
			return null;
		}
	}
}