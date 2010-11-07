package engine.core 
{
	import flash.utils.getQualifiedClassName;
	
	class NetworkManager {
		
		/***********************************/
		// Singleton boilerplate
		/***********************************/
		public function NetworkManager( se:SingletonEnforcer ) 
		{
		}
		
		private static var _sInstance:NetworkManager = null;
		public static function get instance():NetworkManager 
		{
			if (_sInstance == null) 
			{
				_sInstance = new NetworkManager( new SingletonEnforcer() );
				_sInstance.awake();
			}
			
			return _sInstance;
		}		
		/***********************************/
		
		private var _sfs:SmartFox = new SmartFox(true);
		private var _connectionHandler = null;
		private var _roomHandler = null;
		
		/**
		 * Get the smartfox server
		 */
		public function get sfs():SmartFox { return _sfs; }
		
		public function get connectionHandler():void { return _connectionHandler; }
		public function set connectionHandler( handler:ConnectionHandler ):void
		{
			if ( _connectionHandler != null ) {
				MemoryManager.instance.destroy(_connectionHandler);
			}
			_connectionHandler = handler;
		}

		public function get roomHandler():void { return _roomHandler; }
		public function set roomHandler( handler:RoomHandler ):void
		{
			if ( _roomHandler != null ) {
				MemoryManager.instance.destroy(_roomHandler);
			}
			_roomHandler = handler;
		}
	}
}

final class SingletonEnforcer { }