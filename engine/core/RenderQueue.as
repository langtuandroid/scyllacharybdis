package engine.core
{
	import flash.utils.getQualifiedClassName;
	
	public class RenderQueue
	{
		/***********************************/
		// Singleton boilerplate
		/***********************************/
		public function RenderQueue( se:SingletonEnforcer ) 
		{
		}
		
		private static var _sInstance:RenderQueue = null;
		public static function get instance():RenderQueue 
		{
			if (_sInstance == null) 
			{
				_sInstance = new RenderQueue( new SingletonEnforcer() );
			}
			
			return _sInstance;
		}		
		/***********************************/

		/**
		 * Render the world
		 * @param	surface (DisplayObjectContainer) The surface for rendering
		 */
		public function RenderWorld(surface:DisplayObjectContainer):void
		{
			renderables:Dictionary = SceneGraph.Instance().getRenderables();
			
			// Display the renderables 
			for ( var key:Component in renderables ) 
			{
				// The key and value are both the object :)
				key.render( surface );
			}
		}
	}
}