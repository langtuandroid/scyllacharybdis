package examples.scene 
{
	import com.scyllacharybdis.core.memory.allocate;
	import com.scyllacharybdis.core.memory.deallocate;
	import com.scyllacharybdis.core.memory.MemoryManager;
	import com.scyllacharybdis.core.objects.BaseObject;
	import com.scyllacharybdis.core.objects.GameObject;
	import com.scyllacharybdis.core.scenegraph.SceneGraph;
	/**
	 */
	[Requires ("com.scyllacharybdis.core.scenegraph.SceneGraph")]
	public class SceneObject extends BaseObject
	{

		/****************************************/
		// Class Details
		/****************************************/
		
		private var _initialized:Boolean = false;
		private var _rootGameObject:GameObject;
		private var _sceneGraph:SceneGraph;

		/**
		 * The engine contructor
		 * @private
		 */
		public final override function engine_awake():void
		{
			if ( _initialized == true ) 
			{
				return;
			}
			_initialized = true;
			_rootGameObject = allocate( GameObject );
			_sceneGraph = getDependency(SceneGraph);
			
			super.engine_awake();
		}

		/**
		 * The engine start method
		 * @private
		 */
		public final override function engine_start():void
		{
			super.engine_start();
			_sceneGraph.addGameObjectToScene(_rootGameObject );
		}
		
		/**
		 * The engine stop function
		 * @private
		 */
		public final override function engine_stop():void
		{
			_sceneGraph.removeGameObjectToScene(_rootGameObject );
			super.engine_stop();
		}		

		/**
		 * Destroy is called at the removal of the object
		 * @private
		 */
		public final override function engine_destroy():void
		{
			deallocate( _rootGameObject );

			super.engine_destroy();
			
			_initialized = false;
		}

		/**
		 * Add game object to scene helper function.
		 * @param	gameObj
		 */
		protected function addToScene( gameObj:GameObject ):void
		{
			_rootGameObject.addChild( gameObj );
		}

		/**
		 * Remove game object from the scene helper function.
		 * @param	gameObj
		 */
		protected function removeFromScene( gameObj:GameObject ):void
		{
			_rootGameObject.removeChild( gameObj );
		}
	}
}