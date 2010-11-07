package engine.core
{	
	import engine.components.RenderComponent;
	import flash.display.DisplayObjectContainer;
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
		public function renderWorld(surface:DisplayObjectContainer):void
		{
			// Display the renderables 
			for each ( var renderable:RenderComponent in SceneGraph.instance.renderables ) 
			{
				renderable.render(surface);
			}
		}
		
		/**
		 * Erase the world
		 * @param	surface (DisplayObjectContainer) The surface to erase
		 */
		public function eraseWorld( surface:DisplayObjectContainer ):void
		{
			for each ( var renderable:RenderComponent in SceneGraph.instance.renderables )
			{
				renderable.erase( surface );
			}
		}
	}
}