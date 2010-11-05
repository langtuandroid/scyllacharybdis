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
		
		public function RenderWorld():void
		{
			renderables:Dictionary = SceneGraph.Instance().getRenderables();
			// Sort back to front ( bigger numbers are closer to the screen );
			renderables.sort( ZSort );
			
			// Display the renderables 
		}
		
		private function ZSort(a:Point3d, b:Point3d) 
		{
			if ( a.z() < b.z() ) {
				return -1;
			} else if ( a.z() > b.z() ) { 
				return 1;
			}
			return 0;
		}
	}
}