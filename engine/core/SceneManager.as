package core 
{
	import flash.utils.Dictionary;
	/**
	 */
	public final class SceneManager extends BaseObject
	{
		/**
		 * Return the class scope
		 */
		public static function get scope():int { return SINGLETON_OBJECT };
		
		// The stack of scenes
		private var _objectList:Dictionary = new Dictionary();
		private var _classStack:Array = new Array();

		/**
		 * Display a scene
		 * @param	scene (Class) SceneObject class to display
		 * @param   hide (Boolean) Hide the previous scene. Defaults to autohide.
		 */
		public function PushScene( sceneClass:Class, hide:Boolean=true ):void 
		{
			if ( _objectList[sceneClass] == null ) 
			{
				_objectList[sceneClass] = MemoryManager.instantiate(sceneClass);
			}
			
			var sceneCount:int = _classStack.length;
			if ( sceneCount > 0 && hide == true) 
			{
				var previous:Class = _classStack[sceneCount - 1];
				_objectList[previous].hide();
			}

			_objectList[sceneClass].show();
			_classStack.push(sceneClass);
		}
		/**
		 * Hide the scene
		 * @param	destroy (Boolean) Destroy the object. Default is false.
		 */
		public function PopScene(destroy:Boolean=false):void 
		{
			var sceneClass:Class = _classStack.pop();
			if ( sceneClass == null )
			{
				return;
			}
			var sceneObject:SceneObject = _objectList[sceneClass];
			sceneObject.hide();
			var previousClass:Class = _classStack[_classStack.length - 1];
			if ( previousClass != null ) {
				_objectList[previousClass].show();
			}
			
			if ( destroy ) 
			{
				_objectList[sceneClass] = null;
				MemoryManager.destroy( sceneObject );
			}
		}
		
		/**
		 * Hide all scenes until it gets to the right one
		 * @param	sceneClass
		 * @param	destroy
		 */
		public function PopToScene( sceneClass:Class, destroy:Boolean=false ):void
		{
			// Check to see if the object was found
			var found:Boolean = false;
			for ( var i:int = _classStack.length - 1; i > 0; i-- )
			{
				if ( _classStack[i] == sceneClass ) {
					found = true;
					break;
				}
			}

			// Was the class not found
			if ( ! found ) 
			{
				// Wasn't found so leave
				return;
			}
			
			// Unwind the stack
			for ( i = _classStack.length - 1; i > 0; i-- )
			{
				var sceneClass:Class = _classStack.pop();
				if ( _classStack[i] == sceneClass )
				{
					// Push it back on the list
					PushScene( sceneClass );
					return;
				} 
				
				// Get the scene object
				var sceneObject:SceneObject = _objectList[sceneClass];
				
				// Hide the scene
				sceneObject.hide();
				
				// Are we set to destroy
				if (destroy == true) 
				{
					// Destroy the object
					_objectList[sceneClass] = null;
					MemoryManager.destroy( sceneObject );
				}
			}
		}
		
		/**
		 * Switch scenes will pop the old scene and push a new one.
		 * @param	sceneClass
		 * @param	destroy
		 */
		public function SwitchScene( sceneClass:Class, destroy:Boolean=false  ):void 
		{
			// pop the old scene
			PopScene( destroy );
			
			// Push the new scene
			PushScene( sceneClass, destroy );
		}
	}
}
