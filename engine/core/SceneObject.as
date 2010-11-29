package core 
{
	/**
	 */
	public class SceneObject extends BaseObject
	{

		/****************************************/
		// Class Details
		/****************************************/
		
		protected var _initialized:Boolean = false;
		protected var _showing:Boolean = false;
		protected var _rootGameObject:GameObject;

		/**
		 * Initialize the scene memory
		 */
		public final override function engine_awake():void
		{
			if ( _initialized ) 
			{
				return;
			}
			
			_initialized = true;
			_rootGameObject = MemoryManager.instantiate( GameObject );
			
			super.engine_awake();
		}

		/**
		 * Start the core object
		 */
		public final override function engine_start():void
		{
			super.engine_start();
		}
		
		/**
		 * Stop the core object
		 */
		public final override function engine_stop():void
		{
			super.engine_stop();
		}		

		/**
		 * Destroy the scene memory
		 */
		public final override function engine_destroy():void
		{
			MemoryManager.destroy( _rootGameObject );

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