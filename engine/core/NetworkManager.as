package core 
{
	import flash.utils.Dictionary;
	import com.smartfoxserver.v2.SmartFox;

	import core.BaseObject;
	import handlers.ConnectionHandler;
	import handlers.LoginHandler;
	import handlers.RoomHandler;

	public class NetworkManager extends BaseObject
	{
		/****************************************/
		// Dependency Information
		/****************************************/

		/**
		 * Return the class scope
		 */
		public static function get scope():int { return SINGLETON_OBJECT };
		
		
		/****************************************/
		// Overide function
		/****************************************/
		
		private var _connectionHandler:ConnectionHandler;
		private var _loginHandler:LoginHandler;
		private var _roomHandler:RoomHandler;
		
		private var _sfs:SmartFox = new SmartFox(true);
		
		/**
		* Awake is called at the construction of the object
		*/
		public function Awake():void
		{
			_connectionHandler = getDependency(ConnectionHandler);
			_loginHandler = getDependency(LoginHandler);
			_roomHandler = getDependency(RoomHandler);
		}
		
		/**
		* Destroy is called at the removal of the object
		*/	
		public function Destroy():void
		{
			_connectionHandler = null;
			_loginHandler = null;
			_roomHandler = null;
		}
		
		/**
		 * Get the smartfox server
		 */
		public function get sfs():SmartFox { return _sfs; }
		
		/**
		 * Get the connection handler
		 */
		public function get connectionHandler():ConnectionHandler { return _connectionHandler; }
		
		/**
		 * Get the login handler
		 */
		public function get loginHandler():LoginHandler { return _loginHandler; }
		
		/**
		 * Get the room handler
		 */
		public function get roomHandler():RoomHandler { return _roomHandler; }		
		
		/** 
		 * Connect to the server
		 */
		public function connect():void
		{
			if ( _connectionHandler != null ) 
			{
				_connectionHandler.connect();
			}
		}
		
		/**
		 * Disconnect from the server
		 */
		private function disconnect():void
		{
			_connectionHandler.disconnect();
		}		
		
		/**
		 * Login to the server
		 * @param	userName (String) Users name
		 * @param	password (String) Users password
		 */
		public function login(userName:String, password:String):void
		{
			_loginHandler.login(userName, password);
		}

		/**
		* Join the passed room.
		*/
		public function joinRoom(name:String = "The Lobby"):void
		{
			_roomHandler.joinRoom(name);
		}		
		
		/**
		 * Create a game room
		 * 
		 * @param	roomName (String) Room name
		 * @param	roomPwd (String Room password
		 * @param	roomMaxS (int) Room Max size 
		 * @param	extensionId (String) The module name
		 * @param	extensionClass (String) The fully qualified class
		 */
		public function createGameRoom(roomName:String, roomPwd:String=null, roomMaxS:int=0, extensionId:String="sfsChess", extensionClass:String = "sfs2x.extensions.games.tris.SFSTrisGame"):void
		{
			_roomHandler.createGameRoom(roomName, roomPwd, roomMaxS, extensionId, extensionClass);
		}
		
		/**
		* Leave game and return them to the lobby
		* Join the lobby room. 
		*/
		private function leaveGameRoom():void
		{
			_roomHandler.leaveGameRoom();
		}		

		public function backToLoginScreen():void {}		
				
		/**
		 * Helper function for displaying errors
		 * @param	msg (String) The error message
		 */
		protected function dTrace(msg:String):void
		{
			trace ( "--> " + msg + "\n" );
			
			// Create view to print stuff too
			//ta_debug.text += "--> " + msg + "\n";
		}		
	}
}

