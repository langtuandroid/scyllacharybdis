package engine.core 
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.Dictionary;
	
	/**
	 */
	public class SceneGraph
	{

		/***********************************/
		// Singleton boilerplate
		/***********************************/
		public function SceneGraph( se:SingletonEnforcer ) 
		{
		}
		
		private static var _sInstance:SceneGraph = null;
		
		public static function get instance():SceneGraph 
		{
			if (_sInstance == null) 
			{
				_sInstance = new SceneGraph( new SingletonEnforcer() );
			}
			
			return _sInstance;
		}		
		/***********************************/

		// All the game object in the world
		private var _gameObjects:Dictionary = new Dictionary(true);
		private var _sortRequired:Boolean = true;
		
		
		// Caches of all the components
		private var _renderComponents:Dictionary = new Dictionary(true);
		private var _scriptComponents:Dictionary = new Dictionary(true);
		private var _networkComponents:Dictionary = new Dictionary(true);
		
		/**
		 * Updates all the components in the world
		 */
		public updateWorld(): void 
		{
			// How the fuck do I loop through this in flash
			for ( var key:Component in _networkComponents ) {
				// The key and value are both the object :)
				key.update()
			}
			for ( var key:Component in _scriptComponents ) {
				// The key and value are both the object :)
				key.update()
			}
			for ( var key:Component in _renderComponents ) {
				// The key and value are both the object :)
				key.update()
			}
		}
		
		/** 
		 * Add a scene object to the graph
		 */
		public addSceneObject( gameObj:GameObject ):void 
		{
			_sortRequired = true;
			_gameObjects[gameObj] = gameObj;
		}
		
		/** 
		 * Remove a scene object to the graph
		 */
		public removeSceneObject( gameObj:GameObject ): void
		{
			_sortRequired = true;
			delete _gameObjects[gameObj];
		}

		/**
		 * Added a component to the game object
		 */
		public addComponent( comp:Component ):void
		{
			_sortRequired = true;
			if ( comp.GetType() == RENDER_COMPONENT ) {
				_renderComponents[comp] = comp;
				return;
			}
			if ( comp.GetType() == SCRIPT_COMPONENT ) {
				_scriptComponents[comp] = comp;
				return;
			}
			if ( comp.GetType() == NETWORK_COMPONENT ) {
				_networkComponents[comp] = comp;
				return;
			}
			return;
		}
		
		/**
		 * Remove a component to the game object
		 */
		public removeComponent( comp:Component ):void
		{
			_sortRequired = true;
			if ( comp.GetType() == RENDER_COMPONENT ) {
				delete _renderComponents[comp];
				return;
			}
			if ( comp.GetType() == SCRIPT_COMPONENT ) {
				delete _scriptComponents[comp];
				return;
			}
			if ( comp.GetType() == NETWORK_COMPONENT ) {
				delete _networkComponents[comp];
				return;
			}
		}
		
		/**
		 * Get Renderables 
		 */
		public var getRenderables():Dictionary
		{
			// Check to see if anything has changed
			if ( _sortRequired == true ) {
				// Sort back to front ( bigger numbers are closer to the screen );
				renderables.sort( ZSort );
			}
			return _renderComponents;
		}

		/**
		 * ZSort sorts the renderables back to front
		 * @param	a (Point3d) 
		 * @param	b (Point3d)
		 */
		protected function ZSort(a:Point3d, b:Point3d) 
		{
			_sortRequired = false;
			if ( a.z() < b.z() ) {
				return -1;
			} else if ( a.z() > b.z() ) { 
				return 1;
			}
			return 0;
		}
		
	}
}
