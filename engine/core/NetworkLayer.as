package engine.core
{
	import flash.utils.getQualifiedClassName;
	
	public class NetworkLayer
	{
		/***********************************/
		// Singleton boilerplate
		/***********************************/
		public function NetworkLayer( se:SingletonEnforcer ) 
		{
		}
		
		private static var _sInstance:RenderQueue = null;
		
		public static function get instance():NetworkLayer 
		{
			if (_sInstance == null) 
			{
				_sInstance = new NetworkLayer( new SingletonEnforcer() );
			}
			
			return _sInstance;
		}		
		/***********************************/
		
		
	}
}