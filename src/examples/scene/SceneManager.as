package examples.scene
{
	import com.scyllacharybdis.core.memory.allocate;
	import com.scyllacharybdis.core.memory.deallocate;
	import com.scyllacharybdis.core.memory.MemoryManager;
	import com.scyllacharybdis.core.objects.BaseObject;
	import flash.utils.Dictionary;
	/**
	 */
	[Singleton]
	public final class SceneManager extends BaseObject
	{
		/**
		 * The engine contructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			super.engine_awake();
		}
		
		/**
		 * The engine start method
		 * @private
		 */
		public final override function engine_start():void
		{
			super.engine_start();
		}

		/**
		 * The engine stop function
		 * @private
		 */
		public final override function engine_stop():void
		{
			super.engine_stop();
		}
		
		/**
		 * Destroy is called at the removal of the object
		 * @private
		 */
		public final override function engine_destroy():void
		{
			super.engine_destroy();
		}
		
		// The stack of scenes
		private var _objectList:Dictionary = new Dictionary();
		private var _classStack:Array = new Array();

		/**
		 * Display a scene
		 * @param	scene (Class) SceneObject class to display
		 * @param   hide (Boolean) Hide the previous scene. Defaults to autohide.
		 */
		public final function PushScene( sceneClass:Class, hide:Boolean=true ):void 
		{
			if ( _objectList[sceneClass] == null ) 
			{
				_objectList[sceneClass] = allocate(sceneClass);
			}
			
			var sceneCount:int = _classStack.length;
			if ( sceneCount > 0 && hide == true) 
			{
				var previous:Class = _classStack[sceneCount - 1];
				_objectList[previous].engine_stop();
			}

			_objectList[sceneClass].engine_start();
			_classStack.push(sceneClass);
		}
		/**
		 * Hide the scene
		 * @param	destroy (Boolean) Destroy the object. Default is false.
		 */
		public final function PopScene(destroy:Boolean=false):void 
		{
			var sceneClass:Class = _classStack.pop();
			if ( sceneClass == null )
			{
				return;
			}
			var sceneObject:SceneObject = _objectList[sceneClass];
			sceneObject.engine_stop();
			var previousClass:Class = _classStack[_classStack.length - 1];
			if ( previousClass != null ) {
				_objectList[previousClass].engine_start();
			}
			
			if ( destroy ) 
			{
				_objectList[sceneClass] = null;
				deallocate( sceneObject );
			}
		}
		
		/**
		 * Hide all scenes until it gets to the right one
		 * @param	sceneClass
		 * @param	destroy
		 */
		public final function PopToScene( sceneClass:Class, destroy:Boolean=false ):void
		{
			// Check to see if the object was found
			var found:Boolean = false;
			for ( var i:int = _classStack.length; i > 0; i-- )
			{
				if ( _classStack[i-1] == sceneClass ) {
					found = true;
					break;
				}
			}

			// Was the class not found
			if ( ! found ) 
			{
				trace("Class not found");
				// Wasn't found so leave
				return;
			}
			
			// Unwind the stack
			for ( i = _classStack.length; i > 0; i-- )
			{
				var scene:Class = _classStack.pop();
				if ( scene == sceneClass ) 
				{
					// Push it back on the list
					PushScene( sceneClass );
					return;
				} 
				
				// Get the scene object
				var sceneObject:SceneObject = _objectList[scene];
				
				// Hide the scene
				sceneObject.engine_stop();
				
				// Are we set to destroy
				if (destroy == true) 
				{
					// Destroy the object
					_objectList[sceneClass] = null;
					deallocate( sceneObject );
				}
			}
		}
		
		/**
		 * Switch scenes will pop the old scene and push a new one.
		 * @param	sceneClass
		 * @param	destroy
		 */
		public final function SwitchScene( sceneClass:Class, destroy:Boolean=false  ):void 
		{
			// pop the old scene
			PopScene( destroy );
			
			// Push the new scene
			PushScene( sceneClass, destroy );
		}
	}
}
